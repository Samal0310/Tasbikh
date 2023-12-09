import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/models/dhikr.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class HiveProvider extends ChangeNotifier {
  late Box<Dhikr> dhikrs;

  HiveProvider() {
    openBox();
  }
  Future<void> openBox() async {
    dhikrs = await Hive.openBox<Dhikr>('dhikrs');
    notifyListeners();
  }

  Future<void> saveDhikr(Dhikr dhikr) async {
    dhikrs.add(dhikr);
  }

  Future<void> editDhikr(int index, Dhikr dhikr) async {
   await dhikrs.putAt(index, dhikr);
  }

  Future<void> deleteDhikr(int index) async {
   await dhikrs.deleteAt(index);
  }

  @override
  void dispose() {
    dhikrs.close();
    super.dispose();
  }
}
