import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/RequestsHr/auhad.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class desclaimerDetailes extends StatefulWidget {
  var desclaimer;
  int index;
  desclaimerDetailes(this.desclaimer, this.index);

  @override
  State<desclaimerDetailes> createState() => _desclaimerDetailesState();
}

class _desclaimerDetailesState extends State<desclaimerDetailes> {
  TextEditingController rejectReason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("التفاصيل", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                width: 100.w,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Cards("رقم الطلب",
                        widget.desclaimer["RequestNumber"].toString()),
                    Cards("إسم الموظف", widget.desclaimer["EmployeeName"]),
                    Cards(
                        "رقم الموظف",
                        widget.desclaimer["EmployeeNumber"]
                            .toString()
                            .split(".")[0]),
                    Cards(
                        "تاريخ الطلب",
                        widget.desclaimer["RequestDate"]
                            .toString()
                            .split("T")[0]),
                    // Cards("حالة الطلب", widget.desclaimer["RequestStatusName"]),
                    Card(
                      color: BackGColor,
                      child: Container(
                        width: 100.w,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "العهد",
                              style: subtitleTx(baseColorText),
                            ),
                            widget.desclaimer["Custodies"] == null
                                ? Text(
                                    "لايوجد عهد",
                                    style: subtitleTx(secondryColorText),
                                  )
                                : Container(
                                    width: 120,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: baseColor, // background
                                        onPrimary: Colors.white, // foreground
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Auhad(widget
                                                  .desclaimer["Custodies"]),
                                            ));
                                      },
                                      child: Text("عرض العهد"),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: baseColor, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () async {
                                  Alerts.confirmAlrt(
                                          context,
                                          "هل انت متأكد",
                                          "هل أنت متأكد من إعتماد الطلب",
                                          'إعتماد')
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      var respinse = await postAction(
                                          "Inbox/ApprovedEvacuationRequest",
                                          jsonEncode({
                                            "RequestNumber": widget
                                                .desclaimer["RequestNumber"],
                                            "ApprovedBy": int.parse(sharedPref
                                                .getDouble("EmployeeNumber")
                                                .toString()
                                                .split(".")[0]),
                                            "TransactionTypeID": 21,
                                            "Notes": "",
                                            "IsApproved": true
                                          }));
                                      EasyLoading.dismiss();
                                      if (jsonDecode(
                                              respinse.body)["IsUpdated"] ==
                                          true) {
                                        Alerts.successAlert(
                                                context, "تم إعتماد الطلب", "")
                                            .show()
                                            .then((value) {
                                          Navigator.pop(context, widget.index);
                                        });
                                      } else {
                                        Alerts.errorAlert(
                                                context,
                                                "خطأ",
                                                jsonDecode(respinse.body)[
                                                    "ErrorMessage"])
                                            .show();
                                      }
                                    }
                                  });
                                },
                                child: Text("إعتماد")),
                          ),
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
                                  Alerts.confirmAlrt(context, "هل انت متأكد",
                                          "هل أنت متأكد من رفض الطلب", 'رفض')
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      var respinse = await postAction(
                                          "Inbox/ApprovedEvacuationRequest",
                                          jsonEncode({
                                            "RequestNumber": widget
                                                .desclaimer["RequestNumber"],
                                            "ApprovedBy": int.parse(sharedPref
                                                .getDouble("EmployeeNumber")
                                                .toString()
                                                .split(".")[0]),
                                            "TransactionTypeID": 21,
                                            "Notes": rejectReason.text,
                                            "IsApproved": false
                                          }));
                                      EasyLoading.dismiss();
                                      if (jsonDecode(
                                              respinse.body)["IsUpdated"] ==
                                          true) {
                                        Alerts.successAlert(
                                                context, "تم رفض الطلب", "")
                                            .show()
                                            .then((value) {
                                          Navigator.pop(context, widget.index);
                                        });
                                      } else {
                                        Alerts.errorAlert(
                                                context,
                                                "خطأ",
                                                jsonDecode(respinse.body)[
                                                    "ErrorMessage"])
                                            .show();
                                      }
                                    }
                                  });
                                },
                                child: Text("رفض")),
                          )
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
              style: subtitleTx(baseColorText),
            ),
            Text(
              des,
              style: subtitleTx(secondryColorText),
            )
          ],
        ),
      ),
    );
  }
}
