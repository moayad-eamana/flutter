import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/model/mahamme/Mobashara.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MobasharaProvider extends ChangeNotifier {
  List<Mobashara> _mobashara = [];

  Future<dynamic> fetchMobashara(int TypeID) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var EmNo = await EmployeeProfile.getEmployeeNumber();
    var respose;
    if (TypeID == 132) {
      respose = await getAction("Inbox/GetContinueWorkRequests/" + EmNo);
    } else {
      respose = await getAction(
          "Inbox/GetStartWorkRequests/" + EmNo + "/" + TypeID.toString());
    }
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "InboxHRController";
    logapiO.ClassName = "InboxHRController";
    logapiO.ActionMethodName = TypeID == 132
        ? "عرض طلبات إعتماد استمرار موظف-إعتمادات"
        : "مباشرة عمل -إعتمادات";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    if (jsonDecode(respose.body)["RequestsList"] != null) {
      _mobashara = (jsonDecode(respose.body)["RequestsList"] as List)
          .map(((e) => Mobashara.fromJson(e)))
          .toList();
      notifyListeners();
    }

    EasyLoading.dismiss();
  }

  Future<dynamic> ApproveStartWorkRequest(var data, int index, int id) async {
    var respose;
    if (id == 132) {
      respose =
          await postAction("Inbox/ApproveContinueRequest", jsonEncode(data));
    } else {
      respose =
          await postAction("Inbox/ApproveStartWorkRequest", jsonEncode(data));
    }

    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }
    _mobashara.removeAt(index);
    notifyListeners();
    return true;
  }

  List<Mobashara> get MobasharaList {
    return List.from(_mobashara);
  }
}
