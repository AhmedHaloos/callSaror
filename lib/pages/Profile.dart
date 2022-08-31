import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sarorcall/pages/ProfileLog.dart';
import 'package:sarorcall/redux/store.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  String name;
  List<Phone> number;

  Profile(this.name, this.number);

  @override
  State<StatefulWidget> createState() => ProfileState(name, number);
}

class ProfileState extends State<Profile> {
  String name;
  List<Phone> number;
  List<CallLogEntry> logs = [];

  ProfileState(this.name, this.number);

  @override
  void initState() {
    MyAppStore appStore = new MyAppStore();
    //   print("name = $name number = ${number}");
    // print("log name = ${appStore.store.state.logs[5].name},"
    //     " log number = ${appStore.store.state.logs[5].number?.replaceAll(" ", "")}");
    print(number);
    appStore.store.state.logs.forEach((log) {
      String logNum = log.number!.replaceAll(" ", "").replaceAll("-", "");
      // print("num = $logNum, log num = ${log.number}");
      if (number[0].number.contains("${log.number}")) {
        logs.add(log);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(),
      body: (
          Container(
              child: Column(
                children: [
                  ProfileHeader(name),
                  ProfileBody(number, logs),
                ],
              )
          )
      ),
    ));
  }
}

// class ProfileHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//
//   }
// }

class ProfileHeader extends StatelessWidget {
  String name;

  ProfileHeader(this.name);

  @override
  Widget build(BuildContext context) {
    return (Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                decoration:
                BoxDecoration(
                    border: Border.all(),
                    shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Image.asset(
                      "assets/images/A.png",
                      width: 50,
                      height: 50,
                    ))),
            SizedBox(
              height: 10,
            ),
            Text(name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 50,
            ),
          ],
        )));
  }
}

class ProfileBody extends StatelessWidget {
  List<Phone> number;
  List<CallLogEntry> logs;

  ProfileBody(this.number, this.logs);

  @override
  Widget build(BuildContext context) {
    return (
        Container(
            child:
            Column(children: [
              Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.grey
                        ),
                        onPressed: () {},
                        child: Icon(Icons.call),
                      )
                  ),
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.grey),
                        onPressed: () {},
                        child: Icon(Icons.chat),
                      )),
                  Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.grey),
                        onPressed: () {},
                        child: Icon(Icons.block),
                      )),
                  SizedBox(
                    width: 60,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  thickness: 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 0),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: Colors.grey
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.call,
                              )
                          )
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                              style: TextButton.styleFrom(primary: Colors.grey),
                              onPressed: () {},
                              child: Text(
                                number.length <= 0 ?
                                    "Private number"
                                :
                                number[0].normalizedNumber != "" ?
                                number[0].normalizedNumber
                                    : number[0].number != "" ?
                                number[0].number
                                :number.length <= 1 ?
                                "Private number"
                                    : number[1].normalizedNumber != "" ?
                                number[1].normalizedNumber
                                    : number[1].number != "" ?
                                number[1].number
                                    :"no number available"
                                ,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: TextButton(
                              style: TextButton.styleFrom(primary: Colors.grey),
                              onPressed: () {},
                              child: Icon(
                                Icons.sms,

                              )))
                    ],
                  ),
                ),
              ),

              Container(
                  margin: EdgeInsets.only(right: 15, left: 20, top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),

                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              ContactItem(
                                name: logs[index].name,
                                phone: logs[index].number,
                                callState: logs[index].callType,
                                duration: logs[index].duration,
                              ),
                          itemCount: logs.length > 0 ? 4 : 0,
                        ),
                      ),

                      TextButton(
                          style: TextButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfileLog(logs)));
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 35, right: 35),
                                    padding: EdgeInsets.all(10),

                                    alignment: Alignment.center,
                                    child: Text(
                                      "More History",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  )),
                              // Icon(Icons.add, color: Colors.black, size: 20,),
                            ],
                          )
                      )
                    ],
                  )
              ),
            ]
            )
        )
    );
  }
}

class ContactItem extends StatelessWidget {
  String name = "";
  String phone = "";
  String? img = "";
  CallType? callState;
  String callStateName = "";
  int? duration;
  int hr = 0,
      min = 0,
      sec = 0;

  ContactItem({name, phone, img, callState, duration}) {
    this.name = name;
    this.phone = phone == null ? "private number" : phone;
    this.img = img;
    this.callState = callState;
    this.duration = duration;
    hr = (duration / 3600).toInt();
    duration = duration % 3600;
    min = (duration / 60).toInt();
    duration = duration % 60;
    sec = duration;
    callStateName = (callState == CallType.outgoing) ? callTypes[0]
        : (callState == CallType.incoming) ? callTypes[1]
        : callTypes[2];
  }

  List<String> callTypes = ["Outgoing", "Incoming", "missed"];

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
                              : callState == CallType.missed ?
                          Icon(
                            Icons.call_missed,
                            color: Colors.red,
                            size: 15,
                          ) :
                          SizedBox(width: 0, height: 0,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            (callState == CallType.missed) ?
                            ""
                                :
                            (hr > 0 ? "${hr}h" : "") + (min > 0
                                ? " ${min}m"
                                : "") + (" ${sec}s"),
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
  final Uri url = Uri(scheme: "tel", path: phone);
  await canLaunchUrl(url)
      .then((value) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  });
}


