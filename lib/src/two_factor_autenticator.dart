import 'dart:math';
import 'dart:typed_data';
import 'package:base32/base32.dart';
import 'package:dart_otp/dart_otp.dart';

class TwoFactorAuthenticator {
  
  static final TwoFactorAuthenticator _singleton =
      TwoFactorAuthenticator._internal();

  factory TwoFactorAuthenticator() {
    return _singleton;
  }

  TwoFactorAuthenticator._internal();

  /// create a random key secret in Base32
  static String _generateRandomKeySecret() {
    final rand = Random.secure();
    final bytes = <int>[];

    for (var i = 0; i < 10; i++) {
      bytes.add(rand.nextInt(256));
    }
    return base32.encode(Uint8List.fromList(bytes));
  }

  ///key secret generate random
  String _keySecret = _generateRandomKeySecret();

  String get keySecret {
    return _keySecret;
  }

  ///Used this method if need set secret key create in your backend
  set keySecret(String keySecret) {
    this._keySecret = keySecret;
  }

  /// QR data with totp format
  String getDataFromQR(String userName, String appName,{String customKeyBase32}) {
    return "otpauth://totp/$userName?secret=${customKeyBase32 == null ? keySecret : customKeyBase32}&issuer=$appName";
  }

  /// Current code generate with secret key
  String getCurrentCode({String customKeyBase32}) {
    final totp = TOTP(secret: customKeyBase32 == null ? keySecret : customKeyBase32, interval: 30, digits: 6);
    return totp.now();
  }

  /// Verify current code with the code entered by the user
  bool verifyCode(String code,{String customKeyBase32}) {
    final totp = TOTP(secret: customKeyBase32 == null ? keySecret : customKeyBase32, interval: 30, digits: 6);
    return totp.verify(otp: code);
  }
}
