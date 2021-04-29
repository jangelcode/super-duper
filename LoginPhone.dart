import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'PhoneCode.dart';

class LoginPhone extends StatefulWidget {
  @override
  _LoginPhoneState createState() => new _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  MaskedTextController controllerPhone = new MaskedTextController(mask: '+1(000)000-0000');

  String phoneNo;
  String smsOTP;
  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> smsOTPDialog(BuildContext context) {
  return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                Container()
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('Signed in');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential credential) {
      print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

    signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/homepage');
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Center(
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                  ),
                  AutoSizeText('Phone Login',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                  ),
                  AutoSizeText('Enter your 10 digit phone number',
                      style:TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    controller: controllerPhone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (value) {
                    this.phoneNo = value;
                  },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue),
                    height: 50,
                    width: 200,
                    child:RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),),
                      child: Text('Next',style: TextStyle(color:Colors.white,)),
                      color: Colors.blue[400],
                      elevation: 5,
                      onPressed:(){verifyPhone();},))
                ]
              ),
            )
          )
        ]
      )
    );
  }
}
