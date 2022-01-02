import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/EmployeeProfle.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  EmployeeProfile employeeProfile = EmployeeProfile(0, "", "", "");
  var APP_HEADERS = {
    HttpHeaders.authorizationHeader:
        basicAuthenticationHeader("DevTeam", "DevTeam"),
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<bool> checkUser(String userName, String password) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var respose = await http.post(
        Uri.parse(
            "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/CheckUserForMobile"),
        headers: APP_HEADERS,
        body: jsonEncode(
            {"EmployeeNumber": int.parse(userName), "Password": password}));

    if (jsonDecode(respose.body)["IsAuthenticated"] == true) {
      _pref.setInt("RequestID", jsonDecode(respose.body)["RequestID"]);
      return true;
    }
    return false;
  }

  Future<bool> checkUserOTP(String otp) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var respose = await http.get(
      Uri.parse("https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/IsValidOTP/" +
          _pref.getInt("RequestID").toString() +
          "/" +
          otp),
      headers: APP_HEADERS,
    );

    if (jsonDecode(respose.body)["IsValid"] == true) {
      return true;
    }
    return false;
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
