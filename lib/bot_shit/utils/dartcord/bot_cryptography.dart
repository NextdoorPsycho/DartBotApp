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

  Future<Map<String, dynamic>> gatherChats() async {
    Map<String, dynamic> organizedChannels = {};
    var guild = await nyxxBotClient.guilds.get(Snowflake(botServerId));
    var channels = await guild.fetchChannels();

    // Temporary storage to organize channels by category
    Map<Snowflake?, List<dynamic>> categoryMap = {};

    for (var channel in channels) {
      // Collecting detailed channel information
      var channelDetails = {
        'id': channel.id,
        'name': channel.name,
        'type': channel.type,
        'parentId': channel.parentId,
        'position': channel.position,
      };

      // Organizing channels by their parent ID (category)
      Snowflake? parentId = channel.parentId;
      if (categoryMap.containsKey(parentId)) {
        categoryMap[parentId]!.add(channelDetails);
      } else {
        categoryMap[parentId] = [channelDetails];
      }
    }

    // Sorting channels within each category by their position
    categoryMap.forEach((parentId, channels) {
      channels.sort((a, b) => a['position'].compareTo(b['position']));
    });

    // Organize and sort top-level categories and channels
    organizedChannels = organizeAndSortCategories(categoryMap, channels);

    return organizedChannels;
  }

  Map<String, dynamic> organizeAndSortCategories(
      Map<Snowflake?, List<dynamic>> categoryMap,
      Iterable<GuildChannel> channels) {
    List<dynamic> topLevelCategories = [];
    List<dynamic> standaloneChannels = categoryMap[null] ?? [];

    for (var channel in channels) {
      if (channel.type == ChannelType.guildCategory) {
        var categoryDetails = {
          'id': channel.id,
          'name': channel.name,
          'type': channel.type,
          'position': channel.position,
          'channels': categoryMap[channel.id]?.toList() ??
              [], // Ensure a list is always provided
        };
        // Ensure the list is not null before sorting
        (categoryDetails['channels'] as List).sort((a, b) {
          int typeComparison = _compareChannelType(a['type'], b['type']);
          if (typeComparison != 0) return typeComparison;
          return a['position'].compareTo(b['position']);
        });
        topLevelCategories.add(categoryDetails);
      }
    }

    topLevelCategories.sort((a, b) => a['position'].compareTo(b['position']));
    standaloneChannels.sort((a, b) => a['position'].compareTo(b['position']));

    Map<String, dynamic> organizedChannels = {
      'categories': topLevelCategories,
      'standaloneChannels': standaloneChannels,
    };

    return organizedChannels;
  }

  int _compareChannelType(dynamic aType, dynamic bType) {
    if (aType == bType) return 0;
    if (aType == ChannelType.guildText) return -1;
    if (bType == ChannelType.guildText) return 1;
    // Adjust the comparison logic as needed for other types
    return 0;
  }

  void printChannelHierarchy(Map<String, dynamic> organizedChannels) {
    // Print top-level categories and their channels
    for (var category in organizedChannels['categories']) {
      info('= ${category['name']}');
      for (var channel in category['channels']) {
        // Assuming 'type' is a ChannelType or similar, adjust the comparison as needed
        if (channel['type'] == ChannelType.guildText ||
            channel['type'] == ChannelType.guildVoice) {
          info('== ${channel['name']}');
          // Optionally, handle threads if they are part of your structure
          // This part is skipped as it depends on how threads are stored/retrieved
        }
      }
    }

    // Print standalone channels (not under any category)
    for (var channel in organizedChannels['standaloneChannels']) {
      if (channel['type'] != ChannelType.guildCategory) {
        info('- ${channel['name']}');
      }
    }
  }
}
