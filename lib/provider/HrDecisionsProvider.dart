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
  };

  late List<HrDecisions> _hrDecisions = [];
  Future<void> fetchHrDecisions() async {
    notifyListeners();
    var respose = await http.get(Uri.parse(url + "GetDecisions" + "/4341012"),
        headers: APP_HEADERS);

    _hrDecisions = (jsonDecode(respose.body)["DecisionList"] as List)
        .map(((e) => HrDecisions.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<HrDecisions> get HrDecisionsList {
    return List.from(_hrDecisions);
  }

  Future<void> PostAproveDesition(int index) async {
    var respose = await http.post(Uri.parse(url + "ApproveDecisionRequest"),
        headers: APP_HEADERS,
        body: jsonEncode({
          "BossNumber": 4341012,
          "EmplyeeNumber": _hrDecisions[index].EmplyeeNumber,
          "SignTypeID": _hrDecisions[index].SignTypeID,
          "Seq": _hrDecisions[index].Seq,
          "NewClass": _hrDecisions[index].NewClass,
          "TrnsactionTypeID": _hrDecisions[index].TrnsactionTypeID,
          "ExecutionDateH": _hrDecisions[index].ExecutionDateH,
          "ExexutionDateG": _hrDecisions[index].ExexutionDateG
        }));
    _hrDecisions.removeAt(index);
    notifyListeners();
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
