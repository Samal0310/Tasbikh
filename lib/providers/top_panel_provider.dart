import 'package:flutter/cupertino.dart';

class TopPanelProvider extends ChangeNotifier {
  bool activity = true;

  void toggleActivity() {
    activity = !activity;
    notifyListeners();
  }
}
