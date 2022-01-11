import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/HrRequests.dart';
import 'package:eamanaapp/model/InboxHeader.dart';
import 'package:eamanaapp/model/RequestRejectReasons.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EatemadatProvider extends ChangeNotifier {
  bool isLoding = false;
  String url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";
  var APP_HEADERS = {
    HttpHeaders.authorizationHeader:
        basicAuthenticationHeader("DevTeam", "DevTeam"),
    "Content-Type": "application/json; charset=utf-8",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers":
        "Access-Control-Allow-Headers,Content-Type, Access-Control-Allow-Methods, authorization, X-Requested-With"
  };

  late List<InboxHeader> _inboxHeader = [];
  Future<void> getInboxHeader() async {
    isLoding = true;
    notifyListeners();
    var respose = await http.get(Uri.parse(url + "GetInboxHeader/4341012"),
        headers: APP_HEADERS);
    _inboxHeader = (jsonDecode(respose.body)["HeaderList"] as List)
        .map(((e) => InboxHeader.fromJson(e)))
        .toList();

    isLoding = false;

    notifyListeners();
  }

  List<InboxHeader> get inboxHeaderList {
    return List.from(_inboxHeader);
  }

  late List<HrRequests> _hrRequestsList = [];
  Future<void> fetchHrRequests() async {
    isLoding = true;
    notifyListeners();
    var respose = await http.get(Uri.parse(url + "GetInboxHrRequests/4341012"),
        headers: APP_HEADERS);
    _hrRequestsList = (jsonDecode(respose.body)["RequestList"] as List)
        .map(((e) => HrRequests.fromJson(e)))
        .toList();

    isLoding = false;
    notifyListeners();
  }

  List<HrRequests> get getHrRequests {
    return List.from(_hrRequestsList);
  }

  Future<bool> deleteEtmad(int index, bool IsRecjcted, String resondID) async {
    double id = 0;
    for (int i = 0; i < _RequestRejectReasons.length; i++) {
      if (resondID == _RequestRejectReasons[i].RejectReasonName) {
        id = _RequestRejectReasons[i].RejectReasonID;
        break;
      }
    }
    var respose = await http.post(
        Uri.parse(
            "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/HrRequestApprove"),
        headers: APP_HEADERS,
        body: jsonEncode({
          "RequesterEmployeeNumber":
              _hrRequestsList[index].RequesterEmployeeNumber,
          "RequestNumber": _hrRequestsList[index].RequestNumber,
          "IsApproved": IsRecjcted,
          "RejectReasonID": IsRecjcted ? 0.0 : id,
          "RequestTypeID": _hrRequestsList[index].RequestTypeID,
          "ApprovedBy": 4341012
        }));
    //  print(respose.body);
    _hrRequestsList.removeAt(index);

    notifyListeners();
    return true;
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

  List<RequestRejectReasons> get getRequestRejectReasonsList {
    return List.from(_RequestRejectReasons);
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
