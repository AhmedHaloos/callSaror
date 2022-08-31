import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:redux/redux.dart';
import 'package:sarorcall/pages/Messages.dart';
import 'package:sarorcall/pages/StateContainer.dart';
import 'package:sarorcall/redux/store.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../redux/actions.dart';
import 'Profile.dart';



class Contacts extends StatefulWidget{
 List<Contact> contacts = [];
 Contacts(this.contacts);
  @override
  State<StatefulWidget> createState()=> ContactsState(contacts);
}

class ContactsState extends State<Contacts>{
  List<Contact> contacts = [];

  ContactsState(this.contacts);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemBuilder: (context, index) =>
          ContactItem(
            name: contacts[index].displayName,
            phone: contacts[index].phones,
          )
      ,
      itemCount: contacts.length,
      addAutomaticKeepAlives: false,
    );
  }


}



class ContactItem extends StatelessWidget {
  String name = "";
  List<Phone> phone = [];
  String? img = "";


  ContactItem({name, phone, img,}) {
    this.name = name;
    this.phone =  phone;
    this.img = img;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
              _launchUrl(phone[0].normalizedNumber);
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
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>Profile(name,phone)
                          )
                      );
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
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),

                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(100),
                hoverColor: Colors.black,
                // focusColor: Colors.black,
                // highlightColor: Colors.black,
                splashColor: Colors.black,
                onTap: () {
                 /* ToastContext().init(context);
                  Toast.show("display " + name + " profile",
                      backgroundRadius: 50,
                      backgroundColor: Colors.lightBlueAccent,
                      duration: 5);*/
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xfff7f7f7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
Future<void> _launchUrl(phone) async {
final Uri url = Uri(scheme: "tel", path:phone);
     await canLaunchUrl(url)
.then((value) async{
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
     });
  }


