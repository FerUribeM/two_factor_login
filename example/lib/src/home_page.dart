import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two_factor_login/two_factor_login.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String mySecretKey = "";
  final key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(title: Text('2FA Login'),),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text('2FA EXAMPLE', style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19
              ),),
            ),
            QR2AuthenticatorFactor(
              appName: 'FerTest2FA',
              userName: 'FernandoU',
              size: 100,
              onKeySecret: (mySecretKey) {
                setState(() {
                  this.mySecretKey = mySecretKey;
                });
                print('This is my secret key $mySecretKey');
              },
            ),
            Text('Escenea o registra este código'),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(mySecretKey),
                  SizedBox(width: 10,),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          Clipboard.setData(new ClipboardData(text: mySecretKey));
                          key.currentState.showSnackBar(new SnackBar(content: new Text("Copied to Clipboard"),));
                        },
                          child: Icon(Icons.copy)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
