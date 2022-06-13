import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/Settings/settings.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

        Navigator.pushNamed(context, e["Navigation"]);
      },
      child: widgetsUni.cardcontentService(e["icon"], e["service_name"]),
    ),
  );
}

Widget servicebuttonFavs(e, BuildContext context) {
  return widgetsUni.servicebutton(
    e["service_name"],
    e["icon"],
    () {
      if (e["service_name"] == "رصيد إجازات") {
        rseed(context);
        return;
      }
      if (e["service_name"] == "سجل الرواتب" ||
          e["service_name"] == "تعريف بالراتب") {
        salary(e["service_name"], context);
        return;
      }
      Navigator.pushNamed(context, e["Navigation"]);
    },
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
    String emNo = await EmployeeProfile.getEmployeeNumber();
    var respons = await getAction("HR/GetEmployeeSalaryReport/" + emNo);
    EasyLoading.dismiss();
    fingerprint == true
        ? Navigator.pushNamed(context, "/auth_secreen").then((value) {
            if (value == true) {
              ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
                  .then((value) {});
            }
          })
        : ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
            .then((value) {});
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
