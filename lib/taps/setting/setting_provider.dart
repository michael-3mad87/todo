import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode themMode = ThemeMode.light;
  String language = 'en';
    SettingProvider() {
    loadSettings();
  }

  Future<void> changeTheme(ThemeMode selectedTheme) async {
    themMode = selectedTheme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "themMode", selectedTheme == ThemeMode.light ? 'light' : 'dark');
  }

  Future<void> changeLanguage(String selectedLanguage) async {
    language = selectedLanguage;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', selectedLanguage);
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? them = prefs.getString("themMode");
    if (them != null) {
      themMode = them == 'light' ? ThemeMode.light : ThemeMode.dark;
    }
    String? lang = prefs.getString("language");
    if (lang != null) {
      language = lang;
    }
    notifyListeners();
  }
}
