import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/mahamme/PurchaseRequestItems.dart';
import 'package:eamanaapp/model/mahamme/PurchaseRequestsmodel.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PurchaseRequestsProvider extends ChangeNotifier {
  late List<PurchaseRequestsmodel> _PurchaseRequestsList = [];

  Future<dynamic> fetchPurchaseRequests(int id) async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    var EmNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction(
        "Inbox/GetPurchaseRequests/" + EmNo + "/" + id.toString());

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

  late List<PurchaseRequestItems> _PurchaseRequestItems = [];
  Future<dynamic> fetchPurchaseRequestItemst(int RequestNumber) async {
    _PurchaseRequestItems = [];
    notifyListeners();
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    var EmNo = await EmployeeProfile.getEmployeeNumber();
    var respose = await getAction(
        "Inbox/GetPurchaseRequestItems/" + RequestNumber.toString());

    if (jsonDecode(respose.body)["RequestItems"] != null) {
      _PurchaseRequestItems = (jsonDecode(respose.body)["RequestItems"] as List)
          .map(((e) => PurchaseRequestItems.fromJson(e)))
          .toList();
      notifyListeners();
    }
    notifyListeners();
    EasyLoading.dismiss();
  }

  List<PurchaseRequestItems> get PurchaseRequestItemsList {
    return List.from(_PurchaseRequestItems);
  }

  Future<dynamic> ApprovePurchasesRequest(
      int index, String Note, bool isAproved, int TransactionTypeID) async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    String emNo = await EmployeeProfile.getEmployeeNumber();
    var data = {
      "RequestNumber": _PurchaseRequestsList[index].RequestNumber,
      "ApprovedBy": int.parse(emNo),
      "TransactionTypeID": TransactionTypeID,
      "Notes": Note,
      "IsApproved": isAproved
    };
    var respose =
        await postAction("Inbox/ApprovePurchasesRequest", jsonEncode(data));

    if (jsonDecode(respose.body)["StatusCode"] != 400) {
      return jsonDecode(respose.body)["ErrorMessage"];
    }
    _PurchaseRequestsList.removeAt(index);
    notifyListeners();
    EasyLoading.dismiss();
    return true;
  }
}
