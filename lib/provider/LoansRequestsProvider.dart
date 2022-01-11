import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/LoansRequests.dart';
import 'package:eamanaapp/model/RequestRejectReasons.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class LoansRequestsProvider extends ChangeNotifier {
  String url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";
  var APP_HEADERS = {
    HttpHeaders.authorizationHeader:
        basicAuthenticationHeader("DevTeam", "DevTeam"),
    "Content-Type": "application/json; charset=utf-8",
  };

  late List<LoansRequest> _LoanRequest = [];
  Future<void> fethLoansRequests() async {
    var respose = await http.get(
        Uri.parse(url + "GetLoansRequests" + "/4341012"),
        headers: APP_HEADERS);

    _LoanRequest = (jsonDecode(respose.body)["LoansList"] as List)
        .map(((e) => LoansRequest.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<LoansRequest> get LoansRequestList {
    return List.from(_LoanRequest);
  }

  Future<void> deleteLoansReques(int index) async {
    var respose = await http.post(
        Uri.parse(
            "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/ApproveLoanRequest"),
        headers: APP_HEADERS,
        body: jsonEncode({
          "BdgLoc": _LoanRequest[index].BdgLoc,
          "EmployeeNumber": _LoanRequest[index].EmployeeNumber,
          "RequestNumber": _LoanRequest[index].RequestNumber,
          "RequestTypeID": _LoanRequest[index].RequestTypeID,
          "Duration": "1Y",
          "LocationCode": _LoanRequest[index].LocationCode,
          "ApprovedBy": "4341012",
          "FinancialType": "A",
          "Notes": "kkkk",
          "ApproveFlag": "A"
        }));
    print(_LoanRequest[index].BdgLoc);
    print(_LoanRequest[index].RequestNumber);
    print(_LoanRequest[index].EmployeeName);
    print(_LoanRequest[index].RequestTypeID);
    print(_LoanRequest[index].LocationCode);

    print(_LoanRequest[index].BdgLoc.toString() +
        " " +
        _LoanRequest[index].EmployeeName +
        " " +
        _LoanRequest[index].RequestNumber.toString() +
        " " +
        _LoanRequest[index].RequestTypeID.toString() +
        " " +
        _LoanRequest[index].LocationCode.toString());
    print(respose.body);
    _LoanRequest.removeAt(index);
    notifyListeners();
  }

  List<String> _reason = [];
  late List<RequestRejectReasons> _RequestRejectReasons;
  Future<void> fetchRejectReasonNames() async {
    var respose = await http.get(
        Uri.parse(
            "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/GetHrRequestRejectReasons"),
        headers: APP_HEADERS);
    _RequestRejectReasons =
        (jsonDecode(respose.body)["RejectReasonsList"] as List)
            .map(((e) => RequestRejectReasons.fromJson(e)))
            .toList();

    for (int i = 0; i < _RequestRejectReasons.length; i++) {
      if (_RequestRejectReasons[i].RejectReasonName != "0") {
        _reason.add(_RequestRejectReasons[i].RejectReasonName);
      }
    }
  }

  List<String> get resonsSrtings {
    return _reason;
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
