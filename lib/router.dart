import 'package:flutter/material.dart';
import 'package:pin_code/auth_pin/page/auth_pin_page.dart';
import 'package:pin_code/create_pin/page/create_pin_page.dart';
import 'package:pin_code/home_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) => const HomePage(),
    'auth_pin': (BuildContext context) => const AuthPINPage(),
    'create_pin': (BuildContext context) => const CreatePINPage(),
  };
}