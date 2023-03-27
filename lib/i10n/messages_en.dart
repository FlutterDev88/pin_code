import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';
  
  final messages = _notInlinedMessages(_notInlinedMessages);
  
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "chooseOption" : MessageLookupByLibrary.simpleMessage("Choose Option"),
    "createPINCode" : MessageLookupByLibrary.simpleMessage("Create PIN code"),
    "authByPINCode" : MessageLookupByLibrary.simpleMessage("Authentication by PIN code"),
    "enterYourPIN" : MessageLookupByLibrary.simpleMessage("Enter your PIN"),
    "createPIN" : MessageLookupByLibrary.simpleMessage("Create PIN"),
    "reEnterYourPIN" : MessageLookupByLibrary.simpleMessage("Re-enter your PIN"),
    "setupPIN" : MessageLookupByLibrary.simpleMessage("Setup PIN"),
    "useFourDigitsPIN" : MessageLookupByLibrary.simpleMessage("Use 4-digits PIN"),
    "authSuccess" : MessageLookupByLibrary.simpleMessage("Authentication success"),
    "authFailed" : MessageLookupByLibrary.simpleMessage("Authentication failed"),
    "pinCreated" : MessageLookupByLibrary.simpleMessage("Your PIN has benn set up successfully!"),
    "pinNonCreated" : MessageLookupByLibrary.simpleMessage("Pin codes do not match"),
    "ok" : MessageLookupByLibrary.simpleMessage("OK"),
    "boxName" : MessageLookupByLibrary.simpleMessage("PIN_BOX"),
    "keyName" : MessageLookupByLibrary.simpleMessage("PIN_Key"),
  };
}