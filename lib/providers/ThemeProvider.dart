import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  SharedPreferences prefs;
  ThemeProvider({
    required this.prefs,
  });

  String get theme {
    return prefs.getString("theme") ?? "system";
  }

  void changeThemeMode(String themeMode) {
    prefs.setString("theme", themeMode);
    notifyListeners();
  }
}
