import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String raqameUpdate = "raqameUpdate";
String offers = "offers";
String Morning = "morning";

// String raqameUpdate = "test_raqameUpdate";
// String offers = "test_offers";
// String morning = "test_morning";

void setSettings() async {
  await Firebase.initializeApp();
  if (sharedPref.getBool('fingerprint') == null) {
    sharedPref.setBool("fingerprint", false);
  }

  if (sharedPref.getBool('blindness') == null) {
    sharedPref.setBool("blindness", false);
  }

  if (sharedPref.getBool('darkmode') == null) {
    sharedPref.setBool("darkmode", false);
  }

  if (sharedPref.getBool('onboarding') == null) {
    sharedPref.setBool("onboarding", false);
  }

  if (sharedPref.getBool('updatenotification') == null) {
    await FirebaseMessaging.instance.subscribeToTopic(raqameUpdate);
    // await FirebaseMessaging.instance.subscribeToTopic('test');
    sharedPref.setBool("updatenotification", true);
  }
  if (sharedPref.getBool('offers') == null) {
    //   await FirebaseMessaging.instance.subscribeToTopic('raqameUpdate');
    await FirebaseMessaging.instance.subscribeToTopic(offers);
    sharedPref.setBool("offers", true);
  }
  if (sharedPref.getBool('morning') == null) {
    //   await FirebaseMessaging.instance.subscribeToTopic('raqameUpdate');
    await FirebaseMessaging.instance.subscribeToTopic(Morning);
    sharedPref.setBool("morning", true);
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = baseColor
    ..backgroundColor = BackGWhiteColor
    ..indicatorColor = baseColor
    ..textColor = baseColor
    ..maskColor = baseColor.withOpacity(0.5)
    ..userInteractions = true
    ..indicatorWidget = Container(
      height: 80,
      width: 100,
      child: Image(image: AssetImage("assets/image/rakamy-logo-21.png")),
    )
    ..dismissOnTap = false;
}
