import 'package:flutter/material.dart';
import 'package:mobile/ProfileView.dart';


// class Data {
//   String text1;
//   String text2;
//   String text3;
//   String text4;
//   Data({this.text1, this.text2, this.text3, this.text4,});
// }

class Profile extends StatefulWidget {
final String val1;
final String val2;
final String val3;
final String val4;

Profile({Key key, this.val1,this.val2,this.val3,this.val4,}): super(key: key);

  @override
  AppStates createState() => AppStates();

}
class AppStates extends State<Profile> {


// TextEditingController controller1;
// TextEditingController controller2;
// TextEditingController controller3;
// TextEditingController controller4;

TextEditingController controller1 = new TextEditingController();
TextEditingController controller2 = new TextEditingController();
TextEditingController controller3= new TextEditingController();
TextEditingController controller4 = new TextEditingController();

// @override
// void initState{
//   super.initState();
//   FocusScope.of(context).requestFocus(nodeOne);
// }

  FocusNode nodeOne = FocusNode();


@override
  Widget build(BuildContext context) {
// controller1 = new TextEditingController(text: widget.val1);
// controller2 = new TextEditingController(text: widget.val2);
// controller3= new TextEditingController(text: widget.val3);
// controller4 = new TextEditingController(text: widget.val4);

controller1.text = widget.val1;
controller2.text = widget.val2;
controller3.text = widget.val3;
controller4.text = widget.val4;

String newText1 = controller1.text;
String newText2 = controller2.text;
String newText3 = controller3.text;
String newText4 = controller4.text;


    return Scaffold(

      // resizeToAvoidBottomPadding: false,

      // appBar: 
      // AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   leading: FlatButton(
      //     child: Text('save'),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   actions: <Widget>[
      //   FlatButton(
      //     child:
      //     Icon(
      //       Icons.person,
      //       color: Colors.black
      //       ),
      //     onPressed: () => Navigator.pushNamed(context, '/Profile')
      //     )]),


// This is the code for the row

// appBar: AppBar(
//           backgroundColor: Colors.transparent,
//         elevation: 0.0,
//   automaticallyImplyLeading: false, // Don't show the leading button
//   title: 
  
  body: 
  // Scrollbar(
  //   child:
    ListView(
    children: <Widget>[

  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[

Container(
  width: MediaQuery.of(context).size.width * 0.5,
  height: MediaQuery.of(context).size.width * .125,
  child:
  SizedBox(
    width: double.infinity,
          height: double.infinity,
          child:
              FlatButton(
          child:
Text('Cancel',
style: TextStyle(
fontSize: 15.0)),
          // onPressed: () => Navigator.pushNamed(context, '/ProfileView')
onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ProfileView(value1: widget.val2, value2: widget.val2, value3: widget.val3, value4: widget.val4),
                );
                Navigator.of(context).push(route);
            },
          ),
),
),

Container(
  width: MediaQuery.of(context).size.width * 0.5,
  height: MediaQuery.of(context).size.width * .125,
  child:
  SizedBox(
        width: double.infinity,
          height: double.infinity,
          child:
              FlatButton(
          child:
Text('Save',
style: TextStyle(
fontSize: 15.0)),
//this part needs work
          // onPressed: 
          // () => Navigator.pushNamed(context, '/Profile')
              onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ProfileView(value1: newText1, value2: newText2, value3: newText3, value4: newText4),
                );
                Navigator.of(context).push(route);
},
),
),
)

      // Your widgets here
    ],
  ),
// ),


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

      Column(
            mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
  // MediaQuery.of(context).size.width * 0.65
  Padding(                   
  padding: EdgeInsets.fromLTRB(0, 25.0, 0, 25.0),
child:
                Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Partying.png'))),
                ),
),

              SizedBox(height: 25.0),
              Text(
                'Mark Stewart',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
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
      ))),
        title: new TextField(
          controller: controller1,
          focusNode: nodeOne,
          style: TextStyle(
            color: Colors.black, 
            fontSize: 17),
          decoration: new InputDecoration(
            hintText: "",
            hintStyle: TextStyle(
                color: Colors.grey[700],
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
          ),
                    onChanged: (text) {
            newText1 = text;
          }
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
        title: new TextField(
          keyboardType: TextInputType.number,
          controller: controller2,
          style: TextStyle(
            color: Colors.black, 
            fontSize: 17),
          decoration: new InputDecoration(
            hintText: "",
            hintStyle: TextStyle(
                color: Colors.grey[700],
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
          ),
                    onChanged: (text) {
            newText2 = text;
          }
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
        title: new TextField(
         keyboardType: TextInputType.number,
         controller: controller3,
          style: TextStyle(
            color: Colors.black, 
            fontSize: 17),
          decoration: new InputDecoration(
            hintText: "",
            hintStyle: TextStyle(
                color: Colors.grey[700],
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
          ),
                    onChanged: (text) {
            newText3 = text;
          }
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
        title: new TextField(
          controller: controller4,
          maxLines: 2,
          autofocus: true,
          style: TextStyle(
            color: Colors.black, 
            fontSize: 17),
          decoration: new InputDecoration(
            hintText: "",
            hintStyle: TextStyle(
                color: Colors.grey[700],
                // fontWeight: FontWeight.bold,
                fontSize: 17
                )
          ),
                    onChanged: (text) {
            newText4 = text;
          }
        ),
      )
  )

])
    ]
  )
  // )
  );
  }
}
