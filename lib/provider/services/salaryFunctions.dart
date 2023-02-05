import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../main.dart';

class salaryFunction {
  static salaryHistory(BuildContext context) async {
    //final fingerprintSP = await SharedPreferences.getInstance();
    bool fingerprint = sharedPref.getBool('fingerprint')!;
    if (fingerprint == true) {
      Navigator.pushNamed(context, "/auth_secreen").then((value) {
        if (value == true) {
          Navigator.pushNamed(context, "/SalaryHistory");
        }
      });
    } else {
      Navigator.pushNamed(context, "/SalaryHistory");
    }
  }

  static SalaryReport(BuildContext context) async {
    //final fingerprintSP = await SharedPreferences.getInstance();
    bool fingerprint = sharedPref.getBool('fingerprint')!;
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      String emNo = await EmployeeProfile.getEmployeeNumber();
      var respons = await getAction("HR/GetEmployeeSalaryReport/" + emNo);
      EasyLoading.dismiss();
      if (fingerprint == true) {
        Navigator.pushNamed(context, "/auth_secreen").then((value) async {
          if (value == true) {
            //      print(jsonDecode(respons.body)["salaryPdf"]);

            if (jsonDecode(respons.body)["salaryPdf"] != null) {
              ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf");
            } else {
              Alerts.warningAlert(
                      context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
                  .show();
            }
          }
        });
      } else {
        if (jsonDecode(respons.body)["salaryPdf"] != null) {
          ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf");
        } else {
          Alerts.warningAlert(context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
              .show();
        }
      }
    } else {
      await Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      Alerts.errorAlert(context, "", "لايوجد تعريف بالراتب").show();
    }
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "SalaryController";
    logapiO.ClassName = "SalaryController";
    logapiO.ActionMethodName = "تعريف بالراتب";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
  }
}
