import 'package:flutter/material.dart';
import 'package:shit_ui_app/bot_functions.dart'; // Adjust the import path as necessary

class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  final BotFunctions botFunctions = BotFunctions();
  late TextEditingController botTokenController;
  late TextEditingController botOwnerIdController;
  late TextEditingController openaiKeyController;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    botOwnerIdController = TextEditingController();
    openaiKeyController = TextEditingController();
    loadSavedData();
  }

  void loadSavedData() async {
    await botFunctions.loadSavedData();
    setState(() {
      botTokenController.text = botFunctions.botToken;
      botOwnerIdController.text = botFunctions.botOwnerId;
      openaiKeyController.text = botFunctions.openaiKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;
    Color statusColor = botFunctions.botStatus == BotStatus.off
        ? Colors.red
        : botFunctions.botStatus == BotStatus.on
        ? colorScheme.secondary
        : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Discord Bot', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 24)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon(Icons.circle, color: statusColor),
          ),
        ],
        backgroundColor: colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildBotToolsSection(context)],
        ),
      ),
    );
  }

  Widget _buildBotToolsSection(BuildContext context) {
    ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
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
              title: Text(botFunctions.botStatus == BotStatus.off
                  ? 'Start Bot'
                  : 'Stop Bot'),
              leading: Icon(botFunctions.botStatus == BotStatus.off
                  ? Icons.play_arrow
                  : Icons.stop, color: colorScheme.onSurface),
              onTap: () => botFunctions.toggleBot((status) => setState(() {})),
              subtitle: Text('Tap to ${botFunctions.botStatus == BotStatus.off
                  ? 'start'
                  : 'stop'} the bot',
                  style: TextStyle(color: colorScheme.onSurface)),
            ),
            const Divider(),
            _textField(
                'Bot Token', botTokenController, botFunctions.saveBotToken,
                context),
            _textField(
                'Owner ID', botOwnerIdController, botFunctions.saveOwnerId,
                context),
            _textField(
                'OpenAI Key', openaiKeyController, botFunctions.saveOpenAIKey,
                context),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller,
      Function(String) onSubmitted, BuildContext context) {
    ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          labelStyle: TextStyle(color: colorScheme.onSurface),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary),
          ),
        ),
        onSubmitted: (value) {
          onSubmitted(value);
        },
      ),
    );
  }
}