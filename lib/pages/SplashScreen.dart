import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarorcall/main.dart';
import 'package:sarorcall/pages/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  SharedPreferences? prefs;
  bool permGrantedSateLoaded = false;
  @override
  void initState() {

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    requestPermission(context);
    });
    // SharedPreferences.getInstance()
    // .then((preferences){
    //   prefs = preferences;
    //   if(prefs!.get("perm") != null && prefs!.get("perm") == true){
    //     setState(() {
    //       permGrantedSateLoaded = true;
    //       print(permGrantedSateLoaded);
    //     });
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        backgroundColor: Colors.blue,
        body:
        // permGrantedSateLoaded == false ?
        // Center(
        //   child: CircularProgressIndicator(
        //     color: Colors.white ,
        //     strokeWidth: 2,
        //   ),
        // )
        //     :
        Container(
          alignment: Alignment.bottomCenter,
          child: Column(children: [
            SizedBox(
              height: 200,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              child: Image.asset(
                "assets/images/logo.jpg",
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFf8f8f8),
                  fixedSize: Size(300, 50),
                ),
                onPressed: () async {
                  requestPermission(context);
                  // bool smsPermGranted, contactPermGranted;
                  // if ((await Permission.sms.isPermanentlyDenied)) {
                  //   print("sms Denied");
                  //   smsPermGranted = false;
                  // } else {
                  //   smsPermGranted = (await Permission.sms.request()).isGranted;
                  // }
                  //
                  // if ((await Permission.contacts.isPermanentlyDenied)) {
                  //   print("contacts Denied");
                  //   contactPermGranted = false;
                  // } else {
                  //   contactPermGranted =
                  //       (await Permission.contacts.request()).isGranted;
                  // }
                  //
                  // if (smsPermGranted == false || contactPermGranted == false) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) => PermissionDialog(),
                  //   );
                  // } else {
                  //   if (prefs!.getBool('perm') == null) {
                  //     prefs!.setBool("perm", true);
                  //   }
                  //
                  //   Navigator.pushReplacement(context,
                  //       MaterialPageRoute(builder: (context) => Home(0)));
                  // }
                },
                child: Text(
                  "Let`s Go",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ]),
        ));
  }
}

class PermissionDialog extends StatelessWidget {
  PermissionDialog();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text("Permissions"),
        content: Text("you have to allow the app to access contacts and sms"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "cancel",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppSettings.openAppSettings();
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "settings",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
}

void requestPermission(BuildContext context) async{
  SharedPreferences  prefs = await SharedPreferences.getInstance();
  bool smsPermGranted, contactPermGranted;
  if(prefs.get("perm") == true){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>Login()));
    return ;
  }
  if ((await Permission.sms.isPermanentlyDenied)) {
    print("sms Denied");
    smsPermGranted = false;
  } else {
    smsPermGranted = (await Permission.sms.request()).isGranted;
  }

  if ((await Permission.contacts.isPermanentlyDenied)) {
  print("contacts Denied");
  contactPermGranted = false;
  } else {
  contactPermGranted =
  (await Permission.contacts.request()).isGranted;
  }

  if (smsPermGranted == false || contactPermGranted == false) {
  showDialog(
  context: context,
  builder: (context) => PermissionDialog(),
  );
  }
  else {
  if (prefs!.getBool('perm') == null) {
  prefs!.setBool("perm", true);
  }
  Navigator.pushReplacement(context,
  MaterialPageRoute(builder: (context) => Login()));
  }

}