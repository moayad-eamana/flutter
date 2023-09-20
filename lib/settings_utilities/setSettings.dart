import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

String raqameUpdate = "raqameUpdateAll";
String offers = "offers";
String Morning = "morning";
String events = "Events";

// String raqameUpdate = "test_raqameUpdate";
// String offers = "test_offers";
// String morning = "test_morning";
// String events = "Events_Test11";

void setSettings() async {
  // if (Url == "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/") {
  //   raqameUpdate = "test_raqameUpdate";
  //   offers = "test_offers";
  //   Morning = "test_morning";
  //   events = "Events_Test11";
  // } else if (Url == "https://srv.eamana.gov.sa/NewAmanaAPIs/API/") {
  //   raqameUpdate = "raqameUpdateAll";
  //   offers = "offers";
  //   Morning = "morning";
  //   events = "Events";
  // }
  // await Firebase.initializeApp();
  // FirebasePerformance performance = FirebasePerformance.instance;

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
  if (sharedPref.getBool('offers') != null ||
      sharedPref.getBool('offers') == null) {
    //   await FirebaseMessaging.instance.subscribeToTopic('raqameUpdate');
    await FirebaseMessaging.instance.subscribeToTopic(offers);
    sharedPref.setBool("offers", true);
  }
  if (sharedPref.getBool('morning') == null) {
    //   await FirebaseMessaging.instance.subscribeToTopic('raqameUpdate');
    await FirebaseMessaging.instance.subscribeToTopic(Morning);
    sharedPref.setBool("morning", true);
  }
  if (sharedPref.getBool('Events') == null) {
    await FirebaseMessaging.instance.subscribeToTopic(events);
    sharedPref.setBool("Events", true);
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
      height: 60,
      width: 90,
      child: Column(
        children: [
          // SvgPicture.asset(
          //   "assets/image/Giddam-Supporting.svg",
          //   width: 100,
          // ),
          Image(
              fit: BoxFit.contain,
              width: 100,
              height: 55,
              image: AssetImage("assets/SVGs/Raqmyogo2.png")),
        ],
      ),
    )
    ..dismissOnTap = false;
}
