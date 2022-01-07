import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:socail/shared/components/constants.dart';
import 'package:socail/shared/network/local/awesomeNotification.dart';

class FCM{

static Future<void> firebaseMessageHandler(RemoteMessage message)async{
  if(message != null)
    AwesomeNotification.createNotification(title: message.notification.title, body: message.notification.body);
}

  static init()async{

    deviceToken = await FirebaseMessaging.instance.getToken();
    print("token = $deviceToken");

    FirebaseMessaging.onMessage.listen((message){
      AwesomeNotification.createNotification(title: message.notification.title, body: message.notification.body);
      print(message.notification.title);
      print(message.notification.body);

    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessageHandler);
  }
}