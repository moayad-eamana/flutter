import 'package:flutter/material.dart';

import '../../main.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    int dur = 0;
    if (sharedPref.getBool("splash1") == null) {
      dur = 5;
    } else {
      dur = 3;
    }
    new Future.delayed(Duration(seconds: dur), () async {
      sharedPref.setBool("splash1", true);
      var username = sharedPref.getDouble("EmployeeNumber");
      var fingerprint = sharedPref.getBool("fingerprint");
      late String route;
      if (username == null || username == 0) {
        route = "/";
      } else if (fingerprint == false) {
        route = "/home";
      } else {
        route = "/AuthenticateBio";
      }
      Navigator.pushNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/SVGs/splash.png",
      fit: BoxFit.fill,
    );
  }

  // String routes() {
  //   var username = sharedPref.getDouble("EmployeeNumber");
  //   var fingerprint = sharedPref.getBool("fingerprint");

  //   if (username == null || username == 0) {
  //     return "/";
  //   } else if (fingerprint == false) {
  //     return "/home";
  //   } else {
  //     return "/AuthenticateBio";
  //   }
  // }
}
