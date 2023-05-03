import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class violationInfoP {
  static transfareToManager(
      BuildContext context, int RequestID, var ArcSerial, var attac) {
    Alerts.confirmAlrt(
            context, "", "سوف يتم تحويل الطلب إلى مدير إدارة النظافة", "تحويل")
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
              "NewStatusID": 6,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          var response2 = await postAction(
              "ViolatedCars/UploadImages",
              jsonEncode({
                "EmplpyeeNumber":
                    int.parse(EmployeeProfile.getEmployeeNumber()),
                "ArcSerial": ArcSerial,
                "Attachements": [
                  {
                    "DocTypeID": 762,
                    "FileBytes": attac["base64"],
                    "FileName": attac["name"],
                    "FilePath": attac["path"],
                    "DocTypeName": attac["type"]
                  },
                ]
              }));
          EasyLoading.dismiss();
          Alerts.successAlert(context, "", "تم تحويل الطلب")
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

  static cancel5Request(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(context, "", "سوف يتم إلغاء الطلب", "نعم")
        .show()
        .then((value) async {
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
        EasyLoading.dismiss();
        Alerts.successAlert(context, "", "تم إلغاء الطلب").show().then((value) {
          Navigator.pop(context);
        });
      } else {
        Alerts.errorAlert(
                context, "خطأ", jsonDecode(reponse.body)["ErrorMessage"])
            .show();
      }
    });
  }

  static approveViolation(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(
            context, "رسالة تأكيد", "هل تريد إعتماد المخالفة ؟", "نعم")
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
              "NewStatusID": 5,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          Alerts.successAlert(context, "", "سيتم إرسال رسالة نصية ")
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
