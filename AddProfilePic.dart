import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddProfilePic extends StatefulWidget {
  @override
  AppStates createState() => AppStates();
}

class AppStates extends State<AddProfilePic> {
  Image image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.1),
        child:Center(
          child:Column(
            children:<Widget>[
              Text('Add a Profile Picture',style: TextStyle(fontSize: 24),),
              Padding(padding: EdgeInsets.only(top: 20),),
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(62.5),
                ),
                child: OutlineButton(
                  child: Icon(Icons.add_a_photo,size: 150,),
                  onPressed: (){},
                  shape: CircleBorder(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10),),
              AutoSizeText('Think of this as your contact photo for everyone you meet',
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 40),),
              Container(
              width: MediaQuery.of(context).size.width*.4,
              height: 60,
              child: RaisedButton(
                child: Center(child: Text('Done',style: TextStyle(color: Colors.white),)),
                onPressed: (){},
                color: Colors.blue[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),)
                )
              ),
            ]
          )
        ),
      )
    );
  }
}
