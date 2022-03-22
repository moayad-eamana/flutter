import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/mahamme/Mobashara.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MobasharaProvider extends ChangeNotifier {
  List<Mobashara> _mobashara = [];

  Future<dynamic> fetchMobashara(int TypeID) async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    var EmNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction(
        "Inbox/GetStartWorkRequests/" + EmNo + "/" + TypeID.toString());

    if (jsonDecode(respose.body)["RequestsList"] != null) {
      _mobashara = (jsonDecode(respose.body)["RequestsList"] as List)
          .map(((e) => Mobashara.fromJson(e)))
          .toList();
      notifyListeners();
    }

    EasyLoading.dismiss();
  }

  Future<dynamic> ApproveStartWorkRequest(var data, int index) async {
    var respose =
        await postAction("Inbox/ApproveStartWorkRequest", jsonEncode(data));

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
