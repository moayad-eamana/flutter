import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/HrDecisions.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class HrDecisionsProvider extends ChangeNotifier {
  String url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";
  var APP_HEADERS = {
    HttpHeaders.authorizationHeader:
        basicAuthenticationHeader("DevTeam", "DevTeam"),
    "Content-Type": "application/json; charset=utf-8",
    "Access-Control-Allow-Origin": "*",
  };

  late List<HrDecisions> _hrDecisions = [];
  Future<void> fetchHrDecisions() async {
    notifyListeners();
    var respose = await http.post(Uri.parse(url + "ApproveDecisionRequest"),
        headers: APP_HEADERS, body: jsonEncode({"": ""}));

    _hrDecisions = (jsonDecode(respose.body)["DecisionList"] as List)
        .map(((e) => HrDecisions.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<HrDecisions> get HrDecisionsList {
    return List.from(_hrDecisions);
  }

  Future<void> PostAproveDesition() async {
    var respose = await http.post(Uri.parse(url + "ApproveDecisionRequest"),
        headers: APP_HEADERS, body: jsonEncode({"": ""}));
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
