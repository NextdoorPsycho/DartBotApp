import 'package:flutter/material.dart';

class MiscControl extends StatefulWidget {
  const MiscControl({Key? key}) : super(key: key);

  @override
  State<MiscControl> createState() => _MiscControlState();
}

class _MiscControlState extends State<MiscControl> {
  void _placeholderFunction() {
    // Placeholder for button actions
  }

  @override
  Widget build(BuildContext context) {
    // Accessing the current theme color
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Misc Settings'),
        centerTitle: true,
        // AppBar uses the primary color by default, but you can customize it here if needed
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection('Section 1', _placeholderFunction, theme),
            _buildSection('Section 2', _placeholderFunction, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, VoidCallback onPressed, ThemeData theme) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(color: theme.textTheme.bodyText1?.color)), // Custom text color
      backgroundColor: theme.canvasColor, // Custom background color
      children: [
        ListTile(
          title: const Text('Button 1'),
          onTap: onPressed,
          textColor: theme.textTheme.bodyText1?.color, // Ensuring text color matches theme
        ),
        ListTile(
          title: const Text('Button 2'),
          onTap: onPressed,
          textColor: theme.textTheme.bodyText1?.color, // Ensuring text color matches theme
        ),
        ListTile(
          title: const Text('Button 3'),
          onTap: onPressed,
          textColor: theme.textTheme.bodyText1?.color, // Ensuring text color matches theme
        ),
      ],
    );
  }
}
