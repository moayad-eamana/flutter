import 'dart:convert';

import 'package:eamanaapp/model/logApiModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'SLL_pin.dart';

// String Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
String Url = "https://srv.eamana.gov.sa/NewAmanaAPIs/API/";
String CRMURL = "https://crm.eamana.gov.sa/agenda/api/";
// String CRMURL = "https://crm.eamana.gov.sa/agenda_dev/api/";

Future<String> Bearer() async {
  return sharedPref.getString("AccessToken") ?? "";
}

dynamic getAction(String link) async {
  if (sharedPref.getString("dumyuser") == "10284928492") {
    Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
  }
  dynamic respns;
  if (await checkSSL(Url)) {
    respns = await http.get(Uri.parse(Url + link), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ' + sharedPref.getString("AccessToken").toString()
    });
    if (respns.statusCode == 401) {
      EasyLoading.dismiss();
      sharedPref.setString("hasePerm", "");
      sharedPref.setBool("permissionforCRM", false);
      sharedPref.setBool("permissionforAppReq", false);
      sharedPref.setBool("permissionforAppManege", false);

      sharedPref.setDouble("EmployeeNumber", 0);
      hasePerm = "";
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return null;
    }
  } else {
    return false;
  }

  return respns;
}

//EE
dynamic postAction(String link, dynamic body) async {
  if (sharedPref.getString("dumyuser") == "10284928492") {
    Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
  }
  dynamic respns;
  if (await checkSSL(Url)) {
    respns = await http.post(Uri.parse(Url + link),
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
  }
  return respns;
}

logApi(logApiModel body) async {
  if (sharedPref.getString("dumyuser") == "10284928492") {
    Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";
  }

  if (await checkSSL(Url)) {
    await http.post(Uri.parse(Url + "ApplicationLogs/InsertRaqmyLog"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer ' + sharedPref.getString("AccessToken").toString(),
        },
        body: jsonEncode({
          "ModuleID": 1,
          "EmployeeNumber": body.EmployeeNumber,
          "Email": body.Email,
          "ControllerName": body.ControllerName,
          "ClassName": body.ClassName,
          "ActionMethodName": body.ActionMethodName,
          "ActionMethodType": body.ActionMethodType, // 1 get ,2 post

          "Notes": body.Notes,
          "ErrorMessage": body.ErrorMessage,
          "StatusCode": body.StatusCode, // 1 succeeded ,0 failed
          "ErrorTypeID":
              body.ErrorTypeID, // 0 no error ,   Exception=1,BussinessError=2
          "JsonRequest": body.JsonRequest,
          "Platform": body.latform,
          "ApplicationID": 2
        }));
  }
}
