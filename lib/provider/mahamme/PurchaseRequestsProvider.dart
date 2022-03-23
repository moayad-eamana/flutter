import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/mahamme/PurchaseRequestsmodel.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseRequestsProvider extends ChangeNotifier {
  late List<PurchaseRequestsmodel> _PurchaseRequestsList = [];

  Future<dynamic> fetchPurchaseRequests() async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    var EmNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction("Inbox/GetPurchaseRequests/" + EmNo + "/6");

    if (jsonDecode(respose.body)["RequestsList"] != null) {
      _PurchaseRequestsList = (jsonDecode(respose.body)["RequestsList"] as List)
          .map(((e) => PurchaseRequestsmodel.fromJson(e)))
          .toList();
      notifyListeners();
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  List<PurchaseRequestsmodel> get PurchaseRequestsList {
    return List.from(_PurchaseRequestsList);
  }
}
