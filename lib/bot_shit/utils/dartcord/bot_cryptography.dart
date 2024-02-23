import 'package:fast_log/fast_log.dart';
import 'package:nyxx/nyxx.dart';
import 'package:shit_ui_app/bot_shit/bot_main.dart';

class BotCryptography {
  Future<int> computeMembers() async {
    int totalMembers = 0;
    try {
      await for (var member in nyxxBotClient.gateway
          .listGuildMembers(Snowflake(botServerId), limit: 500)) {
        totalMembers += 1;
      }
    } catch (e) {
      error(e);
    }
    return totalMembers;
  }

  Future<Map<String, Snowflake>?> gatherMembers() async {
    Map<String, Snowflake> memberMap = {};
    try {
      await for (var member in nyxxBotClient.gateway
          .listGuildMembers(Snowflake(botServerId), limit: 500)) {
        memberMap[member.user!.username] = member.id;
      }
    } catch (e) {
      error(e);
    }
    return memberMap;
  }
}
