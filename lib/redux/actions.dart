import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

class AppAction {
 // static final List<String> actions = [
   static const getAllAction = "getAll";
   // static const getOneAction = "getOne";
   // static const getSomeAction = "getSome";
   static const insetOne = "postOne";
   static const updateOne = "putOne";
   static const deleteOne = "deleteOne";
   // static const deleteMany = "deleteMany";
}
class ContactAction implements AppAction {
  List<Contact> contacts = [];
  List<Contact> dispContacts = [];
  bool cont = false;
  String actionType = AppAction.getAllAction;

  ContactAction(this.contacts, this.dispContacts,this.cont,  this.actionType);
}
class LogAction implements AppAction{
  List<CallLogEntry> logs = [];
  List<CallLogEntry> dispLogs = [];
  bool log = false;
  String actionType = AppAction.getAllAction;

  LogAction(this.logs, this.dispLogs,this.log, this.actionType);

}
class SmsMsgAction implements AppAction  {
  List<SmsMessage> smsMsgs = [];
  List<SmsMessage> dispSmsMsgs = [];
  bool sms = false;
  String actionType = AppAction.getAllAction;

  SmsMsgAction(this.smsMsgs, this.dispSmsMsgs,this.sms, this.actionType);
}
class AppState{
  List<Contact> contacts = [];
  List<CallLogEntry> logs = [];
  List<SmsMessage> smsMsgs = [];

  List<Contact> dispContacts = [];
  List<CallLogEntry> dispLogs = [];
  List<SmsMessage> dispSmsMsgs = [];

  bool log = false;
  bool cont = false;
  bool sms = false;

  AppState(this.contacts, this.logs, this.smsMsgs, this.dispContacts, this.dispLogs, this.dispSmsMsgs);
  AppState.contact(this.contacts, this.dispContacts, this.cont);
  AppState.log(this.logs, this.dispLogs, this.log);
  AppState.smsMsg(this.smsMsgs,this.dispSmsMsgs, this.sms);

}