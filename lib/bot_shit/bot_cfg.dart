/*
 * This is a project by ArcaneArts, for free/public use!
 * Copyright (c) 2023 Arcane Arts (Volmit Software)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:fast_log/fast_log.dart';

class BotCFG {
  Future<void> initializeConfig() async {
    verbose("Loading config");
    File configFile = File('config.json');
    if (!await configFile.exists()) {
      verbose("Config file not found. Creating a temporary one.");
      await configFile.create(recursive: true); // Ensure the directory exists
      var defaultConfig = {
        "botImageURL": "none",
        "botColor": "none",
        "botCompanyName": "none",
        "botPrefix": "!",
        "xpBaseMultiplier": 1.0,
        "openAiToken": "none",
        "xpMin": 0.0,
        "xpMax": 3.0,
      };
      await configFile.writeAsString(json.encode(defaultConfig));
    }
    var contents = await configFile.readAsString();
    Map<String, dynamic> configData = json.decode(contents);
    BotCFG.fromJson(configData);
  }


  static final BotCFG _i = BotCFG._internal();

  String botImageURL;
  String botColor;
  String botCompanyName;
  String botPrefix;
  double xpBaseMultiplier;
  double xpMin;
  double xpMax;

  // Private constructor for internal use
  BotCFG._internal({
    this.botImageURL = 'none',
    this.botColor = 'none',
    this.botCompanyName = 'none',
    this.botPrefix = 'none',
    this.xpBaseMultiplier = 1.0,
    this.xpMin = 0.0,
    this.xpMax = 3.0,
  });

  // Factory constructor for creating instance from JSON
  factory BotCFG.fromJson(Map<String, dynamic> json) {
    _i.botImageURL = json['botImageURL'] as String? ?? _i.botImageURL;
    _i.botColor = json['botColor'] as String? ?? _i.botColor;
    _i.botCompanyName = json['botCompanyName'] as String? ?? _i.botCompanyName;
    _i.botPrefix = json['botPrefix'] as String? ?? _i.botPrefix;
    _i.xpBaseMultiplier =
        (json['xpBaseMultiplier'] as num?)?.toDouble() ?? _i.xpBaseMultiplier;

    // xpPerMessage checks
    if (json.containsKey('xpPerMessage') &&
        json['xpPerMessage'] is Map<String, dynamic>) {
      var xpPerMessage = json['xpPerMessage'] as Map<String, dynamic>;
      _i.xpMin = (xpPerMessage['min'] as num?)?.toDouble() ?? _i.xpMin;
      _i.xpMax = (xpPerMessage['max'] as num?)?.toDouble() ?? _i.xpMax;
    }

    verbose("Config loaded");
    return _i;
  }

  // Static getter to access the instance
  static BotCFG get i {
    return _i;
  }

  // Method to get a random XP value
  double getRandomXP() {
    return xpMin + math.Random().nextDouble() * (xpMax - xpMin);
  }
}

// Function to load and initialize the configuration
Future<void> initializeConfig() async {
  verbose("Loading config");
  try {
    var configFile = File('config.json');
    var contents = await configFile.readAsString();
    Map<String, dynamic> configData = json.decode(contents);
    BotCFG.fromJson(configData);
  } catch (e) {
    verbose("Error loading config: $e");
    // Handle the error appropriately
  }
}
