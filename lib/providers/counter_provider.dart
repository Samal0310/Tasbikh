import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CounterProvider extends ChangeNotifier {
  int counter = 0;

  CounterProvider() {
    getCounterFromPrefs();
  }

  Future<void> getCounterFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('counter')) {
      counter = prefs.getInt('counter') ?? 0;

      notifyListeners();
    }
  }


Future<void> increment() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  counter++;
  notifyListeners();

  prefs.setInt('counter', counter);
}

void decrement() async {
  if (counter > 0) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    counter--;
    notifyListeners();
    prefs.setInt('counter', counter);

  }
}

Future<void> zeroing() async {
  if (counter != 0) {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    counter = 0;
    notifyListeners();
    prefs.setInt('counter', counter);
  }
}
}