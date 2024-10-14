import 'dart:typed_data';

import 'package:core/encryption/i_encryption.dart';
import 'package:encrypt/encrypt.dart';

class Encryption implements IEncryption {
  late Encrypter _encrypter;
  late IV _iv;

  Encryption(List<int> secret) {
    final random = Uint8List.fromList(secret);

    final key = Key(random);
    _iv = IV(random);

    _encrypter = Encrypter(AES(key));
  }

  @override
  String encrypt(String input) {
    return _encrypter.encrypt(input, iv: _iv).base64;
  }

  @override
  String decrypt(String input) {
    return _encrypter.decrypt(Encrypted.fromBase64(input), iv: _iv);
  }
}
