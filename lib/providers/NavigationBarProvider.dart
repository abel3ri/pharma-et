import 'package:flutter/material.dart';

class NavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}
