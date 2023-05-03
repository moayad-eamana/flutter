import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SecondVisitP {
  static cancelRequest(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(context, "رسالة تأكيد", "سوف يتم إلغاء الطلب", "نعم")
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
          Alerts.successAlert(context, "", "تم إلغاء الطلب")
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

  static sendSecondVisit(BuildContext context, int RequestID, String _Note,
      bool yes, var locationID, var Ataachment) {
    Alerts.confirmAlrt(context, "", "هل أنت متأكد من إرسال الطلب", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );

        var response = await postAction(
            "ViolatedCars/InsertVisit",
            jsonEncode({
              "EmplpyeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
              "RequestNumber": RequestID,
              "Notes": _Note,
              "IsProcessed": yes ? 1 : 0,
              "LocationID": locationID,
              "VisiID": 2,
              "Attachements": Ataachment
            }));

        if (jsonDecode(response.body)["StatusCode"] == 400) {
          var response2 = await postAction(
              "Inbox/UpdateViolatedVehiclesRequestStatus",
              jsonEncode({
                "RequestNumber": RequestID,
                "Notes": "",
                "NewStatusID": 4,
                "EmployeeNumber":
                    int.parse(EmployeeProfile.getEmployeeNumber()),
              }));
          EasyLoading.dismiss();

          if (jsonDecode(response2.body)["StatusCode"] == 400) {
            Alerts.successAlert(context, "", "تم الارسال").show().then((value) {
              Navigator.pop(context);
            });
          } else {
            Alerts.errorAlert(
                    context, "", jsonDecode(response2.body)["ErrorMessage"])
                .show();
            return;
          }
        } else {
          EasyLoading.dismiss();
          Alerts.errorAlert(context, "خطأ",
                  jsonDecode(response.body)["ErrorMessage"].toString())
              .show();
          return;
        }
      }
    });
  }
}
