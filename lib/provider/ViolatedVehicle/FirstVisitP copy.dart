import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
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
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ClassName = "UpdateViolatedVehiclesRequestStatus";
        logapiO.ActionMethodName = "إعتماد الزيارة الأولى";
        logapiO.EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
        logapiO.ActionMethodType = 2;
        var reponse = await postAction(
            "Inbox/UpdateViolatedVehiclesRequestStatus",
            jsonEncode({
              "RequestNumber": RequestID,
              "Notes": "",
              "NewStatusID": 3,
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          logapiO.StatusCode = 1;
          logApi(logapiO);
          Alerts.successAlert(context, "", "تم إحالة الطلب للمراقب")
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

  static cancelRequest(BuildContext context, int RequestID) {
    Alerts.confirmAlrt(context, "رسالة تأكيد", "هل تريد إغلاق الطلب ؟", "نعم")
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
        logapiO.ActionMethodName = "إغلاق الطلب الزيارة الاولى";
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
          Alerts.successAlert(context, "", "تم إغلاق الطلب")
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
