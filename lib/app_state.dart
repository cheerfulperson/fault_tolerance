import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  String title = "Главный экран";

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
