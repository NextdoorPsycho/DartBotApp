import 'package:flutter/material.dart';

class BotDataModel with ChangeNotifier {
  String _botToken = '';
  String _botOwnerId = '';

  String get botToken => _botToken;
  String get botOwnerId => _botOwnerId;

  void setBotToken(String newToken) {
    _botToken = newToken;
    notifyListeners();
  }

  void setBotOwnerId(String newOwnerId) {
    _botOwnerId = newOwnerId;
    notifyListeners();
  }
}
