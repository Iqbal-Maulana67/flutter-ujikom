import 'package:encrypt/encrypt.dart';

class MyEncryptionDecryption {
  //For AES Encryption/Decryption
  static final key = Key.fromSecureRandom(32);
  static final iv = IV.fromSecureRandom(16);

  static encryptAES(text) {
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted;
  }

  static decryptAES(text) {
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(text, iv: iv);
    print(decrypted);
    return decrypted;
  }
}
