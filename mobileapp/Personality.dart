import 'dart:core';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Personality extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<Personality> with SingleTickerProviderStateMixin {

  PageController _controller = PageController(initialPage: 0);
  var buttonColor;
  List<Widget> questions =[Text('Boom',textAlign: TextAlign.end,)];

  List<Widget> makeWidgets(documents) {
    questions = documents.map<Widget>((DocumentSnapshot document) {
      List<Widget> widgets = new List<Widget>();
      widgets.add(Container(
        height: 100,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black)),
        width: double.infinity,
        child: Center(
          child: AutoSizeText(document['name']),
        ),
      ));
      document['options'].asMap().forEach((index, option) => {
        buttonColor = Colors.lightBlue[100 * (index+1)],
            widgets.add(Container(
            decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white)),
            child:RaisedButton(
                child: AutoSizeText(
                  option,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                color: buttonColor,
                onPressed: () {
                  setState(() {
                    if(_controller.page<5.5){
                      _controller.nextPage(duration: Duration(milliseconds: 1250), curve: Curves.fastOutSlowIn);
                    }
                    else{
                      Navigator.pushNamed(context, '/Interests');
                    }
                  });
                })))
          });
      return GridView.count(
          crossAxisCount: 1, childAspectRatio: 4, children: widgets);
    }).toList();
    return questions;
  }
  

  double page=0;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Personality Test'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
                child: LinearProgressIndicator(
                backgroundColor: Colors.white, 
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                value: (page+1)/7),
              preferredSize: Size(double.infinity,5),
            )),
      floatingActionButton:
        new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
            ),
            FloatingActionButton(
              heroTag: null,
              child: Icon(Icons.arrow_back_ios),
              onPressed: () {
                if(_controller.page >= 1)
                {
                  _controller.previousPage(duration: Duration(milliseconds: 1250), curve: Curves.fastOutSlowIn);
                }
              },
            ),
            new Expanded(
              child: new Text(""),
            ),
            FloatingActionButton(
              heroTag: null,
              child: new Icon(Icons.arrow_forward_ios),
              onPressed: () {
                if(_controller.page <= 5)
                {
                  _controller.nextPage(duration: Duration(milliseconds: 1250), curve: Curves.fastOutSlowIn);
                }
                else if(_controller.page > 5.5)
                {
                  Navigator.pushNamed(context, '/Interests');
                }
              },
            ),
          ],
        ),
      ),
        body: Container(child:StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('questions').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              default:
                try{
                  return PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  onPageChanged: (i) => setState(() {
                    if(i>page){page++;}
                    else{page--;}
                  }),
                  children: makeWidgets(snapshot.data.documents),  
                );}
                catch(e){return Container();}
            }
          },
        ),
      )
    );
  }
}

