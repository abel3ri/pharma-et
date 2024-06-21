import 'package:flutter/material.dart';

class LoginFormProvider with ChangeNotifier {
  bool _showPassword = false;
  bool _isLoading = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get showPassword => _showPassword;
}
