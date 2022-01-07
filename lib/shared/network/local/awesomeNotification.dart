import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:socail/modules/chats/chatsScreen.dart';
import 'package:socail/shared/components/components.dart';
import 'package:uuid/uuid.dart';

class AwesomeNotification{

  static init(){
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              playSound: true,
              enableVibration: true,
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white
          ),
        ]
    );
  }

  static createNotification({@required String title , @required String body}) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: Random().nextInt(2147483647),
            backgroundColor: Colors.red,
            color: Colors.amber,
            channelKey: 'basic_channel',
            title: title,
            body: body,
            displayOnBackground: true,
            displayOnForeground: true
        )
    );

    /* AwesomeNotifications().actionStream.listen((event) {
      navigateTo(context: context, screen: ChatsScreen());
    });

*/

  }
}