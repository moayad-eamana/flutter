import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmpInfo.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstVisit extends StatefulWidget {
  dynamic firstvisit;
  FirstVisit(this.firstvisit);

  @override
  State<FirstVisit> createState() => _FirstVisitState();
}

class _FirstVisitState extends State<FirstVisit> {
  dynamic visits;
  List path = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      visits = widget.firstvisit["Visits"][0];
      print(visits);
      getimage();
    });
  }

  void getimage() async {
    var respone = await getAction(
        "ViolatedCars/GetVisitAttachments/${visits["ArcSerial"]}");
    respone = jsonDecode(respone.body);
    if (respone["StatusCode"] == 400) {
      respone = respone["data"];
      print(respone[0]["FilePath"]);
      path = [
        "https://archive.eamana.gov.sa/TransactFileUpload/" +
            respone[1]["FilePath"]
      ];
      setState(() {});
    } else {
      Alerts.warningAlert(context, "رسالة", "لا توجد بيانات").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            cards(
                "تاريخ الزيارة", visits["VisitDate"].toString().split("T")[0]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("ملاحظات",
                visits["Notes"] == "" ? "لاتوجد ملاحظات" : visits["Notes"]),
          ],
        ),

        /// show images
        Container(
          margin: EdgeInsets.all(15),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: path.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 5.0),
            itemBuilder: (BuildContext context, int index) {
              return widgetsUni.viewImageNetwork(
                  path[index].toString(), context);
            },
          ),
        ),

        if (widget.firstvisit["StatusID"] == 2)
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widgetsUni.actionbutton('إحالة الطلب للمراقب', Icons.forward,
                    () async {
                  Alerts.confirmAlrt(context, "رسالة تأكيد",
                          "هل تريد إحالة الطلب للمراقب ؟", "نعم")
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
                            "RequestNumber": widget.firstvisit["RequestID"],
                            "Notes": "",
                            "NewStatusID": 3,
                            "EmployeeNumber":
                                int.parse(EmployeeProfile.getEmployeeNumber()),
                          }));
                      if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                        Alerts.successAlert(
                                context,
                                "",
                                "تم تحديث الطلب" +
                                    " " +
                                    jsonDecode(reponse.body)["StatusMessage"]
                                        .toString())
                            .show()
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        Alerts.errorAlert(context, "خطأ",
                                jsonDecode(reponse.body)["ErrorMessage"])
                            .show();
                      }
                      EasyLoading.dismiss();
                    }
                  });
                }),
                widgetsUni.actionbutton('إغلاق الطلب', Icons.close, () async {
                  Alerts.confirmAlrt(context, "رسالة تأكيد",
                          "هل تريد إغلاق الطلب ؟", "نعم")
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
                            "RequestNumber": widget.firstvisit["RequestID"],
                            "Notes": "",
                            "NewStatusID": 10,
                            "EmployeeNumber":
                                int.parse(EmployeeProfile.getEmployeeNumber()),
                          }));
                      if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                        Alerts.successAlert(
                                context,
                                "",
                                "تم تحديث الطلب" +
                                    " " +
                                    jsonDecode(reponse.body)["StatusMessage"]
                                        .toString())
                            .show()
                            .then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        Alerts.errorAlert(context, "خطأ",
                                jsonDecode(reponse.body)["ErrorMessage"])
                            .show();
                      }
                      EasyLoading.dismiss();
                    }
                  });
                }),
              ],
            ),
          ),
      ],
    );
  }

  Widget cards(String title, String desc) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            child: Container(
          decoration: containerdecoration(BackGWhiteColor),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: subtitleTx(secondryColorText),
              ),
              Text(desc, style: subtitleTx(baseColorText)),
            ],
          ),
        )),
      ),
    );
  }
}
