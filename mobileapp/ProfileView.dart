import 'package:flutter/material.dart';
import 'package:mobile/Groups.dart';
import 'package:mobile/Profile.dart';

class MySlide extends MaterialPageRoute{

MySlide({WidgetBuilder builder, RouteSettings settings})
  :super(builder: builder, settings: settings);

@override 
Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child,
  ) {
  Animation<Offset> custom = Tween<Offset>(begin: Offset(0,1), end: Offset(0,0)).animate(animation); 
    return SlideTransition(position: custom, child: child);
  }
}

class ProfileView extends StatefulWidget {
String value1;
String value2;
String value3;
String value4;

ProfileView({Key key, this.value1,this.value2,this.value3,this.value4,}) : super(key: key);

  @override
  AppStates createState() => AppStates();
}
class AppStates extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: 
      AppBar(
            actions: <Widget>[
            FlatButton(
              child:
              Icon(
                Icons.edit,
                color: Colors.black
                ),
              // onPressed: () => Navigator.pushNamed(context, '/Profile')
              onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Profile(val1: widget.value1, val2: widget.value2, val3: widget.value3, val4: widget.value4),
                );
                Navigator.of(context).push(route);
              },
              )],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Route route = MySlide(builder: (context) => Groups());
                Navigator.push(context, route);
          },
        )
      ),
    // for other pages
    // actions: <Widget>[
    //         FlatButton(
    //           child:
    //           Icon(
    //             Icons.person,
    //             color: Colors.black
    //             ),
    //           onPressed: () => Navigator.pushNamed(context, '/Profile')
    //           )]
  
  body: Scrollbar(
    child:
    ListView(
    children: <Widget>[
      Column(
            mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
  // MediaQuery.of(context).size.width * 0.65
  Padding(                   
  padding: EdgeInsets.fromLTRB(0, 25.0, 0, 25.0),
child:
  // Hero(
  //               tag: 'dash',
  //               child: 
                Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Partying.png'))),
                ),
// )
),
              SizedBox(height: 25.0),
              Text(
                'Mark Stewart',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                'San Jose, CA',
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
),
  new Padding(
    padding: EdgeInsets.only(
      bottom: 17
    ),
    child:
  ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(
            right: 0.0,
          ),
          child: Container (
            width: 130,
            child: Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      )
      )),
        title: Text(
              "${widget.value1}",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ),
      )
  ),
  new Padding(
    padding: EdgeInsets.only(
      bottom: 17
    ),
    child:
  ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(
            right: 0.0,
          ),
          child: Container (
            width: 130,
            child: Text(
              'Phone Number',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ))),
        title: new Text(
              "${widget.value2}",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ),
      )
  ),
  new Padding(
    padding: EdgeInsets.only(
      bottom: 17
    ),
    child:
  ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(
            right: 0.0,
          ),
          child: Container (
            width: 130,
            child: Text(
              'Age',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ))),
        title: Text(
              "${widget.value3}",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ),
      )
  ),
  new Padding(
    padding: EdgeInsets.only(
      bottom: 0
    ),
    child:
  ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(
            right: 0.0,
          ),
          child: Container (
            width: 130,
            child: Text(
              'Description',
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ))),
        title: Text(
              "${widget.value4}",
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
      ),
      )
  )
])
    ]
  )));
  }
}
