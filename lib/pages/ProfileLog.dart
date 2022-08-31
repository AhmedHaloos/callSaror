
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLog extends StatefulWidget{
  List<CallLogEntry> logs = [];
  ProfileLog(this.logs);
  @override
  State<StatefulWidget> createState()=>ProfileLogState(logs);
}

class ProfileLogState extends State<ProfileLog>{

  List<CallLogEntry> logs = [];
ProfileLogState(this.logs);
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home: Scaffold(
        body: ListView.builder(
            itemBuilder: (context, index)=>
                  ContactItem(
                    name: logs[index].name,
                    phone: logs[index].number,
                    callState: logs[index].callType,
                    duration: logs[index].duration,
                  ),
              itemCount: logs.length > 0 ? logs.length : 0 ,
            ),
    ),
      );

  }
}

class ContactItem extends StatelessWidget {
  String name = "";
  String phone = "";
  String? img = "";
  CallType? callState;
  int? duration;
  int hr = 0, min = 0, sec = 0;
  String callStateName = "";

  ContactItem({name, phone, img, callState, duration}) {
    this.name = name;
    this.phone = phone == null ? "private number" : phone;
    this.img = img;
    this.callState = callState;
    this.duration = duration;
    hr =  (duration/3600).toInt() ;
    duration = duration% 3600;
    min = (duration/60).toInt() ;
    duration =duration%60;
    sec = duration;
    callStateName = (callState == CallType.outgoing)?callTypes[0]
        : (callState == CallType.incoming)? callTypes[1]
        : callTypes[2];
  }
  List<String> callTypes = ["Outgoing","Incoming", "missed"];
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: InkWell(
          onTap: () {
            ToastContext().init(context);
            _launchUrl(phone);
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
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.blueAccent,
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${callStateName} call",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          callState == CallType.incoming
                              ? Icon(
                            Icons.call_received,
                            color: Colors.indigo,
                            size: 15,
                          )
                              : callState == CallType.outgoing
                              ? Icon(
                            Icons.call_made,
                            color: Colors.green,
                            size: 15,
                          )
                              : callState == CallType.missed?
                          Icon(
                            Icons.call_missed,
                            color: Colors.red,
                            size: 15,
                          ):
                          SizedBox(width: 0,height: 0,) ,
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            (callState == CallType.missed)?
                            ""
                                :
                            (hr > 0?"${hr}h" : "") + (min > 0 ? " ${min}m":  "") + (" ${sec}s"),
                            style: TextStyle(
                                fontSize: 14,

                                color: Color(0xFF666666)),
                            textAlign: TextAlign.start,
                          ),
                        ],
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
                    ToastContext().init(context);
                    Toast.show("display " + name + " profile",
                        backgroundRadius: 50,
                        backgroundColor: Colors.lightBlueAccent,
                        duration: 5);
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