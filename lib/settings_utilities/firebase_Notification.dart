import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

String? permissionStatusFuture;
firebase_Notification() async {
  await Firebase.initializeApp();

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    showBadge: true,

    importance: Importance.high,
  );

  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
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

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

listenToFirbaseNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  print("ssss");
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
          print("sqqw'le;wq;l");
          var message = jsonDecode(payload);
          if (message["module_name"] == "GeneralMessages") {
            navigatorKey.currentState?.pushNamed("/morning",
                arguments: ({
                  "title": message["title"],
                  "body": message["body"],
                  "url": message["image"]
                }));
            return;
          } else {
            handelfirbasemessge(message);
          }
        }
        // selectedNotificationPayload = payload;
        // selectNotificationSubject.add(payload);
      },
    );
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      print(message.data);

      if (message.data["module_name"] == "GeneralMessages") {
        String bigPicturePath;
        BigPictureStyleInformation? bigPictureStyleInformation;
        // final String largeIconPath =
        //     await _downloadAndSaveFile(message.data["image"], 'largeIcon');
        if (message.data["image"] != null && message.data["image"] != "") {
          bigPicturePath =
              await _downloadAndSaveFile(message.data["image"], 'bigPicture');
          bigPictureStyleInformation =
              BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),

                  // largeIcon: FilePathAndroidBitmap(largeIconPath),
                  contentTitle: message.notification?.title,
                  htmlFormatContentTitle: true,
                  summaryText: message.notification?.body,
                  htmlFormatSummaryText: true);
        }

        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(channel.id, channel.name,
                visibility: NotificationVisibility.public,
                color: Colors.blue,
                icon: '@mipmap/launcher_icon',
                styleInformation: bigPictureStyleInformation);
        final NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        message.data.addAll({
          "title": message.notification?.title,
          'body': message.notification?.body
        });
        await flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, notificationDetails,
            payload: jsonEncode(message.data).toString());

        // .then(
        //   (value) => navigatorKey.currentState?.pushNamed(
        //     "/morning",
        //     arguments: ({
        //       "title": message.notification?.title,
        //       "body": message.notification?.body,
        //       "url": message.data["image"]
        //     }),
        //   ),
        // );
      } else {
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
      if (message.data["module_name"] == "otp") {
        c.increment(message.data["image"]);

        return;
      }
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    handelfirbasemessge(message);
  });

  FirebaseMessaging.instance.getInitialMessage().then((message) async {
    if (message != null) {
      handelfirbasemessge(message);
    }
  });
}

Future<void> handelfirbasemessge(RemoteMessage message) async {
  if (message.data["module_name"] == "otp") {
    c.increment(message.data["image"]);

    return;
  }
  if (message.data["module_name"] == "GeneralMessages") {
    navigatorKey.currentState?.pushNamed("/morning",
        arguments: ({
          "title": message.notification?.title,
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
      launch(
          "https://apps.apple.com/us/app/%D8%B1%D9%82%D9%85%D9%8A/id1613668254");
    }
  }
  print("swdsd");
  print(message.data["data"] + "dddd");
  print("onMessageOpenedApp: $message");
}
