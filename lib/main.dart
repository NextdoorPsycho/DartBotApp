import 'dart:io';

import 'package:fast_log/fast_log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shit_ui_app/aggregator.dart';
import 'package:http/http.dart' as http;
import 'gen/main.g.dart' as g;

import 'model/app_state.dart';

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
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const Aggregator(),
      ),
    );
  }
}

Future<void> sendCommand(String command) async {
  var url = Uri.parse('http://localhost:8080/$command');
  var response = await http.get(url);
  info('Response status: ${response.statusCode}');
  info('Response body: ${response.body}');
}
