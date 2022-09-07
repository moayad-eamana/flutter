import 'dart:io';
import 'package:eamanaapp/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

String? permissionStatusFuture;
firebase_Notification() async {
  await Firebase.initializeApp();

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    showBadge: true,

    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.schedule(
  //   1,
  //   "test",
  //   "body test",
  //   DateTime(2022, 6, 19, 13, 45).subtract(Duration(minutes: 10)),
  //   NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         visibility: NotificationVisibility.public,
  //         color: Colors.blue,
  //         icon: '@mipmap/launcher_icon',
  //       ),
  //       iOS: IOSNotificationDetails(
  //         subtitle: " test",
  //       )),
  // );
  // flutterLocalNotificationsPlugin.cancel(1);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    permissionStatusFuture = "granted";
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    permissionStatusFuture = "granted";
  } else {
    permissionStatusFuture = "denied";
  }

  //  Create an Android Notification Channel.

  //  We use this channel in the `AndroidManifest.xml` file to override the
  //  default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Update the iOS foreground notification presentation options to allow
  // heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
}

listenToFirbaseNotification() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      print(message.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            visibility: NotificationVisibility.public,
            color: Colors.blue,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.data["module_name"] == "MorningMessages") {
      navigatorKey.currentState?.pushNamed("/morning",
          arguments: ({
            "title": "رسالة صباح",
            "body": message.notification?.body,
            "url": message.data["image"]
          }));
      return;
    }
    if (message.data["module_name"] == "Offers") {
      navigatorKey.currentState?.pushNamed("/EamanaDiscount");
      return;
    }
    if (message.data["module_name"] == "update") {
      if (Platform.isAndroid) {
        launch(
            "https://play.google.com/store/apps/details?id=com.eamana.eamanaapp.gov.sa");
      } else {
        launch("https://testflight.apple.com/join/ds6xxuqO");
      }
    }
    print("onMessageOpenedApp: $message");
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      if (message.data["module_name"] == "MorningMessages") {
        navigatorKey.currentState?.pushNamed("/morning",
            arguments: ({
              "title": "رسالة صباح",
              "body": message.notification?.body,
              "url": message.data["image"]
            }));
        return;
      }
      if (message.data["module_name"] == "Offers") {
        navigatorKey.currentState?.pushNamed("/EamanaDiscount");
        return;
      }
      if (message.data["module_name"] == "update") {
        if (Platform.isAndroid) {
          launch(
              "https://play.google.com/store/apps/details?id=com.eamana.eamanaapp.gov.sa");
        } else {
          launch("https://testflight.apple.com/join/ds6xxuqO");
        }
      }
    }
  });
}
