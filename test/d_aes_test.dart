import 'package:d_encrypt/d_encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('AES implementation', () {
    late DAes aes;

    setUp(() {
      aes = DAes('12345678901234567890123456789012');
    });

    test('encryption', () async {
      const message = 'Message';
      final encrypted = await aes.encrypt(message);
      expect(message != encrypted, true);
    });

    test('decryption', () async {
      const message = 'Message';
      final encrypted = await aes.encrypt(message);
      final decrypted = await aes.decrypt(encrypted);
      expect(message, decrypted);
    });
  });
}
