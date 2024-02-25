import 'package:fast_log/fast_log.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/bot_data.dart';
import 'package:shit_ui_app/bot_shit/utils/services/ai/openai_manager.dart';
import 'package:shit_ui_app/utility/bot_functions.dart';

import 'bot_cfg.dart';
import 'commands/autocrat.dart';
import 'listeners/dictator.dart';

late NyxxGateway nyxxBotClient;
late User botUser;
late int botServerId;

Future<bool> botStart() async {
  try {
    // Create a single instance of BotFunctions and load data
    BotFunctions botFunctions = BotFunctions();
    await botFunctions.loadSavedData(); // Ensure data is loaded before use

    // Access the properties after ensuring they are loaded
    String botToken = botFunctions.botToken;
    String aiToken = botFunctions.openaiKey;
    botServerId = int.parse(botFunctions.serverId.toString());
    info("$botServerId");

    await initializeConfig();
    final commands = CommandsPlugin(prefix: mentionOr((_) => '!'));
    autocrat(commands); // Load all commands

    nyxxBotClient = await Nyxx.connectGateway(
        botToken,
        GatewayIntents.allUnprivileged |
            GatewayIntents.messageContent |
            GatewayIntents.guildPresences |
            GatewayIntents.guildMembers,
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

class BotObjects {
  // getter for the botUser and botClient
  NyxxGateway get botNyxxClient => nyxxBotClient;
  User get botClient => botUser;
  Snowflake get botId => botUser.id;
  Future<Guild> get botGuild =>
      nyxxBotClient.guilds.get(Snowflake(botServerId));
}
