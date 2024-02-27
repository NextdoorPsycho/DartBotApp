import 'package:fast_log/fast_log.dart';
import 'package:nyxx/nyxx.dart';
import 'package:shit_ui_app/bot_shit/bot_main.dart';

import 'model/channel.dart';

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

  Future<Map<String, dynamic>> gatherChats() async {
    Map<String, dynamic> organizedChannels = {};
    var guild = await nyxxBotClient.guilds.get(Snowflake(botServerId));
    var channels = await guild.fetchChannels();

    Map<Snowflake?, EChannel> channelMap = {};
    List<EChannel> topLevelChannels = [];

    // Convert and organize channels
    for (var channel in channels) {
      var eChannel = EChannel.fromGuildChannel(channel);
      channelMap[channel.id] = eChannel;

      if (channel.parentId == null) {
        topLevelChannels.add(eChannel);
      } else {
        channelMap[channel.parentId]?.addChild(eChannel);
      }
    }

    // Sort channels and categories
    for (var channel in topLevelChannels) {
      channel.sortChildren();
    }
    topLevelChannels.sort((a, b) => a.position.compareTo(b.position));

    // Convert to desired structure
    organizedChannels = {
      'categories': topLevelChannels
          .where((c) => c.type == ChannelType.guildCategory)
          .toList(),
      'standaloneChannels': topLevelChannels
          .where((c) => c.type != ChannelType.guildCategory)
          .toList(),
    };

    return organizedChannels;
  }
}
