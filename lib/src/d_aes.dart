import 'dart:convert';

import 'package:cryptography/cryptography.dart';

class DAes {
  late final SecretKey _secretKey;

  // final _algorithm = AesCbc.with256bits(macAlgorithm: Hmac.sha256());
  final _algorithm = AesGcm.with256bits();

  DAes(String secretKey) : assert(secretKey.length == 32) {
    _secretKey = SecretKey(secretKey.codeUnits);
  }

  Future<String> decrypt(String encrypted) async {
    final data = encrypted.codeUnits;
    final sb = SecretBox(
      data.sublist(12, data.length - 16),
      nonce: data.sublist(0, 12),
      mac: Mac(data.sublist(data.length - 16)),
    );
    return utf8.decode(await _algorithm.decrypt(
      sb,
      secretKey: _secretKey,
    ));
  }

  Future<String> encrypt(String message) async {
    final sb = await _algorithm.encrypt(
      utf8.encode(message),
      secretKey: _secretKey,
    );
    return String.fromCharCodes(sb.concatenation());
    // return '${String.fromCharCodes(sb.cipherText)}::${String.fromCharCodes(sb.nonce)}::${String.fromCharCodes(sb.mac.bytes)}';
  }
}
