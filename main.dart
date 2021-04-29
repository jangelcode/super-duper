import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/ProfileView.dart';

import 'Home.dart';
import 'SignUp.dart';
import 'AddProfilePic.dart';
import 'Groups.dart';
import 'Profile.dart';
import 'Personality.dart';
import 'Interests.dart';
import 'LoginPhone.dart';
import 'PhoneCode.dart';
import 'ChatScreen.dart';
import 'CreateNewGroup.dart';
import 'ProfileView.dart';
import 'Chats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  final baseColors = ColorSwatch(0xFF00fffa, {
    'regular': Color(0xFF00fffa),
    'light': Color(0xFF71ffff),
    'dark': Color(0xFF00cbc7),
    'good_one': Color(0xFF26c6da)
  });

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/arts_and_entertainment.png'), context);
    precacheImage(AssetImage('assets/PLAZZA.png'), context);
    precacheImage(AssetImage('assets/Business.png'), context);
    precacheImage(AssetImage('assets/Cars.png'), context);
    precacheImage(AssetImage('assets/Computers.png'), context);
    precacheImage(AssetImage('assets/Cooking.png'), context);
    precacheImage(AssetImage('assets/Fitness.png'), context);
    precacheImage(AssetImage('assets/Food_&_Drink.png'), context);
    precacheImage(AssetImage('assets/Home_&_Garden.png'), context);
    precacheImage(AssetImage('assets/Outdoor_Activities.png'), context);
    precacheImage(AssetImage('assets/Partying.png'), context);
    precacheImage(AssetImage('assets/Pets.png'), context);
    precacheImage(AssetImage('assets/sports.png'), context);
    precacheImage(AssetImage('assets/travel.png'), context);
    precacheImage(AssetImage('assets/VideoGames.png'), context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Plazza Demo',
        theme: ThemeData(
          primaryColor: baseColors['regular'],
        ),
        home: Builder(
            builder: (context) => Scaffold(
                  body: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: const Text('Home'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Home');
                            }),
                        FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: const Text('Add Profile Pic'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/AddProfilePic');
                            }),
                        FlatButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            child: const Text('Sign Up'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/SignUp');
                            }),
                        FlatButton(
                            color: Colors.grey,
                            textColor: Colors.white,
                            child: const Text('Chats'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Chats');
                            }),
                        FlatButton(
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: const Text('Profile'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Profile');
                            }),
                        FlatButton(
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: const Text('Profile_view'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ProfileView');
                            }),    
                        FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: const Text('Personality'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Personality');
                            }),
                        FlatButton(
                            color: Colors.indigo,
                            textColor: Colors.white,
                            child: const Text('Interests'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/Interests');
                            }),
                        FlatButton(
                            color: Colors.purple,
                            textColor: Colors.white,
                            child: const Text('Phone Login'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/PhoneLogin');
                            }),
                        FlatButton(
                            color: Colors.pink,
                            textColor: Colors.white,
                            child: const Text('Phone Code'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/PhoneCode');
                            }),
                        FlatButton(
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: const Text('Chat Screen'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ChatScreen');
                            }),
                        FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: const Text('Create Group'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/CreateNewGroup');
                            }),
                      ])),
                )),
        routes: {
          '/Home': (context) => Home(),
          '/AddProfilePic': (context) => AddProfilePic(),
          '/SignUp': (context) => SignUp(),
          '/Chats': (context) => Chats(),
          '/Profile': (context) => Profile(),
          '/Personality': (context) => Personality(),
          '/Interests': (context) => Interests(),
          '/PhoneLogin': (context) => LoginPhone(),
          '/PhoneCode': (context) => PhoneCode(),
          '/ChatScreen': (context) => ChatScreen(),
          '/CreateNewGroup': (context) => CreateNewGroup(),
          '/ProfileView': (context) => ProfileView(),
        });
  }
}
