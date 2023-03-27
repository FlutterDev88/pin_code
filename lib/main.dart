import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pin_code/home_page.dart';
import 'package:pin_code/i10n/app_localizations.dart';
import 'package:pin_code/i10n/app_localizations_delegate.dart';
import 'package:pin_code/router.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const PinCodeApp());
}

class PinCodeApp extends StatelessWidget {
  const PinCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: S.delegates,
      supportedLocales: AppLocalizationsDelegate.supportedLocales,
      routes: getRoutes(context),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          )
        ),
      ),
    );
  }
}