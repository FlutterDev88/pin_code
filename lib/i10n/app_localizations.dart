import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pin_code/i10n/app_localizations_delegate.dart';
import 'package:pin_code/i10n/messages_all.dart';

class S {
  /// Initialize localization systems and messages
  static Future<S> load(Locale locale) async {
    // If we're given "en_US", we'll use it as-is. If we're
    // given "en", we extract it and use it.
    final localeName = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : locale.toString();

    // We make sure the locale name is in the right format e.g.
    // converting "en-US" to "en_US".
    final canonicalLocaleName = Intl.canonicalizedLocale(localeName);
    
    // Load localized messages for the current locale.
    await initializeMessages(canonicalLocaleName);

    // Force the locale in Intl.
    Intl.defaultLocale = canonicalLocaleName;

    return S();
  }

  static List<LocalizationsDelegate> get delegates => [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
  
  static String get defaultLanguage => 'en';

  String get languageCode =>
      Intl.defaultLocale?.substring(0, 2) ?? defaultLanguage;

  /// Retrieve localization resources for the widget tree
  /// corresponding to the given `context`
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S) ?? S();
  }

  static String? getLocalizedString(Map<String, String> data) {
    //
    // First check the full locale including region to enable
    // differentiation between de_DE and de_CH for example.
    //
    if (data.keys.contains(Intl.defaultLocale)) {
      return data[Intl.defaultLocale];
    }

    //
    // As a fallback, retrieve the string by language lookup.
    // (de, en, it, ...)
    //
    final shortLocale = Intl.defaultLocale?.substring(0, 1) ?? defaultLanguage;
    if (data.keys.contains(shortLocale)) {
      return data[shortLocale];
    }

    //
    // If that also doesn't work, look for "en"
    //
    if (data.keys.contains('en')) {
      return data['en'];
    }

    //
    // If no match was found, return an empty string to prevent unexpected crashes.
    //
    return '';
  }

  String get chooseOption => Intl.message(
    'Choose Option',
    name: 'chooseOption',
    desc: 'Choose Option',
  );

   String get createPINCode => Intl.message(
    'Create PIN code',
    name: 'createPINCode',
    desc: 'Create PIN code',
  );

  String get authByPINCode => Intl.message(
    'Authentication by PIN code',
    name: 'authByPINCode',
    desc: 'Authentication by PIN code',
  );

  String get enterYourPIN => Intl.message(
    'Enter your PIN',
    name: 'enterYourPIN',
    desc: 'Enter your PIN',
  );

  String get createPIN => Intl.message(
    'Create PIN',
    name: 'createPIN',
    desc: 'Create PIN',
  );

  String get reEnterYourPIN => Intl.message(
    'Re-enter your PIN',
    name: 'reEnterYourPIN',
    desc: 'Re-enter your PIN',
  );

  String get setupPIN => Intl.message(
    'Setup PIN',
    name: 'setupPIN',
    desc: 'Setup PIN',
  );

  String get useFourDigitsPIN => Intl.message(
    'Use 4-digits PIN',
    name: 'useFourDigitsPIN',
    desc: 'Use 4-digits PIN',
  );

  String get authSuccess => Intl.message(
    'Authentication success',
    name: 'authSuccess',
    desc: 'Authentication success',
  );

  String get authFailed => Intl.message(
    'Authentication failed',
    name: 'authFailed',
    desc: 'Authentication failed',
  );

  String get pinCreated => Intl.message(
    'Your PIN has benn set up successfully!',
    name: 'pinCreated',
    desc: 'Your PIN has benn set up successfully!',
  );

  String get pinNonCreated => Intl.message(
    'Pin codes do not match',
    name: 'pinNonCreated',
    desc: 'Pin codes do not match',
  );

  String get ok => Intl.message(
    'OK',
    name: 'ok',
    desc: 'OK',
  );

  String get boxName => Intl.message(
    'PIN_BOX',
    name: 'boxName',
    desc: 'PIN_BOX',
  );

  String get keyName => Intl.message(
    'PIN_Key',
    name: 'keyName',
    desc: 'PIN_Key',
  );
}