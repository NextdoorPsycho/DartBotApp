import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shit_ui_app/page/page_bot.dart';

import 'model/app_state.dart';

class Aggregator extends StatefulWidget {
  const Aggregator({super.key});

  @override
  State<Aggregator> createState() => _AggregatorState();
}

class _AggregatorState extends State<Aggregator> {
  int selectedIndex = 0;

  Widget _getPageWidget(int index) {
    switch (index) {
      case 0:
        return const BotPage();
      case 1:
        return const BotPage();
      default:
        throw UnimplementedError('no widget for $index');
    }
  }

  Widget _buildMobileLayout(BuildContext context, Widget mainArea) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Expanded(child: mainArea),
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.newspaper_rounded),
                label: 'Bot',
                backgroundColor: theme.primaryColor),
            BottomNavigationBarItem(
                icon: const Icon(Icons.bug_report_rounded),
                label: 'Misc',
                backgroundColor: theme.primaryColor),
          ],
          currentIndex: selectedIndex,
          onTap: (value) => setState(() => selectedIndex = value),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(
      BuildContext context, Widget mainArea, double width) {
    var theme = Theme.of(context);
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.newspaper_rounded), label: Text('Bot')),
              NavigationRailDestination(
                  icon: Icon(Icons.bug_report_rounded), label: Text('Misc')),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) =>
                setState(() => selectedIndex = value),
          ),
        ),
        Expanded(child: mainArea),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var page = _getPageWidget(selectedIndex);

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200), child: page),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth < 450
            ? _buildMobileLayout(context, mainArea)
            : _buildTabletLayout(context, mainArea, constraints.maxWidth),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<BotDataModel>(context, listen: false).toggleTheme();
        },
        child: Icon(
          // Choose the icon based on the theme mode
          Theme.of(context).brightness == Brightness.dark
              ? Icons.wb_sunny_rounded
              : Icons.nightlight_round,
        ),
      ),
    );
  }
}
