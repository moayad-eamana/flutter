import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/mahamme/LoansRequests.dart';
import 'package:eamanaapp/model/RequestRejectReasons.dart';
import 'package:eamanaapp/utilities/constantApi.dart';

import 'package:flutter/material.dart';

class LoansRequestsProvider extends ChangeNotifier {
  late List<LoansRequest> _LoanRequest = [];
  Future<void> fethLoansRequests() async {
    String empNo = await EmployeeProfile.getEmployeeNumber();

    var respose = await getAction("Inbox/GetLoansRequests" + "/" + empNo);
    print(respose);
    _LoanRequest = (jsonDecode(respose.body)["LoansList"] as List)
        .map(((e) => LoansRequest.fromJson(e)))
        .toList();
    print(_LoanRequest);
    notifyListeners();
  }

  List<LoansRequest> get LoansRequestList {
    return List.from(_LoanRequest);
  }

  Future<dynamic> deleteLoansReques(int index, String FinancialType,
      ApproveFlag, String Note, String _rejectReason, String Duration) async {
    print(FinancialType);
    print(ApproveFlag);
    print(Note);

    String empNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await postAction(
        "Inbox/ApproveLoanRequest",
        jsonEncode({
          "BdgLoc": _LoanRequest[index].BdgLoc,
          "EmployeeNumber": _LoanRequest[index].EmployeeNumber,
          "RequestNumber": _LoanRequest[index].RequestNumber,
          "RequestTypeID": _LoanRequest[index].RequestTypeID,
          "Duration": Duration,
          "LocationCode": _LoanRequest[index].LocationCode,
          "ApprovedBy": empNo,
          "FinancialType": FinancialType,
          "Notes": Note,
          "ApproveFlag": ApproveFlag,
          "StatusID": _LoanRequest[index].StatusID
        }));
    print(_LoanRequest[index].BdgLoc.toString() +
        " " +
        _LoanRequest[index].EmployeeName +
        " " +
        _LoanRequest[index].RequestNumber.toString() +
        " " +
        _LoanRequest[index].RequestTypeID.toString() +
        " " +
        _LoanRequest[index].LocationCode.toString() +
        "id " +
        _LoanRequest[index].StatusID.toString());
    print(respose.body);
    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }

    _LoanRequest.removeAt(index);
    notifyListeners();
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
}
