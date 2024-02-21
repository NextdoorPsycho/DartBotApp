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
    // Use Theme.of(context) to get the current theme colors
    Color statusColor = botFunctions.botStatus == BotStatus.off
        ? Colors.grey // Consider making this dynamic too
        : botFunctions.botStatus == BotStatus.on
        ? Theme.of(context).colorScheme.secondary // Changed to use theme color
        : Colors.red; // Consider making this dynamic too

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Discord Bot',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 24)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 90, 0),
            child: Icon(
              Icons.circle,
              color: statusColor, // Use the dynamic color here
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_buildBotToolsSection(context)], // Pass context if needed
        ),
      ),
    );
  }

  Widget _buildBotToolsSection(BuildContext context) { // Context passed if needed for theme
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              title: Text(botFunctions.botStatus == BotStatus.off
                  ? 'Start Bot'
                  : 'Stop Bot'),
              leading: Icon(botFunctions.botStatus == BotStatus.off
                  ? Icons.play_arrow
                  : Icons.stop),
              onTap: () => botFunctions.toggleBot((status) => setState(() {})),
              subtitle: Text(
                  'Tap to ${botFunctions.botStatus == BotStatus.off ? 'start' : 'stop'} the bot'),
            ),
            const Divider(),
            _textField(
                'Bot Token', botTokenController, botFunctions.saveBotToken),
            _textField(
                'Owner ID', botOwnerIdController, botFunctions.saveOwnerId),
            _textField(
                'OpenAI Key', openaiKeyController, botFunctions.saveOpenAIKey),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller,
      Function(String) onSubmitted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          // Use theme colors for text field
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        onSubmitted: (value) {
          onSubmitted(value);
          setState(() {});
        },
      ),
    );
  }
}