import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:nyxx/nyxx.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_cryptography.dart';
import 'package:shit_ui_app/main.dart';
import 'package:shit_ui_app/utility/bot_functions.dart';
import 'package:toastification/toastification.dart'; // Adjust the import path as necessary

class BotServerViewport extends StatefulWidget {
  const BotServerViewport({super.key});

  @override
  State<BotServerViewport> createState() => _BotServerViewportState();
}

class _BotServerViewportState extends State<BotServerViewport> {
  int totalUsers = 0;
  final BotFunctions botFunctions = BotFunctions();
  late TextEditingController botTokenController;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    loadSavedData();
  }

  void loadSavedData() async {
    info('Loading saved data...');
    await botFunctions.loadSavedData();
    setState(() {
      // botTokenController.text = botFunctions.botToken;
    });
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
        body: FutureBuilder(
          future: BotCryptography().gatherChats(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Ensure data is not null by providing a fallback value or ensuring non-null
              final chatsData =
                  snapshot.data ?? {}; // Fallback to an empty map if null
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildChannelList(context, chatsData),
                  ],
                ),
              );
            } else {
              // Handle the case where there's no error, but the data is still null
              return const Center(child: Text('No data available'));
            }
          },
        ));
  }
}

Widget _buildChannelList(
    BuildContext context, Map<String, dynamic> organizedChannels) {
  return Column(
    children: [
      // Display standalone channels first, ensuring no categories are included
      for (var channel in organizedChannels['standaloneChannels'])
        if (channel['type'] != ChannelType.guildCategory)
          ListTile(
            title: Text(channel['name']),
            onTap: () {
              // Handle channel tap
            },
          ),
      // Then display top-level categories with their channels, ensuring only text and voice channels are listed
      for (var category in organizedChannels['categories'])
        ExpansionTile(
          title: Text(category['name']),
          children: [
            for (var channel in category['channels'])
              ListTile(
                title: Text(channel['name']),
                onTap: () {
                  // Handle channel tap
                },
              ),
          ],
        ),
    ],
  );
}

_notification(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return toastification.show(
    context: context,
    backgroundColor: colorScheme.surface,
    type: ToastificationType.success,
    foregroundColor: colorScheme.onSurface,
    style: ToastificationStyle.minimal,
    title: Text(
      "Server Viewport",
      style: myTextStyle(context, title: true),
    ),
    description: Text(
      "View your Discord server in a viewport.",
      style: myTextStyle(context),
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 4),
    primaryColor: colorScheme.primary,
    icon: Icon(Icons.keyboard_arrow_right_sharp, color: colorScheme.onSurface),
    borderRadius: BorderRadius.circular(1.0),
    boxShadow: lowModeShadow,
    dragToClose: true,
    closeOnClick: true,
    closeButtonShowType: CloseButtonShowType.always,
    pauseOnHover: true,
    applyBlurEffect: false,
  );
}
