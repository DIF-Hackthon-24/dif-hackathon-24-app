/*
 * Swiss Safe AG - swiss-safe-lock
 * Project for DIF Hackathon 2024
 * Author: Michal Jarmolkowicz
 * Contact: info@swisssafe.com
 * Website: www.swisssafe.com
 * 
 * This is a demonstration of how to use widely used open and popular tools
 * and standards for Verifiable Credentials (VCs) for seamless access control.
 * This approach is fully compatible with a number of popular SSI ecosystems,
 * is able to reuse already existing credentials in popular and open formats.
 * It demonstrates some additional capabilities that it adds, by allowing for
 * offline use, auto launch of app when lock is touched, advanced transmission
 * optimization options for faster operation, without the need for reissuance.
 * 
 * This is not the full set of capabilities that are possible. To discuss
 * availability of a wider set of features, support for multiple devices, platforms,
 * frameworks, advanced features, production-grade code and support,
 * please contact the author.
 * 
 * This software was developed solely for demonstration purposes related to
 * the DIF Hackathon 2024 and is not designed or intended for use in
 * production environments.
 * 
 * Rules and rights acording to:
 * https://difhackathon2024.devpost.com/rules
 */

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class SwissSafeLockNfc {
  static final String _BANNER =
      "╔═══════════════╗\n║   Swiss Safe Lock NFC  ║\n╚═══════════════╝\n\n";

  static final bool _DIAGNOSTIC_MODE = false;

  static final SwissSafeLockNfc _singleton = SwissSafeLockNfc._internal();

  // Return singleton
  factory SwissSafeLockNfc() => _singleton;

  // Private constructor
  SwissSafeLockNfc._internal() {
    _credentialTypeToDocuments = {};
    _loadCredentialsList();
  }

  late Map<String, List<String>> _credentialTypeToDocuments;

  void _decodeWalletCredentials(List<dynamic> credentialsList) {
    _credentialTypeToDocuments = {};

    for (var item in credentialsList) {
      String jwtToken = item['document'];
      try {
        Map<String, dynamic> payload = JwtDecoder.decode(jwtToken);
        List<dynamic> types = payload['vc']['type'];

        for (var type in types) {
          if (!_credentialTypeToDocuments.containsKey(type)) {
            _credentialTypeToDocuments[type] = [];
          }
          _credentialTypeToDocuments[type]!.add(jwtToken);
        }
      } catch (e) {
        print('Error decoding JWT: $e');
      }
    }
  }

  Future<void> updateCredentialsList(List<dynamic> credentialsList) async {
    _decodeWalletCredentials(credentialsList);
    _saveCredentialsList(credentialsList);
  }

  Future<void> _saveCredentialsList(List<dynamic> credentialsList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(credentialsList);
    await prefs.setString('credentialsList', jsonString);
  }

  Future<void> _loadCredentialsList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('credentialsList');
    if (jsonString != null) {
      List<dynamic> credentialsList = jsonDecode(jsonString);
      _decodeWalletCredentials(credentialsList);
    }
  }

  String _credentialByType(String type) {
    if (_credentialTypeToDocuments.containsKey(type)) {
      return _credentialTypeToDocuments[type]!.first;
    } else {
      return "";
    }
  }

  bool scanning = false;

  Future<void> scanToggle() async {
    if (scanning) {
      _toast("Turning NFC reader off");
    } else {
      _toast("Turning NFC reader on");
    }
    scanning = !scanning;
    _scan();
  }

  Future<void> _scan() async {
    while (scanning) {
      try {
        if (_DIAGNOSTIC_MODE) {
          _toast("Reading VC request ...");
        }
        String request = await _readRequestFromSwissSafeLock();
        if (request.isEmpty) {
          continue;
        } else {
          Uri requestUri = Uri.parse(request);
          String requestAuthority = requestUri.authority;
          String requestedType = requestUri.queryParameters['type'] ?? "";

          String credential = _credentialByType(requestedType);
          if (credential.isEmpty) {
            if (_DIAGNOSTIC_MODE) {
              _toast(
                  'Requested VC type:\n\n$requestedType\n\nFrom:\n$requestAuthority\n\nNo match found in wallet.');
            } else {
              _toast('No matching key:\n\n$requestedType');
            }
            continue;
          } else {
            String credentialPart = credential.substring(0, 20);
            if (_DIAGNOSTIC_MODE) {
              _toast(
                  'Requested VC type:\n\n$requestedType\n\nFrom:\n$requestAuthority\n\nSending:\n$credentialPart...');
            } else {
              _toast('Presenting room key:\n\n$requestedType');
            }
            await _sendResponseToSwissSafeLock(credential);
            if (_DIAGNOSTIC_MODE) {
              _toast('Sent VC:\n\n$requestedType');
            } else {
              _toast('Door opening');
            }
            continue;
          }
        }
      } catch (e) {
        if (_DIAGNOSTIC_MODE) {
          _toast('Error:\n\n$e');
        }
        await FlutterNfcKit.finish();
      }
    }
    await FlutterNfcKit.finish();
  }

  Future<String> _readRequestFromSwissSafeLock() async {
    String requestString;
    await FlutterNfcKit.finish();
    await FlutterNfcKit.poll(timeout: Duration(seconds: 3));
    var ndefRecords = await FlutterNfcKit.readNDEFRecords();
    if (ndefRecords.isNotEmpty) {
      if (ndefRecords.first.payload != null) {
        requestString = utf8.decode(ndefRecords.first.payload!);
        if (requestString.startsWith('\u0004')) {
          requestString = "https://" + requestString.substring(1);
        }
        if (requestString.startsWith("https://swisssafe.com/lock")) {
          return requestString;
        }
      }
    }
    return "";
  }

  Uint8List _createSwissSafeLockResponse(String response) {
    return Uint8List.fromList(GZipEncoder().encode(Uint8List.fromList(response
            .split('.')
            .map((p) => base64Url.decode(base64Url.normalize(p)))
            .expand((e) => e)
            .toList())) ??
        []);
  }

  Future<void> _sendResponseToSwissSafeLock(String response) async {
    await FlutterNfcKit.writeNDEFRecords([
      ndef.ExternalRecord(
          decodedType: "com.swisssafe:lock",
          payload: _createSwissSafeLockResponse(response)),
    ]);
  }

  static void _toast(String message) {
    Fluttertoast.showToast(
      msg: _BANNER + message + "\n",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 28.0,
    );
  }
}
