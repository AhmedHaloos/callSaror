import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:sarorcall/redux/actions.dart';


  AppState rootReducer(AppState oldState, dynamic action) {
    if (action is ContactAction) {
      return _contactReducer(oldState, action);
    } else if (action is LogAction) {
      return _logReducer(oldState, action);
    } else if (action is SmsMsgAction) {
      return _smsMsgReducer(oldState, action);
    }
    else {
      return oldState;
    }
  }

  AppState _contactReducer(AppState oldState, ContactAction action) {
    switch (action.actionType) {
      case AppAction.getAllAction:
        // print("old state = ${oldState.contacts.length}");
        // print(" actions =  ${action.contacts.length}");
         List<Contact> newList = oldState.contacts.isEmpty? new List<Contact>.from(action.contacts) : oldState.contacts;
         List<Contact> newDispList = oldState.contacts.isEmpty? new List<Contact>.from(action.dispContacts) : oldState.contacts;
         // print("contact new list = ${newList.length}");
         // print("contact new disp list =  ${newDispList.length}");
        return AppState(newList, oldState.logs, oldState.smsMsgs,newDispList,oldState.dispLogs, oldState.dispSmsMsgs);
      default:
        return oldState;
    }
  }

  AppState _logReducer(AppState oldState, LogAction action) {
    // print("log reducer");
    switch (action.actionType) {
      case AppAction.getAllAction:
        // print("old state = ${oldState.logs.length}");
        // print(" actions =  ${action.logs.length}");
        List<CallLogEntry> newList = oldState.logs.isEmpty? new List<CallLogEntry>.from(action.logs) : oldState.logs;
        List<CallLogEntry> newDispList = oldState.dispLogs.isEmpty? new List<CallLogEntry>.from(action.dispLogs) : oldState.dispLogs;
        // print(" log new list = ${newList.length}");
        // print("log new disp list =  ${newDispList.length}");
        return AppState(oldState.contacts, newList , oldState.smsMsgs,oldState.dispContacts,newDispList,oldState.dispSmsMsgs);
      default:
        return oldState;
    }
  }

  AppState _smsMsgReducer(AppState oldState, SmsMsgAction action) {
    // print("sms reducer");
    switch (action.actionType) {
      case AppAction.getAllAction:
        // print("old state = ${oldState.smsMsgs.length}");
        // print(" actions =  ${action.smsMsgs.length}");
        List<SmsMessage> newList = oldState.smsMsgs.isEmpty ?  new List<SmsMessage>.from(action.smsMsgs) : oldState.smsMsgs;
        List<SmsMessage> newDispList = oldState.dispSmsMsgs.isEmpty ? new List<SmsMessage>.from(action.dispSmsMsgs) : oldState.dispSmsMsgs;
        // print("sms new list = ${newList.length}");
        // print("sms  new disp list =  ${newDispList.length}");
        return AppState(oldState.contacts, oldState.logs, newList,oldState.dispContacts,oldState.dispLogs,newDispList);
      default:
        return oldState;
    }
  }

