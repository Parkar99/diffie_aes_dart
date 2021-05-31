import 'package:d_encrypt/d_encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('encryption with keys', () {
    late final DiffieHellman alice;
    late final DiffieHellman bob;
    late final DAes aaes;
    late final DAes baes;

    setUpAll(() {
      alice = DiffieHellman();
      bob = DiffieHellman();
    });

    test('encrypt and decrypt', () async {
      const message = 'Hello encryption';

      final akey = alice.getSymmetricKeyFor(bob.publicKey);
      final bkey = bob.getSymmetricKeyFor(alice.publicKey);
      aaes = DAes(await DiffieHellman.hashedSymmetricKey(akey));
      baes = DAes(await DiffieHellman.hashedSymmetricKey(bkey));
      final encrypted = await aaes.encrypt(message);
      expect(message, isNot(encrypted));
      final decrypted = await baes.decrypt(encrypted);
      expect(message, equals(decrypted));
    });
  });
}
