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
import 'package:shit_ui_app/bot_shit/utils/nyxx_betterment/d_user.dart';
import 'package:shit_ui_app/bot_shit/utils/nyxx_betterment/d_util.dart';

void onHiMessageListener(NyxxGateway client) {
  verbose("Registering Hi message listener");
  client.onMessageCreate.listen((event) async {
    //Simplified message parsing, and bot checking!
    if (DUtil.messageHas(message: event.message.content) &&
        !await DUser.isBot(entity: event)) {
      await event.message.manager.create(MessageBuilder(
        content: "I'm Dartcord!",
        replyId: event.message.id,
      ));
    }
  });
}
