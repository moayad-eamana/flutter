import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

String Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
//String Url = "https://srv.eamana.gov.sa/NewAmanaAPIs/API/";

Future<String> Bearer() async {
  return sharedPref.getString("AccessToken") ?? "";
}

dynamic getAction(String link) async {
  if (sharedPref.getString("dumyuser") == "10284928492") {
    Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
  }
  dynamic respns = await http.get(Uri.parse(Url + link), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + sharedPref.getString("AccessToken").toString()
  });
  if (respns.statusCode == 401) {
    EasyLoading.dismiss();
    sharedPref.setString("hasePerm", "");
    sharedPref.setBool("permissionforCRM", false);
    sharedPref.setDouble("EmployeeNumber", 0);
    hasePerm = "";
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    return null;
  }
  return respns;
}

//EE
dynamic postAction(String link, dynamic body) async {
  if (sharedPref.getString("dumyuser") == "10284928492") {
    Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
  }

  dynamic respns = await http.post(Uri.parse(Url + link),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer ' + sharedPref.getString("AccessToken").toString(),
      },
      body: body);
  if (respns.statusCode == 401) {
    EasyLoading.dismiss();
    sharedPref.setString("hasePerm", "");
    sharedPref.setBool("permissionforCRM", false);
    sharedPref.setDouble("EmployeeNumber", 0);
    hasePerm = "";
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    return null;
  }
  return respns;
}
