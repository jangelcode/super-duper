import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:
      Padding(padding: EdgeInsets.all(30),
        child:Column(
          children:<Widget>[
            Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*.15),
            child: new Padding(
              padding: EdgeInsets.all(40.0),
              child: new Image.asset('assets/PLAZZA.png'),
              )
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),),
                color: Colors.blue[600],
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10),
                  child:
                      Center(child:Text('Create New Account',style: TextStyle(color: Colors.white),)),
                ),
                onPressed:(){Navigator.pushNamed(context, '/Login');},
              )
            ),
            Padding(padding: EdgeInsets.only(top: 5),),
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
              )
            )
          ]
        ),
      )
    );
  } 
}

