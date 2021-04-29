import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SignUp extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listener;
  FirebaseUser _currentUser;
  var controllerDOB = new MaskedTextController(mask: '00/00/0000');
  var controllerPhone = new MaskedTextController(mask: '(000) 000-0000');

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  void _checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);
    _listener = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  bool obscure=true;

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return new Scaffold(
        appBar: AppBar(
          //title: Padding(child:Text('Sign Up',style: TextStyle(fontSize: 26,fontWeight: FontWeight.normal)),padding: EdgeInsets.only(top: 10),),
          backgroundColor: Colors.white,
          elevation: 0,
          ),
        body:
          SignInScreen(
            color: Colors.white,
            showBar: false,
            avoidBottomInset: true,
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Center(child:Text('Sign Up',style: TextStyle(fontSize: 26),)),
                Padding(padding: EdgeInsets.only(top: 0),),
                Padding(child:Text('Name'),padding: EdgeInsets.only(left: 5)),
                TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    //hintText: 'Name',
                    ),
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Padding(child:Text('Phone Number'),padding: EdgeInsets.only(left: 5)),
                TextField(
                    controller: controllerPhone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    //hintText: 'Phone Number',
                    ),
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Padding(child:Text('Date of Birth'),padding: EdgeInsets.only(left: 5)),
                TextField(
                    keyboardType: TextInputType.number,
                    controller: controllerDOB,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: '00/00/0000'
                    ),
                ),
                Padding(padding: EdgeInsets.only(top: 20),),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue,
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child:
                          Text('Done',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    onPressed:(){Navigator.pushNamed(context, '/Register');},
                  )
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal: 10),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Already a Member? '),
                          Text('Sign in',style: TextStyle(color: Colors.blue),)
                        ]
                      )
                    ),
                  onTap:(){Navigator.pushNamed(context, '/PhoneLogin');},
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Center(child:Text('Or')),
                Padding(padding: EdgeInsets.only(top: 10),)
              ]
            ),
            providers: [
              ProvidersTypes.google,
              ProvidersTypes.facebook
            ],
          )
        );
      } 
    else {
      return new HomeScreen(user: _currentUser);
    }
  }
}

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;
  HomeScreen({this.user});
  @override
  Widget build(BuildContext context) => new Scaffold(
  );
  void _logout() {
    FirebaseAuth.instance.signOut();
  }
}
