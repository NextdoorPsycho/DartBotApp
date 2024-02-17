import 'package:flutter/material.dart';
import 'package:shit_ui_app/page/page_bot.dart';
import 'package:shit_ui_app/page/page_user_control.dart';
import 'package:shit_ui_app/page/page_utility.dart';


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
        return const UserControl();
      case 2:
        return const UserControl();
      case 3:
        return const MiscControl();
      default:
        throw UnimplementedError('no widget for $index');
    }
  }

  Widget _buildMobileLayout(BuildContext context, Widget mainArea) {
    return Column(
      children: [
        AppBar(title: const Text('Shitty Bot App')),
        Expanded(child: mainArea),
        BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.newspaper_rounded), label: 'Bot', backgroundColor: Colors.deepPurpleAccent ),
            BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'People', backgroundColor: Colors.green ),
            BottomNavigationBarItem(icon: Icon(Icons.computer_rounded), label: 'Server', backgroundColor: Colors.deepOrangeAccent ),
            BottomNavigationBarItem(icon: Icon(Icons.bug_report_rounded), label: 'Misc', backgroundColor: Colors.blueGrey ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) => setState(() => selectedIndex = value),
        ),
      ],
    );
  }


  Widget _buildTabletLayout(BuildContext context, Widget mainArea, double width) {
    return Row(
      children: [
        SafeArea(
          child: NavigationRail(
            extended: width >= 600,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.newspaper_rounded), label: Text('Bot')),
              NavigationRailDestination(icon: Icon(Icons.people_rounded), label: Text('People')),
              NavigationRailDestination(icon: Icon(Icons.computer_rounded), label: Text('Server')),
              NavigationRailDestination(icon: Icon(Icons.bug_report_rounded), label: Text('Misc')),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) => setState(() => selectedIndex = value),
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
      child: AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: page),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth < 450
            ? _buildMobileLayout(context, mainArea)
            : _buildTabletLayout(context, mainArea, constraints.maxWidth),
      ),
    );
  }
}
