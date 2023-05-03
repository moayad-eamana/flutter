import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirstVisitP {
  static transformToinespector(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(
            context, "رسالة تأكيد", "هل تريد إحالة الطلب للمراقب ؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );
        var reponse = await postAction(
            "Inbox/UpdateViolatedVehiclesRequestStatus",
            jsonEncode({
              "RequestNumber": RequestID,
              "Notes": "",
              "NewStatusID": 3,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          Alerts.successAlert(context, "", "تم إحالة الطلب للمراقب")
              .show()
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(reponse.body)["ErrorMessage"])
              .show();
        }
        EasyLoading.dismiss();
      }
    });
  }

  static cancelRequest(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(context, "رسالة تأكيد", "هل تريد إغلاق الطلب ؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );
        var reponse = await postAction(
            "Inbox/UpdateViolatedVehiclesRequestStatus",
            jsonEncode({
              "RequestNumber": RequestID,
              "Notes": "",
              "NewStatusID": 10,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          Alerts.successAlert(context, "", "تم إغلاق الطلب")
              .show()
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(reponse.body)["ErrorMessage"])
              .show();
        }
        EasyLoading.dismiss();
      }
    });
  }
}
