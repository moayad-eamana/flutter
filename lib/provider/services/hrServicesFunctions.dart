import 'dart:convert';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../main.dart';

class hrServicesFunctions {
  static rased(BuildContext context) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    dynamic respose;
    if (sharedPref.getString("dumyuser") != "10284928492") {
      String emNo = await EmployeeProfile.getEmployeeNumber();
      respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
      respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
    } else {
      await Future.delayed(Duration(seconds: 1));
      respose = "22";
    }
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "VacationsController";
    logapiO.ClassName = "VacationsController";
    logapiO.ActionMethodName = "رصيد الاجازات";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);

    EasyLoading.dismiss();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: BackGWhiteColor,
          title: Builder(builder: (context) {
            return Center(
              child: Text(
                'رصيد الاجازات',
                style: titleTx(baseColor),
              ),
            );
          }),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                respose.toString(),
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: secondryColor),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetsUni.actionbutton(
                  'طلب إجازة',
                  Icons.send,
                  () {
                    Navigator.pushNamed(context, "/VacationRequest")
                        .then((value) => Navigator.pop(context));
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'إغلاق',
                    style: subtitleTx(baseColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static insertExtensionRequest(BuildContext context) {
    Alerts.confirmAlrt(context, "ترحيل الاجازة",
            "سيتم ترحيل الاجازة, هل انت موافق ؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );

        var respose = await postAction(
            "HR/InsertExtensionRequest",
            jsonEncode({
              "EmployeeNumber": int.parse(sharedPref
                  .getDouble("EmployeeNumber")
                  .toString()
                  .split(".")[0])
            }));

        print(respose.body);

        respose = jsonDecode(respose.body);

        EasyLoading.dismiss();

        if (respose["StatusMessage"] == "Succeeded") {
          Alerts.successAlert(context, "ترحيل الاجازة", "تم الطلب الترحيل")
              .show();
        } else {
          Alerts.errorAlert(
                  context, "ترحيل الاجازة", respose["ErrorMessage"] ?? "")
              .show();
        }

        // setState(() {});
      }
    });
    ;
  }
}
