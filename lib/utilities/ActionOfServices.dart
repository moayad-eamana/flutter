import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/Settings/settings.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../main.dart';

ServiceButton(e, BuildContext context) {
  return StaggeredGridTileW(
    1,
    100,
    ElevatedButton(
      style: cardServiece,
      onPressed: () {
        if (e["service_name"] == "رصيد إجازات") {
          rseed(context);
          return;
        }
        if (e["service_name"] == "سجل الرواتب" ||
            e["service_name"] == "تعريف بالراتب") {
          salary(e["service_name"], context);
          return;
        }

        e["Navigation"] is String
            ? Navigator.pushNamed(context, e["Navigation"])
            : Navigator.push(context, e["Navigation"]);
        return;
      },
      child: widgetsUni.cardcontentService(e["icon"], e["service_name"]),
    ),
  );
}

Widget servicebuttonFavs(e, BuildContext context) {
  return widgetsUni.servicebutton(
    e["service_name"],
    e["icon"],
    e["Action"],
  );
}

Future<void> rseed(BuildContext context) async {
  EasyLoading.show(
    status: '... جاري المعالجة',
    maskType: EasyLoadingMaskType.black,
  );
  String emNo = await EmployeeProfile.getEmployeeNumber();
  dynamic respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
  respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];

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
  ).then((value) => null);
}

salary(servName, BuildContext context) async {
  if (servName == "تعريف بالراتب") {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if ((sharedPref.getString("dumyuser") != "10284928492")) {
      String emNo = await EmployeeProfile.getEmployeeNumber();
      var respons = await getAction("HR/GetEmployeeSalaryReport/" + emNo);
      EasyLoading.dismiss();
      if (fingerprint == true) {
        Navigator.pushNamed(context, "/auth_secreen").then((value) {
          if (value == true) {
            if (jsonDecode(respons.body)["salaryPdf"] != null) {
              ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
                  .then((value) {});
            } else {
              Alerts.warningAlert(
                      context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
                  .show();
            }
          }
        });
      } else {
        if (jsonDecode(respons.body)["salaryPdf"] != null) {
          ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
              .then((value) {});
        } else {
          Alerts.warningAlert(context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
              .show();
        }
      }
    } else {
      Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      Alerts.warningAlert(context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
          .show();
    }
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "SalaryController";
    logapiO.ClassName = "SalaryController";
    logapiO.ActionMethodName = "تعريف بالراتب";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
  } else if (servName == "سجل الرواتب") {
    if (fingerprint == true) {
      Navigator.pushNamed(context, "/auth_secreen").then((value) {
        if (value == true) {
          Navigator.pushNamed(context, "/SalaryHistory").then((value) {
            //   close(this.context, null);
          });
        }
      });
    } else {
      Navigator.pushNamed(context, "/SalaryHistory").then((value) {});
    }
  }
}

List<dynamic> listOfFavs(BuildContext context) {
  listOfServices obj = listOfServices(context);
  List serv = obj.Salarservices() +
      obj.attendanceService() +
      obj.customerService() +
      obj.hrservices() +
      obj.otherService() +
      obj.questService();
  List<String> favs = sharedPref.getStringList("favs") ?? [];
  List<dynamic> list = [];
  for (int i = 0; favs.length > i; i++) {
    for (int j = 0; serv.length > j; j++) {
      if (favs[i] == serv[j]["service_name"]) {
        list.insert(0, serv[j]);
      }
    }
  }
  return list;
}
