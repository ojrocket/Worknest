```dart
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EncryptionService {
  static final _key = encrypt.Key.fromUtf8('my32charactertestingkey12345678'); 
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  /// Encrypts a message using AES-256
  static String encryptMessage(String plainText) {
    if (plainText.isEmpty) return plainText;
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypts a message using AES-256
  static String decryptMessage(String encryptedText) {
    if (encryptedText.isEmpty) return encryptedText;
    try {
      return _encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      return "Decryption Error";
    }
  }

  /// Generates a SHA-256 hash for verification (optional)
  static String hash(String text) {
    var bytes = utf8.encode(text);
    return sha256.convert(bytes).toString();
  }
}
