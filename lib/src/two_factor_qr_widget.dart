import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:two_factor_login/src/two_factor_autenticator.dart';

class QR2AuthenticatorFactor extends StatefulWidget {

  final double size;
  final String userName, appName;
  final Function(String) onKeySecret;

  QR2AuthenticatorFactor({
    @required this.size,
    @required this.userName,
    @required this.appName,
    @required this.onKeySecret});

  @override
  _QR2AuthenticatorFactorState createState() => _QR2AuthenticatorFactorState();
}

class _QR2AuthenticatorFactorState extends State<QR2AuthenticatorFactor> {

  TwoFactorAuthenticator authenticator;
  
  @override
  void initState() {
    super.initState();
    authenticator = TwoFactorAuthenticator();
    widget.onKeySecret(authenticator.keySecret);
  }

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: authenticator.getDataFromQR(widget.userName, widget.appName),
      version: QrVersions.auto,
      size: widget.size,
      gapless: false,
    );
  }
}
