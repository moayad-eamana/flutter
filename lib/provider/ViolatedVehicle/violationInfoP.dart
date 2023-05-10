import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
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
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ClassName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ActionMethodName = "تحويل الطلب إلى مدير إدارة النظافة ";
        logapiO.EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
        logapiO.ActionMethodType = 2;
        var reponse = await postAction(
            "Inbox/UpdateViolatedVehiclesRequestStatus",
            jsonEncode({
              "RequestNumber": RequestID,
              "Notes": "",
              "NewStatusID": 6,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          logapiO.StatusCode = 1;
          logApi(logapiO);
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
          logapiO.StatusCode = 0;
          logapiO.ErrorMessage = jsonDecode(reponse.body)["ErrorMessage"];
          logApi(logapiO);
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
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "UpdateViolatedVehiclesRequestStatus";
      logapiO.ClassName = "UpdateViolatedVehiclesRequestStatus";
      logapiO.ActionMethodName = "إغلاق الطلب بعد الزيارة الثانية";
      logapiO.EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
      logapiO.ActionMethodType = 2;
      var reponse = await postAction(
          "Inbox/UpdateViolatedVehiclesRequestStatus",
          jsonEncode({
            "RequestNumber": RequestID,
            "Notes": "",
            "NewStatusID": 10,
            "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
          }));
      if (jsonDecode(reponse.body)["StatusCode"] == 400) {
        logapiO.StatusCode = 1;
        logApi(logapiO);
        EasyLoading.dismiss();
        Alerts.successAlert(context, "", "تم إلغاء الطلب").show().then((value) {
          Navigator.pop(context);
        });
      } else {
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(reponse.body)["ErrorMessage"];
        logApi(logapiO);
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
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ClassName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ActionMethodName = "إعتماد المخالفة";
        logapiO.EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
        logapiO.ActionMethodType = 2;
        var reponse = await postAction(
            "Inbox/UpdateViolatedVehiclesRequestStatus",
            jsonEncode({
              "RequestNumber": RequestID,
              "Notes": "",
              "NewStatusID": 5,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          logapiO.StatusCode = 1;
          logApi(logapiO);
          Alerts.successAlert(context, "", "سيتم إرسال رسالة نصية ")
              .show()
              .then((value) {
            Navigator.pop(context);
          });
        } else {
          logapiO.StatusCode = 0;
          logapiO.ErrorMessage = jsonDecode(reponse.body)["ErrorMessage"];
          logApi(logapiO);
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(reponse.body)["ErrorMessage"])
              .show();
        }
        EasyLoading.dismiss();
      }
    });
  }
}
