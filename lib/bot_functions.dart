import 'dart:async';

import 'package:fast_log/fast_log.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shit_ui_app/bot_shit/bot_main.dart';

enum BotStatus { off, on, stopping }

class BotFunctions {
  late String botToken;
  late String botOwnerId;
  late String openaiKey;
  BotStatus botStatus = BotStatus.off;

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    botToken = prefs.getString('botToken') ?? '';
    botOwnerId = prefs.getString('ownerId') ?? '';
    openaiKey = prefs.getString('openaiKey') ?? '';
  }

  Future<void> saveBotToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('botToken', value);
    botToken = value;
  }

  Future<void> saveOwnerId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ownerId', value);
    botOwnerId = value;
  }

  Future<void> saveOpenAIKey(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('openaiKey', value);
    openaiKey = value;
  }

  void toggleBot(Function(BotStatus) onStatusChange) {
    if (botStatus == BotStatus.off) {
      info('Starting bot...');
      info('Bot Token: $botToken');
      info('Owner ID: $botOwnerId');
      info('OpenAI Key: $openaiKey');
      botStart().then((value) {
        if (value) {
          success('Bot started successfully.');
          botStatus = BotStatus.on;
          onStatusChange(botStatus);
        } else {
          error('Failed to start the bot.');
        }
      });
    } else if (botStatus == BotStatus.on) {
      info('Stopping bot...');
      botStop().then((value) {
        if (value) {
          success('Bot stopped successfully.');
          botStatus = BotStatus.off;
          onStatusChange(botStatus);
        } else {
          error('Failed to stop the bot.');
        }
      });
    }
  }
}
