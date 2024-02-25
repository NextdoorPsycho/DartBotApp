import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shit_ui_app/aggregator.dart';

import 'gen/main.g.dart' as g;
import 'model/app_state.dart';

ThemeData applyTheme(ThemeData t) {
  return t.copyWith(
      bottomNavigationBarTheme: t.bottomNavigationBarTheme.copyWith(
        backgroundColor: t.cardColor,
      ),
      navigationRailTheme: t.navigationRailTheme.copyWith(
        backgroundColor: t.brightness == Brightness.dark
            ? Colors.grey[850]
            : Colors.grey[3040], // Adjusted for theme
        selectedIconTheme: IconThemeData(color: t.colorScheme.primary),
        unselectedIconTheme:
            IconThemeData(color: t.hoverColor.withOpacity(0.5)),
      ));
}

ThemeData lightTheme() {
  return applyTheme(ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF003B6F), // Tardis blue as the seed color
      brightness: Brightness.light,
      primary: const Color(0xFF003B6F), // Tardis blue
      secondary: const Color(
          0xFF005ecb), // A lighter shade of Tardis blue for secondary
      surface: const Color(0xFFe0e0e0), // Light grey for surfaces
      background: const Color(0xFFf5f5f5), // Off-white for background
      error: const Color(0xFFb00020), // Red variant for errors
      onPrimary: const Color(0xFFFFFFFF), // Text/iconography on primary
      onSecondary: const Color(0xFFFFFFFF), // Text/iconography on secondary
      onSurface: const Color(0xFF000000), // Text/iconography on surface
      onBackground: const Color(0xFF000000), // Text/iconography on background
      onError: const Color(0xFFFFFFFF), // Text/iconography on error
    ),
  ));
}

ThemeData darkTheme() {
  return applyTheme(ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor:
          const Color(0xFF880E0E), // Deep maroon as an example seed color
      brightness: Brightness.dark,
      primary: const Color(0xFF880E0E), // Deep maroon
      secondary: const Color(0xFF005ecb), // Dark grey variant
      surface: const Color(0xFF121212), // Dark grey for surfaces
      background:
          const Color(0xFF212121), // Slightly lighter grey for background
      error: const Color(0xFFB00020), // Red variant for errors
      onPrimary: const Color(0xFFFFFFFF), // Text/iconography on primary
      onSecondary: const Color(0xFFFFFFFF), // Text/iconography on secondary
      onSurface: const Color(0xFFFFFFFF), // Text/iconography on surface
      onBackground: const Color(0xFFFFFFFF), // Text/iconography on background
      onError: const Color(0xFFFFFFFF), // Text/iconography on error
    ),
  ));
}

void main() {
  //TODO: dart run nyxx_commands:compile lib/main.dart --no-compile -o lib/gen/main.g.dart
  //TODO: delete this line in that file:  " _main.main(); " (at the bottom!) *this fixes commands compiling*
  g.main([]); // Generated file.
  runApp(const MyApp());
  info('[App Started]');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BotDataModel(),
      child: Consumer<BotDataModel>(
        builder: (context, model, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: model.themeMode == AppThemeMode.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const Aggregator(),
          );
        },
      ),
    );
  }
}
