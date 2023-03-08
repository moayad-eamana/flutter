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
    new Future.delayed(Duration(seconds: 0), () async {
      var username = sharedPref.getDouble("EmployeeNumber");
      var fingerprint = sharedPref.getBool("fingerprint");
      late String route;
      if (username == null || username == 0) {
        route = "/home";
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
      "assets/image/Splash.png",
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
