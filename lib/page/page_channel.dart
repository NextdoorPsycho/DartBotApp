import 'dart:async';

import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:nyxx/nyxx.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_cryptography.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/model/channel.dart';
import 'package:shit_ui_app/page/prefabs/bot_ui_notifications.dart';
import 'package:shit_ui_app/utility/bot_functions.dart';

class BotServerViewport extends StatefulWidget {
  const BotServerViewport({super.key});

  @override
  State<BotServerViewport> createState() => _BotServerViewportState();
}

class _BotServerViewportState extends State<BotServerViewport> {
  Timer? _timer;
  int totalUsers = 0;
  final BotFunctions botFunctions = BotFunctions();
  late TextEditingController botTokenController;
  Map<String, dynamic>? _cachedChannels;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    loadSavedData();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      info("Timer ran");
      if (mounted && botStatus == BotStatus.on) {
        info("Updating Channels");
        await updateChannels();
        // Add any additional periodic tasks here
      } else {
        errorGeneric(
            context, "Can't Set Bot State!", "Turn your fucking bot on.");
        _clearData();
      }
    });
  }

  Future<void> updateChannels() async {
    try {
      var channels = await BotCryptography().gatherChats();
      if (!_mapsAreEqual(channels, _cachedChannels)) {
        if (mounted) {
          setState(() {
            _cachedChannels = channels;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        errorGeneric(context, "Can't Set Bot State!", "$e");
      }
    }
  }

  void loadSavedData() async {
    await botFunctions.loadSavedData();
    setState(() {
      botTokenController.text = botFunctions.botToken;
    });
  }

  bool _mapsAreEqual(Map<String, dynamic>? map1, Map<String, dynamic>? map2) {
    if (map1 == null || map2 == null) return false;
    if (map1.length != map2.length) return false;
    for (String key in map1.keys) {
      if (map2[key] != map1[key]) return false;
    }
    return true;
  }

  void _clearData() {
    setState(() {
      _cachedChannels = null;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discord Server Viewport'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: _cachedChannels == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildChannelList(context, _cachedChannels!),
                ],
              ),
            ),
    );
  }

  Widget _buildChannelList(
      BuildContext context, Map<String, dynamic> organizedChannels) {
    List<EChannel> standaloneChannels = organizedChannels['standaloneChannels'];
    List<EChannel> categories = organizedChannels['categories'];

    return Column(
      children: [
        // Display standalone channels first
        for (var channel in standaloneChannels)
          ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit_sharp),
                  onPressed: () {
                    // Pencil button tapped
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.folder_copy_sharp),
                  onPressed: () {
                    // Folder button tapped
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.delete_outline_sharp),
                    onPressed: () {
                      // Delete button tapped
                    }),
              ],
            ),
            leading: channel.type == ChannelType.guildText
                ? const Icon(Icons.chat_outlined)
                : const Icon(Icons.keyboard_voice_outlined),
            title: Text(channel.name),
            onTap: () {
              genericNotification(context, 'Channel Selected', channel.name);
            },
          ),
        // Then display top-level categories with their channels
        for (var category in categories)
          ExpansionTile(
            leading: const Icon(Icons.folder_open_sharp),
            title: Text(category.name),
            children: category.children
                    ?.map((child) => ListTile(
                          leading: child.type == ChannelType.guildText
                              ? const Icon(Icons.chat_outlined)
                              : const Icon(Icons.keyboard_voice_outlined),
                          title: Text(child.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.edit_sharp),
                                onPressed: () {
                                  // Pencil button tapped
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.folder_copy_sharp),
                                onPressed: () {
                                  // Folder button tapped
                                },
                              ),
                              IconButton(
                                  icon: const Icon(Icons.delete_outline_sharp),
                                  onPressed: () {
                                    // Delete button tapped
                                  }),
                            ],
                          ),
                          onTap: () {
                            genericNotification(
                                context, 'Channel Selected', child.name);
                          },
                        ))
                    .toList() ??
                [],
          ),
      ],
    );
  }
}
