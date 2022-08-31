import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redux/redux.dart';
import 'package:sarorcall/pages/History.dart';
import 'package:sarorcall/pages/Login.dart';
import 'package:sarorcall/pages/Messages.dart';
import 'package:sarorcall/pages/Contacts.dart';
import 'package:sarorcall/pages/Profile.dart';
import 'package:sarorcall/pages/Register.dart';
import 'package:sarorcall/pages/SplashScreen.dart';
import 'package:sarorcall/pages/StateContainer.dart';
import 'package:sarorcall/redux/reducers.dart';
import 'package:sarorcall/redux/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:redux/redux.dart';
import 'package:sarorcall/redux/reducers.dart';
import 'package:sarorcall/redux/actions.dart';

void main() {
  MyAppStore();
  runApp(
      MaterialApp(title: "PaliState", home: SplashScreen())
  );
}

class Home extends StatefulWidget {
  int pageIndex = 0;

  Home(this.pageIndex);

  @override
  State<StatefulWidget> createState() => HomeState(pageIndex);
}

class HomeState extends State<Home> {
  String pageTitle = "";
  int _selectedIndex = 0;
  List<Contact> contacts = [];
  List<CallLogEntry> dispCallLog = [];
  List<CallLogEntry> callLogs = [];
  List<SmsMessage> smsMsgs = [];
  List<SmsMessage> dispMsgs = [];
  List<Widget> pages = [];

  bool log = false;
  bool cont = false;
  bool sms = false;

  HomeState(this._selectedIndex);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          pageTitle = "History";
          break;
        case 1:
          pageTitle = "Contacts";
          break;
        case 2:
          pageTitle = "Messages";
          break;
      }
    });
  }


  void initAppState(BuildContext context) {
    pages = <Widget>[
      History(dispCallLog, callLogs),
      Contacts(contacts),
      Message(smsMsgs, dispMsgs, contacts),
    ];

    /**************** load sms  ********************************/
    getSmsMsgs().then((msgs) {
      setState(() {
      sms = true;
      // print("sms -- sms");
      List<String> msgsId = [];
      msgs.forEach((msg) {

        if (!msgsId.contains(msg.address)) {
          msgsId.add(msg.address!);
          dispMsgs.add(msg);
        }
        smsMsgs.add(msg);
      });
      dispMsgs.sort((oldMsg, newMsg){

        return  newMsg.date!.compareTo(oldMsg.date!);
      });
        pages = <Widget>[
          History(dispCallLog, callLogs),
          Contacts(contacts),
          Message(smsMsgs, dispMsgs, contacts),
        ];
      MyAppStore appStore = MyAppStore();
      appStore.store.dispatch(SmsMsgAction(smsMsgs, dispMsgs,sms, AppAction.getAllAction));

      });

    }).catchError((error) {
      print(error);
    });

    /****************************** load contacts *************************/
    getMyContacts().then((myContacts) {
      print(myContacts[18]);

           setState(() {
              cont = true;
              // print("cont -- cont");
                 myContacts.forEach((contact) {
                   if(contact.phones.length != 0){
                     contacts.add(contact);
                   }
                 });
          pages = <Widget>[
            History(dispCallLog, callLogs),
            Contacts(contacts),
            Message(smsMsgs, dispMsgs, contacts),
          ];
              MyAppStore appStore = MyAppStore();
              // appStore.contacts = contacts;
              appStore.store.dispatch(ContactAction(myContacts, myContacts,cont, AppAction.getAllAction));
        });
    }).catchError((error) {
      print(error);
    });

    /************************* load log ****************************/
    getCallLog().then((callLog) {
        setState(() {
      log = true;
      // print("log -- log");
      List<String> logs = [];
      DateTime timeNow = DateTime.now();

      // print("*********************************************************************");
      callLog.forEach((callLogEntry) {
        // print("log name = ${callLogEntry.name}, log phone  = ${callLogEntry.number}");
        if (!logs.contains(callLogEntry.number)) {
          logs.add(callLogEntry.number!);
          dispCallLog.add(callLogEntry);
        }
        callLogs.add(callLogEntry);
        // print(callLogEntry.number);
      });
      dispCallLog.sort((oldLog, newLog){

        return  newLog.timestamp!.compareTo(oldLog.timestamp!);
      });
          pages = <Widget>[
            History(dispCallLog, callLogs),
            Contacts(contacts),
            Message(smsMsgs, dispMsgs, contacts),
          ];
      MyAppStore appStore = MyAppStore();
      appStore.store.dispatch(LogAction(callLogs, dispCallLog,log, AppAction.getAllAction));
        });

    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    initAppState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   //
   // MyAppStore appStore = MyAppStore();
   // print("contacts = ${appStore.store.state.contacts.length}");
   // print("logs = ${appStore.store.state.logs.length}");
   // print("sms = ${appStore.store.state.smsMsgs.length}");
    return (
        Scaffold(
      drawer: createDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 1,
        toolbarHeight: 50,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xFFe3e3e3),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        title: Text(pageTitle),
        actions: [
          InkWell(
              radius: 100,
              onTap: () {},
              child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ))),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (item) {
              print(item);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "blocked", child: Text("blocked")),
              PopupMenuItem(value: "missed", child: Text("missed")),
              PopupMenuItem(value: "received", child: Text("received")),
              PopupMenuItem(value: "sent", child: Text("sent")),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
      body: pages.elementAt(_selectedIndex),
    ));
  }
}

Drawer createDrawer() {
  return Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: createDrawerHeader(),
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text("contacts"),
          onTap: () {},
          selectedColor: Colors.lightBlueAccent,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("settings"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text("about us"),
          onTap: () {},
        ),
        Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Divider(
              thickness: 1.5,
            )),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("log out"),
          onTap: () {},
        ),
      ],
    ),
  );
}

DrawerHeader createDrawerHeader() {
  return DrawerHeader(
    child: InkWell(
      onTap: () {},
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
                child: Image.asset("assets/images/A.png")),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ahmed Saeed",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "ahmed.saeed@gmail.com",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    ),
  );
}

/*** load call logs from the device ***/
Future<Iterable<CallLogEntry>> getCallLog() async {
  return await CallLog.get();
}

/*** load contacts from the device ***/
Future<List<Contact>> getMyContacts() async {
  return await FlutterContacts.getContacts(
      withProperties: true, withAccounts: true, withPhoto: true);
}
/*** load sms from the device ***/

Future<List<SmsMessage>> getSmsMsgs() async {
  SmsQuery query = SmsQuery();
  var permission = await Permission.sms.status;
  if (permission.isGranted) {
    return await query.getAllSms;
  } else {
    Permission.sms.request();
    return await query.getAllSms;
  }
}

