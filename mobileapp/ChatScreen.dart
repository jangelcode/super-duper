import 'package:flutter/material.dart';
import 'ChatMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

Random random = Random();
String lastPerson = '';

List names = [
  "Ling Waldner",
  "sally",
  "Me"];

  final TextEditingController _chatController = new TextEditingController();

  void _handleSubmit(String _text, String _person, String _type) {
    FocusScope.of(context).requestFocus(nodeOne);
    _chatController.clear();

// set icon val

bool icon = true;

if (lastPerson==_person){
  icon = false;
}

lastPerson = _person;

// The above code will not work because submissions from other phones will not 
// change the person value here
//
// Text and type only, person = me only possiblity

// Streambuilder implementation: set lastperson= the last sender


// DatabaseReference databaseReference = Firebase.getInstance().getReference();
// Query lastQuery = databaseReference.child("mp").orderByKey().limitToLast(1);
// lastQuery.addListenerForSingleValueEvent(new ValueEventListener() {
//     @Override
//     public void onDataChange(DataSnapshot dataSnapshot) {
//         String message = dataSnapshot.child("message").getValue().toString();
//     }

//     @Override
//     public void onCancelled(DatabaseError databaseError) {
//         //Handle possible errors.
//     }
// });

//FIX THESE

// Stream<QuerySnapshot> snapshot = Firestore.instance.collection('Messages').orderBy('time', descending: true).snapshots();

// String lastPerson= snapshot[0].data.documents[0]['username'];





// bool icon=true;
// if ("Me"==lastPerson){icon=false;}



    setState(() {
     Firestore.instance.collection("Messages").add({
        'text': _text,
        'time': DateTime.now().toUtc().millisecondsSinceEpoch, 
        'icon': icon,  
        'username': _person,
        'type': _type
});

      //  _messages.insert(0, message);
    });
}

FocusNode nodeOne = FocusNode();

  Widget _chatEnvironment (){
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
          child: new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.camera_alt),onPressed: (){},color: Colors.grey[700],),
            new Flexible(
              child: new TextField(
                focusNode: nodeOne,
                decoration: new InputDecoration.collapsed(hintText: "Start typing ..."),
                controller: _chatController,
                // onSubmitted: _handleSubmit(),
                // do i even need this line?
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                
              // test data


                onPressed: ()=> 
                
                _handleSubmit(_chatController.text, names[random.nextInt(3)], 'type_1'
              ),
            )
            )
          ],
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: 
        Text('Messages'),),
      body: 
      Scrollbar(child:
      Container(
      height: MediaQuery.of(context).size.height,
      child: 
      // need to use a flexible widget here
      Padding(
        padding: EdgeInsets.only(top:10),
        child:

        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Flexible(
          //     child:
          // new Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [ 
      StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Messages').orderBy('time', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          // case ConnectionState.waiting:
          //   return new Text('Loading...');
          default:
            return Flexible(child:
            ListView.builder(
              padding: new EdgeInsets.only(left: 0.0, right: 0.0),
              reverse: true,

              itemBuilder: (_, int index) => new ChatMessage(
        text: snapshot.data.documents[index]['text'],
        time: snapshot.data.documents[index]['time'], 
        icon: snapshot.data.documents[index]['icon'],
        person: snapshot.data.documents[index]['username'],
        type: snapshot.data.documents[index]['type']
      ),             
              itemCount: snapshot.data.documents.length,
            )
            );

              }}
              ),

          new Divider(
            height: 1,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:
          new Container(
            decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            ),
          child: _chatEnvironment(),
          )
          )
          
        ]))
        )));

}
}
