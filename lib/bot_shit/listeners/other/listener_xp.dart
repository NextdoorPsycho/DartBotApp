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
import 'package:shit_ui_app/bot_shit/bot_cfg.dart';
import 'package:shit_ui_app/bot_shit/utils/dartcord/user_data.dart';
import 'package:shit_ui_app/bot_shit/utils/nyxx_betterment/d_user.dart';

void onMessageXPAwardListener(NyxxGateway client) {
  verbose("Registering XP award listener");
  client.onMessageCreate.listen((event) async {
    if (await DUser.isBot(entity: event.message.author)) {
      return;
    } else {
      var userId = event.message.author.id.toString();
      var userData =
          await UserData.loadFromFile(userId) ?? UserData(userId: userId);

      double randomXP = BotCFG.i.getRandomXP();

      userData.xp += randomXP;
      await userData.saveToFile();

      verbose("Awarded $randomXP XP to user ${event.message.author.username}");
    }
  });
}
