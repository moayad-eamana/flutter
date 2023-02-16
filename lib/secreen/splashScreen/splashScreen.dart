import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/Login/loginView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    new Future.delayed(Duration(seconds: 5), () async {
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
    return Container(
      child: Center(
          child: Image(
              image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Logo-Test.png?20171228163613"),
              width: 200,
              height: 200)),
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
