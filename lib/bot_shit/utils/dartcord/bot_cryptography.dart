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

  Future<Map<String, Snowflake>> gatherChatsOLD() async {
    Map<String, Snowflake> chanMap = {};
    var guild = await nyxxBotClient.guilds.get(Snowflake(botServerId));
    var channels = await guild.fetchChannels();
    for (var channel in channels) {
      info("Name: ${channel.name}ID ${channel.id}");
      chanMap[channel.name] = channel.id;
      channel.parent; // Parent channel
      channel.position; // Position of the channel
      channel.parentId; // Parent channel id
      channel.type ==
          ChannelType
              .guildAnnouncement; // Check if channel is announcement channel
      channel.type == ChannelType.guildText; // Check if channel is text channel
      channel.type ==
          ChannelType.guildVoice; // Check if channel is voice channel
      channel.type == ChannelType.guildCategory; // Check if channel is category
      channel.type ==
          ChannelType.guildStageVoice; // Check if channel is stage channel
      channel.type ==
          ChannelType.privateThread; // Check if channel is private thread
      channel.type ==
          ChannelType.publicThread; // Check if channel is public thread
      channel.type ==
          ChannelType.guildMedia; // Check if channel is media channel
      channel.type ==
          ChannelType.guildForum; // Check if channel is news channel
    }
    return chanMap;
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
    // Extract top-level categories and standalone channels
    List<dynamic> topLevelCategories = [];
    List<dynamic> standaloneChannels = categoryMap[null] ?? [];

    for (var channel in channels) {
      if (channel.type == ChannelType.guildCategory) {
        var categoryDetails = {
          'id': channel.id,
          'name': channel.name,
          'type': channel.type,
          'position': channel.position,
          'channels': categoryMap[channel.id] ?? [],
        };
        topLevelCategories.add(categoryDetails);
      }
    }

    // Sort top-level categories and standalone channels by position
    topLevelCategories.sort((a, b) => a['position'].compareTo(b['position']));
    standaloneChannels.sort((a, b) => a['position'].compareTo(b['position']));

    // Combine categories and standalone channels in order
    Map<String, dynamic> organizedChannels = {
      'categories': topLevelCategories,
      'standaloneChannels': standaloneChannels,
    };

    printChannelHierarchy(organizedChannels);
    return organizedChannels;
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
      // Again, threads handling can be added here if applicable
    }
  }
}
