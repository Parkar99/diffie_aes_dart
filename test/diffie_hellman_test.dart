import 'package:d_encrypt/d_encrypt.dart';
import 'package:test/test.dart';

void main() {
  group('Test Diffie Hellman', () {
    late DiffieHellman alice;
    late DiffieHellman bob;
    setUpAll(() {
      alice = DiffieHellman(privateKeyLength: 64);
      bob = DiffieHellman(privateKeyLength: 64);
    });

    test('Test symmetric key generated is equal', () {
      final a = alice.getSymmetricKeyFor(bob.publicKey);
      final b = bob.getSymmetricKeyFor(alice.publicKey);

      expect(a, b);
    });

    test('hashed private key length is 32', () async {
      final hashedPrivateKey = await DiffieHellman.hashedSymmetricKey(
        alice.getSymmetricKeyFor(bob.publicKey),
      );
      expect(hashedPrivateKey.length, 32);
    });
  });
}
