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
        title: Text(
          'Discord Server Viewport',
          style: myTextStyle(context, bold: true, size: 24),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDiscordChannelFrameworlk(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildDiscordChannelFrameworlk(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
              title: Text(
                'Server Viewport',
                style: myTextStyle(context),
              ),
              subtitle: Text(
                'View your Discord server in a viewport.',
                style: myTextStyle(context),
              ),
              onTap: () => _notification(context)),
          const Divider(),
        ],
      ),
    ),
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
      style: myTextStyle(context, bold: true, size: 24),
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
    applyBlurEffect: true,
  );
}
