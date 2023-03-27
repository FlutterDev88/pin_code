import 'package:flutter/material.dart';
import 'package:pin_code/auth_pin/page/auth_pin_page.dart';
import 'package:pin_code/create_pin/page/create_pin_page.dart';
import 'package:pin_code/i10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).chooseOption,
          style: const TextStyle(color: Colors.black))
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, 'create_pin');
              },
              child: Center(
                  child: Text(S.of(context).createPIN)
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, 'auth_pin');
              },
              child: Center(
                  child: Text(S.of(context).enterYourPIN)
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}