import 'dart:async';

import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationsDelegate();

  static const supportedLocales = [Locale('de'), Locale('en')];

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<S> old) => false;
}
