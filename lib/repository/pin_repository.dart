import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pin_code/i10n/app_localizations.dart';

abstract class PINRepository{
  void close();
  void addPin(String pin);
  Future<bool> pinEquals (String pin);
}

class HivePINRepository extends PINRepository{
  HivePINRepository({required this.context});

  BuildContext context;
  
  @override
  void addPin(String pin) async {
    Box<String> box = Hive.isBoxOpen(S.of(context).boxName) ? Hive.box(S.of(context).boxName) : await Hive.openBox(S.of(context).boxName);

    box.put(S.of(context).keyName, pin);
  }

  @override
  Future<bool> pinEquals(String pin) async {
    Box<String> box = Hive.isBoxOpen(S.of(context).boxName) ? Hive.box(S.of(context).boxName) : await Hive.openBox(S.of(context).boxName);

    return box.get(S.of(context).keyName, defaultValue: S.of(context).keyName) == pin;
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(S.of(context).boxName)) {
      Box<String> box = await Hive.box(S.of(context).boxName);
      var v = await box.close();
      return v;
      //return await Hive.box(_boxName).close();
    }
  }
}