import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
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
    try {
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "InboxHRController";
      logapiO.ClassName = "InboxHRController";
      logapiO.ActionMethodName = "عرض طلبات القرارات الإلكترونية-إعتمادات";
      logapiO.ActionMethodType = 1;
      if (jsonDecode(respose.body)["ErrorMessage"] == null) {
        logapiO.StatusCode = 1;
        logApi(logapiO);
        _hrDecisions = (jsonDecode(respose.body)["DecisionList"] as List)
            .map(((e) => HrDecisions.fromJson(e)))
            .toList();
      } else {
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
        logApi(logapiO);
      }
    } catch (e) {
      _hrDecisions = [];
    }

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
          "RequestNumber": _hrDecisions[index].Seq,
          "SignTypeID": _hrDecisions[index].SignTypeID,
          "BossNumber": int.parse(empNo)
        }));
    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }
    _hrDecisions.removeAt(index);
    notifyListeners();
    return true;
  }
}
