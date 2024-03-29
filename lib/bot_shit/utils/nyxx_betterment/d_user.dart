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
import 'package:shit_ui_app/bot_shit/bot_main.dart';

class DUser {
  /// Checks if a given entity is a bot.
  ///
  /// Accepts [entity] which can be a User, Member, Snowflake (ID), or Message.
  ///
  /// Returns `true` if the entity is a bot, otherwise `false`.
  static Future<bool> isBot({required dynamic entity}) async {
    // verbose("Checking if $entity is a bot."); // Uncomment this line to see if the function is being called, because its spammy but extremely useful for debugging
    switch (entity.runtimeType) {
      case User :
        verbose((entity as User).isBot
            ? "User ${entity.username} is a bot"
            : "User ${entity.username} is not a bot");
        return (entity).isBot;
      case Member :
        return isBot(entity: (entity as Member).id);
      case Snowflake :
        return isBot(
            entity: await nyxxBotClient.user.manager.get(entity as Snowflake));
      case Message :
        return isBot(entity: (entity as MessageCreateEvent).message.author.id);
      case Webhook :
        return true;
      case WebhookAuthor :
        return true;
      default:
        error("Unknown entity type: ${entity.runtimeType}");
        return false;
    }
  }
}
