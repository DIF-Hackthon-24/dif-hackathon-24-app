/*
 * Demonstration of VC capabilites over NFC
 * for DIF Hackathon 2024, by Swiss Safe AG
 * www.swisssafe.com
 *
 * This software is provided "as is", without warranty of any kind and
 * is not meant for production use.
 */

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

class NfcService {
  static final NfcService _singleton = NfcService._internal();

  // Return singleton
  factory NfcService() => _singleton;

  // Private constructor
  NfcService._internal() {
    credentialTypeToDocuments = {};
  }

  late Map<String, List<String>> credentialTypeToDocuments;

  void decodeWalletCredentials(List<dynamic> credentialsList) {
    credentialTypeToDocuments = {};

    for (var item in credentialsList) {
      String jwtToken = item['document'];
      try {
        Map<String, dynamic> payload = JwtDecoder.decode(jwtToken);
        List<dynamic> types = payload['vc']['type'];

        for (var type in types) {
          if (!credentialTypeToDocuments.containsKey(type)) {
            credentialTypeToDocuments[type] = [];
          }
          credentialTypeToDocuments[type]!.add(jwtToken);
        }
      } catch (e) {
        print('Error decoding JWT: $e');
      }
    }
  }

  String credential(String type) {
    if (credentialTypeToDocuments.containsKey(type)) {
      return credentialTypeToDocuments[type]!.first;
    } else {
      return "";
    }
  }

  Future<String> readNfc() async {
    String nfcString = "";
    await FlutterNfcKit.poll(timeout: Duration(seconds: 5));
    var ndefRecords = await FlutterNfcKit.readNDEFRecords();
    if (ndefRecords.isNotEmpty) {
      if (ndefRecords.first.payload != null) {
        nfcString = utf8.decode(ndefRecords.first.payload!);
        if (nfcString.startsWith('\u0001')) {
          nfcString = nfcString.substring(1);
        }
      }
      await FlutterNfcKit.finish();
      return nfcString;
    }
    return "";
  }

  Future<void> writeNfc(String stringToWrite) async {
    await FlutterNfcKit.poll(timeout: Duration(seconds: 5));
    await FlutterNfcKit.writeNDEFRecords(
        [ndef.UriRecord.fromString(stringToWrite)]);
    await FlutterNfcKit.finish();
  }
}
