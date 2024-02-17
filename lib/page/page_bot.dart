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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Discord Bot', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 24)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 90, 0),
            child: Icon(
              Icons.circle,
              color: botFunctions.botStatus == BotStatus.off ? Colors.grey : botFunctions.botStatus == BotStatus.on ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBotToolsSection()
          ],
        ),
      ),
    );
  }

  Widget _buildBotToolsSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              title: Text(botFunctions.botStatus == BotStatus.off ? 'Start Bot' : 'Stop Bot'),
              leading: Icon(botFunctions.botStatus == BotStatus.off ? Icons.play_arrow : Icons.stop),
              onTap: () => botFunctions.toggleBot((status) => setState(() {})),
              subtitle: Text('Tap to ${botFunctions.botStatus == BotStatus.off ? 'start' : 'stop'} the bot'),
            ),
            const Divider(),
            _textField('Bot Token', botTokenController, botFunctions.saveBotToken),
            _textField('Owner ID', botOwnerIdController, botFunctions.saveOwnerId),
            _textField('OpenAI Key', openaiKeyController, botFunctions.saveOpenAIKey),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller, Function(String) onSubmitted) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          onSubmitted(value);
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    botTokenController.dispose();
    botOwnerIdController.dispose();
    openaiKeyController.dispose();
    super.dispose();
  }
}
