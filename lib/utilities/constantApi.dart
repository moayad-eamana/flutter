import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

//4341012 old https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/
String Url = "https://srv.eamana.gov.sa/NewAmanaAPIs_test/API/";

Future<String> Bearer() async {
  SharedPreferences _pref = await SharedPreferences.getInstance();

  return _pref.getString("AccessToken") ?? "";
}

dynamic getAction(String link) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();
  dynamic respns = await http.get(Uri.parse(Url + link), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + _pref.getString("AccessToken").toString()
  });
  if (respns.statusCode == 401) {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    return;
  }
  return respns;
}

//EE
dynamic postAction(String link, dynamic body) async {
  SharedPreferences _pref = await SharedPreferences.getInstance();

  dynamic respns = await http.post(Uri.parse(Url + link),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + _pref.getString("AccessToken").toString(),
      },
      body: body);
  if (respns.statusCode == 401) {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    return;
  }
  return respns;
}
