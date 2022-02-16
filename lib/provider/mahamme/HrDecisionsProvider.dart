import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/mahamme/HrDecisions.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class HrDecisionsProvider extends ChangeNotifier {
  late List<HrDecisions> _hrDecisions = [];
  Future<void> fetchHrDecisions() async {
    notifyListeners();
    String empNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction("Inbox/GetDecisions" + "/" + empNo);
    print((jsonDecode(respose.body)["DecisionList"]));
    _hrDecisions = (jsonDecode(respose.body)["DecisionList"] as List)
        .map(((e) => HrDecisions.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<HrDecisions> get HrDecisionsList {
    return List.from(_hrDecisions);
  }

  Future<dynamic> PostAproveDesition(int index) async {
    String empNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await postAction(
        "Inbox/ApproveDecisionRequest",
        jsonEncode({
          "BossNumber": int.parse(empNo),
          "EmplyeeNumber": _hrDecisions[index].EmplyeeNumber,
          "SignTypeID": _hrDecisions[index].SignTypeID,
          "Seq": _hrDecisions[index].Seq,
          "NewClass": _hrDecisions[index].NewClass,
          "TrnsactionTypeID": _hrDecisions[index].TrnsactionTypeID,
          "ExecutionDateH": _hrDecisions[index].ExecutionDateH,
          "ExexutionDateG": _hrDecisions[index].ExexutionDateG
        }));
    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }
    _hrDecisions.removeAt(index);
    notifyListeners();
    return true;
  }
}
