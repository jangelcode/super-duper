import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {

final int time;

  final String 
  text, 
  person, 
  type; 
  // replyText, 
  // replyName;
  final bool 
  icon; 
  // isGroup, 
  // isReply;

  ChatMessage({
    this.text,
    this.time,
    // this.isMe,
    // this.isGroup,
    this.person,
    this.type,
    this.icon
    // this.replyText,
    // this.isReply,
    // this.replyName
    });

  @override
  TextContent createState() => TextContent();

bool isUser(){
    if (person=='Me')
    {
      return true;
    }
  return false;
  }

}
// constructor to get text from textfield

class TextContent extends State<ChatMessage>{

// String lastTextSender = '';

  @override
  Widget build(BuildContext context) {
    final bg = widget.isUser() ?Colors.blue[200] : Colors.grey[200];
    final align = widget.isUser() ? CrossAxisAlignment.end: CrossAxisAlignment.start;
    //this one controls the space between the text messages
    final padding = widget.isUser() ? EdgeInsets.only(right: 20, bottom: 20): EdgeInsets.only(left: 0, bottom: 20);
    final radius = widget.isUser() ? BorderRadius.only(topLeft: Radius.circular(9.0), bottomLeft: Radius.circular(9.0), 
    bottomRight: Radius.circular(9.0)) : BorderRadius.only(topRight: Radius.circular(9.0), bottomLeft: Radius.circular(9.0), 
    bottomRight: Radius.circular(9.0)); 

    final paddingNew = widget.isUser() ? EdgeInsets.only(right: 20, bottom: 20): EdgeInsets.only(left: 90, bottom: 20);

if(widget.isUser()){

// lastTextSender = 'Me';

return new 
Draggable(
affinity: Axis.horizontal,
axis: Axis.horizontal,
child:
Padding(
  padding: padding,
  child:      

  Column(
  crossAxisAlignment: align,
  children: <Widget>[ 
    
    Text(widget.person,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            ),
    Container(
          // margin: const EdgeInsets.only(right:6.0),
          // padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          child: Padding( 
            padding: EdgeInsets.all(15),
            child: Text(widget.text,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            )),
          constraints: BoxConstraints(

            // fix this shit below, make sure sized right
            maxWidth:  MediaQuery.of(context).size.width/1.7,
            minWidth: 20.0,
          ),
          // is that all?
    )]
    )
    
    ),
    feedback: Padding(
  padding: padding,
  child:      
  Column(
  crossAxisAlignment: align,
  children: <Widget>[ 
    Text(widget.person,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            ),
    Container(
          // margin: const EdgeInsets.only(right:6.0),
          // padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          child: Padding( 
            padding: EdgeInsets.all(15),
            child: Text(widget.text,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            )),
          constraints: BoxConstraints(

            // fix this shit below, make sure sized right
            maxWidth:  MediaQuery.of(context).size.width/1.7,
            minWidth: 20.0,
          ),
          // is that all?
    )]
    )
    
    ),
    childWhenDragging: Container(
      height: 86,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:25, right: 10),
            child:
          Text(widget.time.toString(),
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            ))])),
    
    );
    }

else{

if (widget.icon){

return new Padding(
  padding: padding,
  child:
  Column(
  crossAxisAlignment: align,
  children: <Widget>[ 
    Row(children: <Widget>[
      Padding(
        child: Text(widget.person,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            ),
      padding: EdgeInsets.only(left:90)
        )
      ]),
    Row(children: <Widget>[
      FlatButton(
              child:
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/Partying.png'))),
                ),
                onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {

        // return AlertDialog(
        //   contentPadding: EdgeInsets.all(0),
        //   title: new Text("Alert Dialog title"),
        //   content: new Text("Alert Dialog body"),
        //   actions: <Widget>[
        //     // usually buttons at the bottom of the dialog
        //     new FlatButton(
        //       child: new Text("Close"),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );

                  return AlertDialog(
                    contentPadding: EdgeInsets.only(top: 150, left:0, right:0, bottom:0),
                    backgroundColor: Colors.tealAccent,
                    content: Container(
                      alignment: Alignment.bottomCenter,
                      height: 75,
                      color: Colors.white,
                      child: 
                      Row(children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          child:
                      FlatButton(
                   child: Icon(Icons.person),
                onPressed:() {
                Navigator.of(context).pop();
              },
                      )),
    Container(
                          alignment: Alignment.bottomLeft,
                          child:
                      FlatButton(
                   child: Icon(Icons.person),
                onPressed:() {
                Navigator.of(context).pop();
              },
                      ))
                      ])
                  ));



                }
                );
          },
                ),
    Container(
          // margin: const EdgeInsets.only(right:6.0),
          // padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          child: Padding( padding: EdgeInsets.all(15),
            child: Text(widget.text,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            )),
          constraints: BoxConstraints(

            // fix this shit below, make sure sized right
            maxWidth:  MediaQuery.of(context).size.width/1.7,
            minWidth: 20.0,
          ),
          // is that all?
    )])
    
    ]));
    
    }

    else{

return new Padding(
  padding: paddingNew,
  child:
  Column(
  crossAxisAlignment: align,
  children: <Widget>[ 
    Row(children: <Widget>[
      Text(widget.person,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            )
      ]),
    Row(children: <Widget>[
    Container(
          // margin: const EdgeInsets.only(right:6.0),
          // padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: radius,
          ),
          child: Padding( padding: EdgeInsets.all(15),
            child: Text(widget.text,
            style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                    ),
            )),
          constraints: BoxConstraints(

            // fix this shit below, make sure sized right
            maxWidth:  MediaQuery.of(context).size.width/1.7,
            minWidth: 20.0,
          ),
          // is that all?
    )])
    ]));
    }
    }
  }
}
