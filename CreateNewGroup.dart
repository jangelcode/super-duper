import 'package:flutter/material.dart';
import 'main.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CreateNewGroup extends StatefulWidget{
  @override
  NewClass createState() => NewClass();
}

List<Widget> interests = [
  Text('Parties',style: TextStyle(color: Colors.white),),
  Text('Food',style: TextStyle(color: Colors.white)), 
  Text('Sports',style: TextStyle(color: Colors.white)), 
  Text('Cooking',style: TextStyle(color: Colors.white)), 
  Text('Arts & Entertainment',style: TextStyle(color: Colors.white)),
  ];

class NewClass extends State<CreateNewGroup>{
  List<String> _locations = ['Small (2-5)', 'Medium (6-10)', 'Large (11-15)'];
  String _selectedLocation;
  int value = 2;
  double opac = 0;
  double opac1 = 0;
  int value2 = 4;
  FocusNode node;
  FocusNode node2 = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      appBar: new AppBar(
        iconTheme: IconThemeData(
            color: Colors.white,
        ),
        title: Text('Create New Group',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,),
      body: ListView(
        children:<Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:<Widget>[ 
                Divider(color: Colors.white,height: 0,),
                FlatButton(
                  child:Row(
                    children: <Widget>[
                      AutoSizeText('Selected Interests:', style: TextStyle(fontSize: 18,color: Colors.white),),
                      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07),),
                      Padding(
                        child:Column(children: interests,mainAxisAlignment: MainAxisAlignment.start,),
                        padding: EdgeInsets.fromLTRB(0,10,0,10),),
                      Expanded(child:Text('')),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                    ],
                  mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  onPressed: (){
                    FocusScope.of(context).requestFocus(node2);
                    Navigator.pushNamed(context, '/Interests');
                  }
                ),
                Divider(color: Colors.white,height: 0,),
                Container(
                  height:60,
                  child:FlatButton(
                    child: Row(
                      children: <Widget>[
                        AutoSizeText('Personality Test Answers', style: TextStyle(fontSize: 18,color: Colors.white),),
                        //Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*.07),),
                        Expanded(child:Text('')),
                        Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,)
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(node2);
                      Navigator.pushNamed(context, '/Personality');
                    },
                  )
                ),
                Divider(color: Colors.white,height: 0,),
                Padding(padding: EdgeInsets.all(10),),
                Center(child:Text('Preferred Group Size:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
                Padding(padding: EdgeInsets.only(top:10)),
                Center(
                  child:DropdownButton(
                  underline: Container(color: Colors.white,height: 1,),
                  iconEnabledColor: Colors.white,
                  hint: Text('Please choose a group size',style: TextStyle(color: Colors.white),),
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                )),
                Padding(padding: EdgeInsets.only(top: 20),),
                Divider(color: Colors.white,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Are you a student?', style: TextStyle(fontSize: 16,color: Colors.white),),
                    Padding(padding: EdgeInsets.all(10),),
                    Text('Yes',style: TextStyle(fontSize: 16.0,color: Colors.white)),
                    Radio(
                      activeColor: Colors.black,
                      value: value2,
                      groupValue: 3,
                      onChanged: (int val){setState(() {
                       value2 = 3;
                       opac1=1;
                     });}
                    ),
                    Padding(padding: EdgeInsets.all(4),),
                    Text('No',style: new TextStyle(fontSize: 16.0,color: Colors.white)),
                    Radio(
                      activeColor: Colors.black,
                      value: value2,
                      groupValue: 4,
                      onChanged: (int val2){setState(() {
                       value2 = 4;
                        opac1=0;
                        opac=0;
                        value=2;
                        FocusScope.of(context).requestFocus(node2);
                      });},
                    ),
                  ]
                ),
                AnimatedOpacity(
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(width:MediaQuery.of(context).size.width-200,child:AutoSizeText('Would you like to find other students at your university?', style: TextStyle(fontSize: 16,color: Colors.white),)),
                    Padding(padding: EdgeInsets.all(10),),
                    Text('Yes',style: TextStyle(fontSize: 16.0,color: Colors.white)),
                    Radio(
                      activeColor: Colors.black,
                      value: value,
                      groupValue: 1,
                      onChanged: (int val){setState(() {
                       value = 1;
                       opac=1;
                     });},
                    ),
                    Padding(padding: EdgeInsets.all(4),),
                    Text('No',style: new TextStyle(fontSize: 16.0,color: Colors.white)),
                    Radio(
                      activeColor: Colors.black,
                      value: value,
                      groupValue: 2,
                      onChanged: (int val2){setState(() {
                       value = 2;
                        opac=0;
                        FocusScope.of(context).requestFocus(node2);
                      });},
                    ),
                    ],
                  ),
                  opacity: opac1,
                  duration: Duration(milliseconds: 200)
                ),
                Padding(padding: EdgeInsets.all(4)),
                AnimatedOpacity(
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 300,
                      child:TextField(            
                        keyboardType: TextInputType.text,
                        focusNode: node,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.lightBlue[50]),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.lightBlue[50]),
                          contentPadding: EdgeInsets.all(10),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Enter Your University',
                        )
                      )
                    ) 
                  ), 
                  opacity: opac,
                  duration: Duration(milliseconds: 200)
                ),
                Padding(padding: EdgeInsets.only(top:25),),
                Divider(color: Colors.white,),
                Padding(padding: EdgeInsets.all(5),),
                Center(
                  child:
                  Container(height: 60,width: 150,
                    child: RaisedButton(child: Text('Search',style: TextStyle(color: Colors.blue[700]),), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: Colors.white, elevation: 5, onPressed: (){},
                    )
                  )
                ),
              ] 
            )
          )
        ]
      )
    );
  }
}
