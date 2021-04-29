import 'package:flutter/material.dart';
import 'package:mobile/ProfileView.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatScreen.dart';

class Groups extends StatefulWidget {
  @override
  Boomwhaddup createState() => Boomwhaddup();
}

class Boomwhaddup extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/CreateNewGroup');
            }),
        appBar: new AppBar(
            title: new Text("Groups"),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              InkWell(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage('assets/Partying.png'))),
                  ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
                },
              )
            ]),
        body: Stack(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Center(
                  child: GroupBack(),
                ),
              ],
            ),
          )
        ]));
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              ),
        );
}

class GroupBack extends StatefulWidget {
  @override
  GroupList createState() => GroupList();
}

class GroupList extends State<GroupBack> {
  List<Map<String, dynamic>> notifications = new List<Map<String, dynamic>>();
  bool opac = true;
  void initState() {
    super.initState();
    Firestore.instance
        .collection('notifications')
        .where("user", isEqualTo: "IRmLJFD5nkrb8o2BuceS")
        .snapshots()
        .listen((data) => notifications =
            data.documents.map((document) => document.data).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new Column(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                        width: MediaQuery.of(context).size.width * .825,
                        height: MediaQuery.of(context).size.height * .15,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.center,
                                    child: ChatScreen()));
                          },
                          child: Card(
                            elevation: 15,
                            color: Colors.primaries[document['color']],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: Icon(Icons.arrow_forward_ios,size: 30,),
                                ),
                                Positioned(
                                  bottom: 30,
                                  left: 40,
                                    child: Text(document['name'],
                                        style: TextStyle(color: Colors.white, fontSize: 22))),
                                Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Row(children: <Widget>[
                                      Text(document['notify'] ? 'Notifications On':'Notifications Off',
                                        style: TextStyle(color: Colors.white,fontSize: 14),),
                                      IconButton(
                                        icon: (document['notify']
                                            ? Icon(Icons.alarm)
                                            : Icon(Icons.alarm_off)),
                                        onPressed: () {
                                          opac = !opac;
                                          document.reference.updateData({
                                            'notify': !document.data['notify']
                                          });
                                        },
                                      )
                                    ]))
                              ],
                            ),
                          ),
                        )));
              }).toList(),
            );
        }
      },
    );
  }
}
