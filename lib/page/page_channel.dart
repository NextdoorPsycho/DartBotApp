import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
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
        title: Text('Discord Server Viewport'),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}

Widget _buildChannelList(BuildContext context, Map<String, dynamic> data) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  List<Widget> categoryWidgets = [];

  for (var category in data['categories']) {
    List<Widget> channelWidgets = [];
    for (var channel in category['channels']) {
      channelWidgets.add(
        ListTile(
          title: Text(channel['name'],
              style: TextStyle(color: colorScheme.onSurface)),
          leading: Icon(Icons.text_snippet,
              color: colorScheme.primary), // Customized per channel type
          onTap: () {}, // Handle channel tap
        ),
      );
    }

    categoryWidgets.add(
      ExpansionTile(
        title: Text(category['name'],
            style: TextStyle(color: colorScheme.onSurface)),
        backgroundColor: colorScheme.surface,
        iconColor: colorScheme.primary,
        collapsedIconColor: colorScheme.onSurface,
        children: channelWidgets,
      ),
    );
  }

  for (var channel in data['standaloneChannels']) {
    categoryWidgets.add(
      ListTile(
        title: Text(channel['name'],
            style: TextStyle(color: colorScheme.onSurface)),
        leading: Icon(Icons.text_snippet,
            color: colorScheme.primary), // Customized per channel type
        onTap: () {}, // Handle channel tap
      ),
    );
  }

  return ListView(
    children: categoryWidgets,
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
