import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nyxx/nyxx.dart';

import 'dart:async';

import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_cryptography.dart';

class UserControlPage extends StatefulWidget {
  const UserControlPage({super.key});

  @override
  _UserControlPageState createState() => _UserControlPageState();
}

class _UserControlPageState extends State<UserControlPage> {
  Timer? _timer;
  int totalUsers = 0;
  int onlineUsers = 0;
  int offlineUsers = 0;
  Map<String, Snowflake> userList = {};   // Changed from Future<List<String>?> to Map<String, int>.

  @override
  void initState() {
    super.initState();
    fetchUserList();  // Call fetchUserList() in initState.
  }

  Future<void> fetchUserList() async {
    userList = (await BotCryptography().gatherMembers())!;
    for (var entry in userList.entries) {
      info('${entry.key} - ${entry.value}');
    }
  }

  @override
  void didChangeDependencies() {
    _timer = Timer.periodic(
        const Duration(seconds: 3),
        (Timer t) {
          if(mounted) {
            fetchUserStatistics();
          }
        });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchUserStatistics() async {
    totalUsers = await BotCryptography().computeMembers();
    info("Checked Member list: $totalUsers");
    if (mounted) {
      setState(() {
        // Update statistics here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Control'),
        backgroundColor: colorScheme.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Statistics',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 8.0),
                      Text('Total Users: $totalUsers', style: TextStyle(fontSize: 16, color: colorScheme.onSurface)),
                      Text('Online: $onlineUsers / Offline: $offlineUsers', style: TextStyle(fontSize: 16, color: colorScheme.onSurface)),
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
              Padding(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Actions', style: TextStyle(fontSize: 18, color: colorScheme.onSurface)),
                      // Placeholder for user actions
                      const SizedBox(height: 8.0),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.refresh, color: colorScheme.primary),
                        label: Text('Refresh', style: TextStyle(color: colorScheme.primary)),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: colorScheme.primary),
                        label: Text('Add User', style: TextStyle(color: colorScheme.primary)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
                            Clipboard.setData(
                                ClipboardData(text: userList[userList.keys.elementAt(index)].toString()));
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