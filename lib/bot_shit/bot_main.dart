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

import 'package:fast_log/fast_log.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:shit_ui_app/bot_functions.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_data.dart';
import 'package:shit_ui_app/bot_shit/utils/services/ai/openai_manager.dart';

import 'bot_cfg.dart';
import 'commands/autocrat.dart';
import 'listeners/dictator.dart';

late NyxxGateway nyxxBotClient;
late User botUser;

Future<bool> botStart() async {
  try {
    // Create a single instance of BotFunctions and load data
    BotFunctions botFunctions = BotFunctions();
    await botFunctions.loadSavedData(); // Ensure data is loaded before use

    // Access the properties after ensuring they are loaded
    String botToken = botFunctions.botToken;
    String aiToken = botFunctions.openaiKey;

    await initializeConfig();
    final commands = CommandsPlugin(prefix: mentionOr((_) => '!'));
    autocrat(commands); // Load all commands

    nyxxBotClient = await Nyxx.connectGateway(botToken,
        GatewayIntents.allUnprivileged | GatewayIntents.messageContent,
        options:
            GatewayClientOptions(plugins: [logging, cliIntegration, commands]));
    botUser = await nyxxBotClient.users.fetchCurrentUser();

    registerListeners(nyxxBotClient, commands); // Load all listeners

    OpenAIManager.instance.initialize(aiToken);

    var botData = await BotData.loadFromFile();
    botData.lastStartTime = DateTime.now().toString();
    await botData.saveToFile();

    success("Bot started at: ${DateTime.now()}, Updating bot data.");

    return true;
  } catch (e) {
    error("An error occurred: $e");
    return false;
  }
}

Future<bool> botStop() async {
  try {
    await nyxxBotClient.close();
    verbose("Bot disconnected successfully.");
    // Add any additional cleanup tasks here
    return true;
  } catch (e) {
    error("Failed to stop the bot: $e");
    return false;
  }
}
