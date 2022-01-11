import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eamanaapp/model/EmpInfo.dart';
import 'package:flutter/foundation.dart';

class EmpInfoProvider extends ChangeNotifier {
  late List<EmpInfo> _empinfo = [];
  String url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";
  var APP_HEADERS = {
    HttpHeaders.authorizationHeader:
        basicAuthenticationHeader("DevTeam", "DevTeam"),
    "Content-Type": "application/json"
  };

  Future<bool> fetchEmpInfo(String name) async {
    _empinfo = [];
    notifyListeners();
    var respose = await http.get(
        Uri.parse(
            "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/GetEmployees/" +
                name),
        headers: APP_HEADERS);
    _empinfo.clear();
    if (jsonDecode(respose.body)["EmpInfo"] != null) {
      _empinfo = (jsonDecode(respose.body)["EmpInfo"] as List)
          .map(((e) => EmpInfo.fromJson(e)))
          .toList();
    }
    print(_empinfo);
    notifyListeners();
    if (_empinfo.length == 0) {
      return false;
    }
    return true;
  }

  List<EmpInfo> get empinfoList {
    return List.from(_empinfo);
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
