import 'dart:async';

import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nyxx/nyxx.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_cryptography.dart';
import 'package:shit_ui_app/utility/bot_functions.dart'; // Adjust the import path as necessary

class BotPage extends StatefulWidget {
  const BotPage({super.key});

  @override
  State<BotPage> createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  Timer? _timer;
  int totalUsers = 0;
  Map<String, Snowflake> userList = {};
  int _previousTotalUsers = 0;
  Map<String, Snowflake> _previousUserList = {};

  final BotFunctions botFunctions = BotFunctions();
  late TextEditingController botTokenController;
  late TextEditingController botOwnerIdController;
  late TextEditingController openaiKeyController;
  late TextEditingController serverIdSnowflake;

  @override
  void initState() {
    super.initState();
    botTokenController = TextEditingController();
    botOwnerIdController = TextEditingController();
    openaiKeyController = TextEditingController();
    serverIdSnowflake = TextEditingController();
    loadSavedData();
  }

  Future<void> fetchUserList() async {
    info('Fetching user list...');
    userList = (await BotCryptography().gatherMembers())!;
    for (var entry in userList.entries) {
      info('${entry.key} - ${entry.value}');
    }
  }

  @override
  void didChangeDependencies() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      if (mounted && botFunctions.botStatus == BotStatus.on) {
        await fetchUserStatistics(); // Assuming this updates totalUsers
        await fetchUserList(); // Assuming this updates userList
        bool shouldUpdate = false;

        if (_previousTotalUsers != totalUsers ||
            !_mapsAreEqual(_previousUserList, userList)) {
          _previousTotalUsers = totalUsers;
          _previousUserList = Map<String, Snowflake>.from(userList);
          shouldUpdate = true;
        }

        if (shouldUpdate) {
          setState(() {
            error("STATE WAS UPDATED");
          });
        }
      } else {
        if (_previousTotalUsers != 0 || _previousUserList.isNotEmpty) {
          _clearData();
          _previousTotalUsers = 0;
          _previousUserList.clear();
          userList.clear();
          setState(() {
            error("STATE WAS CLEARED");
            // Update statistics here
          });
        }
      }
    });
    super.didChangeDependencies();
  }

  bool _mapsAreEqual(Map<String, Snowflake> map1, Map<String, Snowflake> map2) {
    if (map1.length != map2.length) return false;
    for (String key in map1.keys) {
      if (map2[key] != map1[key]) return false;
    }
    return true;
  }

  void _clearData() {
    totalUsers = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchUserStatistics() async {
    totalUsers = await BotCryptography().computeMembers();
    info("Checked Member list: $totalUsers");
  }

  void loadSavedData() async {
    info('Loading saved data...');
    await botFunctions.loadSavedData();
    setState(() {
      botTokenController.text = botFunctions.botToken;
      botOwnerIdController.text = botFunctions.botOwnerId;
      openaiKeyController.text = botFunctions.openaiKey;
      serverIdSnowflake.text = botFunctions.serverId;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Discord Bot',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 24)),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBotToolsSection(context),
            _buildUserSection(context)
          ],
        ),
      ),
    );
  }

  Widget _buildBotToolsSection(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

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
              leading: Icon(
                  botFunctions.botStatus == BotStatus.off
                      ? Icons.play_arrow
                      : Icons.stop,
                  color: colorScheme.onSurface),
              onTap: () => botFunctions.toggleBot((status) => setState(() {})),
              subtitle: Text(
                  'Tap to ${botFunctions.botStatus == BotStatus.off ? 'start' : 'stop'} the bot',
                  style: TextStyle(color: colorScheme.onSurface)),
            ),
            const Divider(),
            _textField('Bot Token', botTokenController,
                botFunctions.saveBotToken, context),
            _textField('Owner ID', botOwnerIdController,
                botFunctions.saveOwnerId, context),
            _textField('OpenAI Key', openaiKeyController,
                botFunctions.saveOpenAIKey, context),
            _textField('Server ID', serverIdSnowflake,
                botFunctions.saveServerId, context),
            const Divider(),
          ],
        ),
      ),
    );
  }

  _buildUserSection(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Statistics',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 8.0),
                Text('Total Users: $totalUsers',
                    style:
                        TextStyle(fontSize: 16, color: colorScheme.onSurface)),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _showUserList(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
                  ),
                  child: const Text('View Users'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller,
      Function(String) onSubmitted, BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: TextField(
        controller: controller,
        obscureText: label == 'Bot Token' || label == 'OpenAI Key',
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

  void _showUserList(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              AppBar(
                backgroundColor: colorScheme.primary, // Adapt to theme
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('User List'),
              ),
              Expanded(
                child: ListTileTheme(
                  iconColor: colorScheme.primary, // Adapt icon color to theme
                  textColor: colorScheme.onSurface, // Adapt text color to theme
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userList.keys.elementAt(index)),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: userList[userList.keys.elementAt(index)]
                                    .toString()));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
