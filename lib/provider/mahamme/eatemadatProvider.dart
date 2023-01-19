import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/model/mahamme/HrRequests.dart';
import 'package:eamanaapp/model/mahamme/InboxHeader.dart';
import 'package:eamanaapp/model/RequestRejectReasons.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';

class EatemadatProvider extends ChangeNotifier {
  bool isLoding = false;

  late List<InboxHeader> _inboxHeader = [];
  Future<void> getInboxHeader() async {
    isLoding = true;
    notifyListeners();
    String empNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction("Inbox/GetInboxHeader/" + empNo);
    print(respose);
    try {
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "InboxHRController";
      logapiO.ClassName = "InboxHRController";
      logapiO.ActionMethodName = "عرض الإعتمادات";
      logapiO.ActionMethodType = 1;
      if (jsonDecode(respose.body)["ErrorMessage"] == null) {
        if (jsonDecode(respose.body)["HeaderList"] != null) {
          logapiO.StatusCode = 1;
          logApi(logapiO);
          _inboxHeader = (jsonDecode(respose.body)["HeaderList"] as List)
              .map(((e) => InboxHeader.fromJson(e)))
              .toList();
        }
      } else {
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
        logApi(logapiO);
      }
    } catch (Ex) {}
    _inboxHeader.removeWhere((element) => element.TypeID == 121);
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
    String empNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction("Inbox/GetInboxHrRequests/" + empNo);
    print((jsonDecode(respose.body)["RequestList"]));
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "InboxHRController";
    logapiO.ClassName = "InboxHRController";
    logapiO.ActionMethodName = "عرض طلبات شؤون الموظفين-إعتمادات";
    logapiO.ActionMethodType = 1;
    if (jsonDecode(respose.body)["ErrorMessage"] == null) {
      logapiO.StatusCode = 1;
      logApi(logapiO);
      if (jsonDecode(respose.body)["RequestList"] == null) {
        _hrRequestsList = [];
      } else {
        _hrRequestsList = (jsonDecode(respose.body)["RequestList"] as List)
            .map(((e) => HrRequests.fromJson(e)))
            .toList();
      }
    } else {
      logapiO.StatusCode = 0;
      logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
      logApi(logapiO);
    }

    isLoding = false;
    notifyListeners();
  }

  List<HrRequests> get getHrRequests {
    return List.from(_hrRequestsList);
  }

  Future<dynamic> deleteEtmad(int index, bool IsRecjcted, String resondID,
      var _ReplaceEmployeeNumber, int RequestTypeID) async {
    double id = 0;
    for (int i = 0; i < _RequestRejectReasons.length; i++) {
      if (resondID == _RequestRejectReasons[i].RejectReasonName) {
        id = _RequestRejectReasons[i].RejectReasonID;
        break;
      }
    }
    String empNo = await EmployeeProfile.getEmployeeNumber();
    _ReplaceEmployeeNumber = _ReplaceEmployeeNumber ?? 0.0;
    var respose = await postAction(
        "Inbox/HrRequestApprove",
        jsonEncode({
          "RequesterEmployeeNumber":
              _hrRequestsList[index].RequesterEmployeeNumber,
          "RequestNumber": _hrRequestsList[index].RequestNumber,
          "IsApproved": IsRecjcted,
          "RejectReasonID": IsRecjcted ? 0.0 : id,
          "RequestTypeID": _hrRequestsList[index].RequestTypeID,
          "ApprovedBy": int.parse(empNo),
          "ReplacementEmployee": RequestTypeID == 3
              ? int.parse(_ReplaceEmployeeNumber.toString().split(".")[0])
              : 0
        }));

    print(respose.body);
    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }

    _hrRequestsList.removeAt(index);

    notifyListeners();
    return true;
  }

  Future<dynamic> UpdateOutDutyRequest(var _data) async {
    var respose = await postAction("HR/UpdateOutDutyRequest", _data);
    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }

    return true;
  }

  List<String> _reason = [];
  late List<RequestRejectReasons> _RequestRejectReasons;
  Future<void> fetchRejectReasonNames() async {
    var respose = await getAction("Inbox/GetHrRequestRejectReasons");
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
