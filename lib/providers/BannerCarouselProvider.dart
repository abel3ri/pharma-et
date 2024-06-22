import 'package:flutter/material.dart';

class BannerCarouselProvider with ChangeNotifier {
  int _currentIndex = 0;

  void changeCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
}
