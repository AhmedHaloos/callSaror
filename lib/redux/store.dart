import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:redux/redux.dart';
import 'package:sarorcall/redux/reducers.dart';

import 'actions.dart';

class MyAppStore {

   final Store<AppState> store = new Store(rootReducer, initialState:new AppState([], [], [], [], [], []) );
   int testValue = 0;
   List<Contact> contacts = [];
   List<CallLogEntry> dispCallLog = [];
   List<CallLogEntry> callLogs = [];
   List<SmsMessage> smsMsgs = [];
   List<SmsMessage> dispMsgs = [];
  static final MyAppStore _instance = MyAppStore._internal();

  MyAppStore._internal(){
    print("MyAppStore");
  }
  factory MyAppStore(){
    return _instance;
  }

}