import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Interests extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class Interest {
  String label;
  String photo;
  bool bol;
  Color col;

  Interest(String label, String photo, bool bol, Color col) {
    this.label = label;
    this.photo = photo;
    this.bol = bol;
    this.col = col;
  }
}

class AppState extends State<Interests> {
  List<Interest> interests = new List<Interest>();

  @override
  void initState() {
    super.initState();

    interests
        .add(new Interest('Sports', 'assets/sports.png', false, Colors.white));
    interests.add(
        new Interest('Fitness', 'assets/Fitness.png', false, Colors.white));
    interests.add(new Interest('Arts & Entertainment',
        'assets/arts_and_entertainment.png', false, Colors.white));
    interests
        .add(new Interest('Travel', 'assets/travel.png', false, Colors.white));
    interests.add(new Interest(
        'Home & Garden', 'assets/Home_&_Garden.png', false, Colors.white));
    interests.add(new Interest('Cars', 'assets/Cars.png', false, Colors.white));
    interests.add(new Interest(
        'Computer & Tech', 'assets/Computers.png', false, Colors.white));
    interests.add(new Interest(
        'Career & Business', 'assets/Business.png', false, Colors.white));
    interests.add(new Interest('Outdoor Activities',
        'assets/Outdoor_Activities.png', false, Colors.white));
    interests.add(new Interest(
        'Food & Drink', 'assets/Food_&_Drink.png', false, Colors.white));
    interests.add(
        new Interest('Gaming', 'assets/VideoGames.png', false, Colors.white));
    interests.add(
        new Interest('Cooking', 'assets/Cooking.png', false, Colors.white));
    interests.add(new Interest('Pets', 'assets/Pets.png', false, Colors.white));
    interests.add(
        new Interest('Partying', 'assets/Partying.png', false, Colors.white));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        onPressed: ()=>Navigator.pushNamed(context, '/Chats'),
      ),
      appBar: new AppBar(
          title: new Text("Select up to 5 Interests"),
          backgroundColor: Colors.transparent,
          elevation: 0,
      ),
      body: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                scrollDirection: Axis.vertical,
                children: getWidgets()
            ),
          ),
        ]
      ),
    );
  }
  
  double selected = 0;

  List<Widget> getWidgets() {
    List<Widget> widgets = new List<Widget>();
    this.interests.forEach((Interest interest) {
      widgets.add(new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
          child: Stack(children:<Widget>[
            OutlineButton(
              child: Stack(children: <Widget>[
                Positioned(
                    top: 10,
                    bottom: 55,
                    right: 5,
                    left: 5,
                    child: Image.asset(
                      interest.photo,
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                    bottom: 10,
                    right: 1,
                    left: 1,
                    child: Center(
                      child: AutoSizeText(
                      interest.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ))),
              ]),
              color: Colors.white,
              highlightElevation: 0,
              onPressed: () => setState(() {
                  }),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
                  Opacity(
                  opacity: interest.bol ? 1:0,
                  child: Container(
                    width: double.infinity, 
                    height: double.infinity,
                    child: RaisedButton(
                      elevation: 5,
                      child: Stack(children: <Widget>[
                        Center(child:Icon(Icons.check_circle_outline, size: 70,)),
                        Positioned(
                          bottom: 10,
                          right: 1,
                          left: 1,
                          child: Center(
                            child: AutoSizeText(
                              interest.label,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                    ))),
              ]),
                      color: Colors.grey[100], 
                      onPressed:()=> 
                        setState(() {
                          if(selected < 5){
                            interest.bol = !interest.bol;
                            if(interest.bol){
                              selected++;}
                            else if(interest.bol == false){
                              selected--;}  
                              }
                          else if(selected == 5 && interest.bol == true){
                            interest.bol = !interest.bol;
                            selected--;
                            }
                              }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),)),
                      ),),
                  ])));
    });
    return widgets;
  }
}
