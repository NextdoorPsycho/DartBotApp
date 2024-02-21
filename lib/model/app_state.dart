import 'package:flutter/material.dart';

enum AppThemeMode { light, dark }

class BotDataModel with ChangeNotifier {
  String _botToken = '';
  String _botOwnerId = '';
  AppThemeMode _themeMode = AppThemeMode.light; // Default to light theme

  String get botToken => _botToken;
  String get botOwnerId => _botOwnerId;
  AppThemeMode get themeMode => _themeMode;

  void setBotToken(String newToken) {
    _botToken = newToken;
    notifyListeners();
  }

  void setBotOwnerId(String newOwnerId) {
    _botOwnerId = newOwnerId;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    notifyListeners();
  }
}
