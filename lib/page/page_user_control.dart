import 'package:flutter/material.dart';

import 'dart:async';

class UserControlPage extends StatefulWidget {
  const UserControlPage({super.key});

  @override
  _UserControlPageState createState() => _UserControlPageState();
}

class _UserControlPageState extends State<UserControlPage> {
  int totalUsers = 0; // Placeholder for user statistics
  int onlineUsers = 0; // Placeholder for online users
  int offlineUsers = 0; // Placeholder for offline users
  List<String> userList = ["User1", "User2"]; // Example user list

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(seconds: 10), (Timer t) => fetchUserStatistics());
  }

  void fetchUserStatistics() {
    // Placeholder function to simulate fetching data
    setState(() {
      // Update your statistics here
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use Theme.of(context) to get the current theme's colors
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Control'),
        backgroundColor: colorScheme.primary, // Adapt to theme
      ),
      body: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Statistics',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8.0),
                    Text('Total Users: $totalUsers',
                        style: TextStyle(fontSize: 16, color: colorScheme.onSurface)), // Adapt text color to theme
                    Text('Online: $onlineUsers / Offline: $offlineUsers',
                        style: TextStyle(fontSize: 16, color: colorScheme.onSurface)), // Adapt text color to theme
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _showUserList(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: colorScheme.onPrimary, // Adapt text color to theme
                        backgroundColor: colorScheme.primary, // Button background color
                      ),
                      child: const Text('View Users'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('User Actions', style: TextStyle(fontSize: 18, color: colorScheme.onSurface)), // Adapt text color to theme
            ),
          ),
        ],
      ),
    );
  }

  void _showUserList(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
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
                        title: Text(userList[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            // Implement copy functionality
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