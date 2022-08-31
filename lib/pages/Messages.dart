import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class Message extends StatefulWidget {
  List<SmsMessage> smsMsgs = [];
  List<SmsMessage> dispMsgs = [];
  List<Contact> contacts = [];
  Message(this.smsMsgs, this.dispMsgs, this.contacts);

  @override
  State<StatefulWidget> createState() => MessageState(smsMsgs, dispMsgs, contacts);
}

class MessageState extends State<Message> {
  List<SmsMessage> smsMsgs = [];
  List<SmsMessage> dispMsgs = [];
  List<Contact> contacts = [];
  List contactData = [];

  MessageState(this.smsMsgs, this.dispMsgs, this.contacts);


  @override
  void initState() {

    contacts.forEach((contact) {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Center(
      child: ListView.builder(
        itemCount: dispMsgs.length,
          addAutomaticKeepAlives: false,
          itemBuilder: (context, index)=>
          MessageItem(
            name : dispMsgs[index].address,
            body : (dispMsgs[index].body?.length ?? 0) <= 30 ? "": dispMsgs[index].body?.substring(0, 27),
            bodyState:dispMsgs[index].isRead,
          )
      ),
    ));
  }
}


class MessageItem extends StatelessWidget {
  String name = "";
  String body = "";
  bool? bodyState ;


  MessageItem({name, body, bodyState,}) {
    this.name = name;
    this.body = body;
    this.bodyState = bodyState;
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      child: InkWell(
        onTap: () {

        },
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
          ),
          child: (Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: (){

                    },
                    icon : Icon(Icons.account_circle, size: 60,),

                    color: Colors.blueAccent,
                  )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,

                    ),
                    Text(
                      body,
                      style: TextStyle(
                          fontSize: 14,
                          color:bodyState != true? Colors.black: Colors.grey,
                          fontWeight: bodyState != true? FontWeight.bold : FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              bodyState == true ?
              SizedBox()
              :
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),

              )
            ],
          )),
        ),
      ),
    );
  }
}