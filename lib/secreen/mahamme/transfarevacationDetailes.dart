import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class transfarevacationDetailes extends StatefulWidget {
  var transfarevacationRequeste;
  int index;
  transfarevacationDetailes(this.transfarevacationRequeste, this.index);

  @override
  State<transfarevacationDetailes> createState() =>
      _transfarevacationDetailesState();
}

class _transfarevacationDetailesState extends State<transfarevacationDetailes> {
  TextEditingController rejectReason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("التفاصيل", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Cards("إسم الموظف",
                          widget.transfarevacationRequeste["EmployeeName"]),
                      Cards(
                          "رقم الموظف",
                          widget.transfarevacationRequeste["EmployeeNumber"]
                              .toString()),
                      Cards(
                          "تاريخ الطلب",
                          widget.transfarevacationRequeste["RequestDate"]
                              .toString()
                              .split("T")[0]),
                      Cards(
                          "حالة الطلب",
                          widget.transfarevacationRequeste["RequestStatusName"]
                              .toString()),
                      Card(
                        color: BackGColor,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء إدخال سبب الرفض";
                                }
                              },
                              controller: rejectReason,
                              style: TextStyle(
                                color: baseColorText,
                              ),
                              maxLines: 3,
                              decoration: formlabel1("سبب الرفض"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: baseColor, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                Alerts.confirmAlrt(
                                        context,
                                        "هل أنت متأكد",
                                        "هل أنت متأكد من إعتماد الطلب",
                                        "إعتماد")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    var respons = await postAction(
                                        "Inbox/ApprovedExtendVactionRequest",
                                        jsonEncode({
                                          "EmployeeNumber":
                                              widget.transfarevacationRequeste[
                                                  "EmployeeNumber"],
                                          "ApprovedBy": int.parse(sharedPref
                                              .getDouble("EmployeeNumber")
                                              .toString()
                                              .split(".")[0]),
                                          "Notes": rejectReason.text,
                                          "IsApproved": true
                                        }));
                                    EasyLoading.dismiss();
                                    if (jsonDecode(respons.body)["IsUpdated"] ==
                                        true) {
                                      Alerts.successAlert(
                                              context, "", "تم إعتماد الطلب")
                                          .show()
                                          .then((value) {
                                        Navigator.pop(context, widget.index);
                                      });
                                    } else {
                                      Alerts.errorAlert(
                                              context,
                                              "خطأ",
                                              jsonDecode(
                                                  respons.body)["ErrorMessage"])
                                          .show();
                                    }
                                  }
                                });
                              },
                              child: Text("إعتماد"),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: redColor, // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                Alerts.confirmAlrt(context, "هل أنت متأكد",
                                        "هل أنت متأكد من رفض الطلب", "رفض")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    var respons = await postAction(
                                        "Inbox/ApprovedExtendVactionRequest",
                                        jsonEncode({
                                          "EmployeeNumber":
                                              widget.transfarevacationRequeste[
                                                  "EmployeeNumber"],
                                          "ApprovedBy": int.parse(sharedPref
                                              .getDouble("EmployeeNumber")
                                              .toString()
                                              .split(".")[0]),
                                          "Notes": rejectReason.text,
                                          "IsApproved": false
                                        }));
                                    EasyLoading.dismiss();
                                    if (jsonDecode(respons.body)["IsUpdated"] ==
                                        true) {
                                      Alerts.successAlert(
                                              context, "", "تم رفض الطلب")
                                          .show()
                                          .then((value) {
                                        Navigator.pop(context, widget.index);
                                      });
                                    } else {
                                      Alerts.errorAlert(
                                              context,
                                              "خطأ",
                                              jsonDecode(
                                                  respons.body)["ErrorMessage"])
                                          .show();
                                    }
                                  }
                                });
                              },
                              child: Text("رفض"),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Cards(String title, String des) {
    return Card(
      color: BackGColor,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: subtitleTx(secondryColorText),
            ),
            Text(
              des,
              style: titleTx(baseColorText),
            )
          ],
        ),
      ),
    );
  }
}
