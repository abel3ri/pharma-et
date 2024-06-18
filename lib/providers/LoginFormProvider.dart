import 'package:flutter/material.dart';

class LoginFormProvider with ChangeNotifier {
  bool _showPassword = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  bool get showPassword => _showPassword;
}
