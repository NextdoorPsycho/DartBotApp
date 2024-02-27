import 'package:flutter/material.dart';
import 'package:shit_ui_app/main.dart';

errorBotInvalid(BuildContext context) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(1.0),
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
              ListTile(
                leading:
                    Icon(Icons.error_outline_sharp, color: colorScheme.error),
                title: Text("Oh, What a Surprise! The Bot's Asleep",
                    style: myTextStyle(context, title: true)),
                subtitle: const Text(
                    "Apparently, expecting the bot to work without starting it is a thing now? It needs to be online and actually see the chats – you know, basic stuff. Maybe, just maybe, consider turning it on and giving it the access it needs. Or don’t, and let’s see how far we get."),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
