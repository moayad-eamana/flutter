import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class GetCardRequestInfo extends StatefulWidget {
  @override
  State<GetCardRequestInfo> createState() => _GetCardRequestInfoState();
}

class _GetCardRequestInfoState extends State<GetCardRequestInfo> {
  dynamic CardRequestInfo;
  TextEditingController _notes = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? index;
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    index = args["index"];
    CardRequestInfo = args["data"];
    print(CardRequestInfo);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(
          "التفاصيل",
          context,
          null,
        ),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 90.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "رقم الطلب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CardRequestInfo["RequestNumber"]
                                          .toString(),
                                      style: descTx1(secondryColorText),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 90.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "نوع الطلب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CardRequestInfo["Reason"].toString(),
                                      style: descTx1(secondryColorText),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 90.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "تاريخ الطلب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CardRequestInfo["RequestDate"]
                                          .toString()
                                          .split("T")[0],
                                      style: descTx1(secondryColorText),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 90.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "تاريخ إنتهاء البطاقة",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CardRequestInfo["ExpiryDate"]
                                          .toString()
                                          .split("T")[0],
                                      style: descTx1(secondryColorText),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: 100.w,
                          child: Column(
                            children: [
                              Text(
                                "إسم الموظف",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CardRequestInfo["FullArName"].toString(),
                                style: descTx1(secondryColorText),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: 100.w,
                          child: Column(
                            children: [
                              Text(
                                "رقم الموظف",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CardRequestInfo["EmployeeNumber"].toString(),
                                style: descTx1(secondryColorText),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: 100.w,
                          child: Column(
                            children: [
                              Text(
                                "المسمى الوظيفي",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CardRequestInfo["JobTitle"].toString() == ""
                                    ? "لايوجد"
                                    : CardRequestInfo["JobTitle"],
                                style: descTx1(secondryColorText),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: 100.w,
                          child: Column(
                            children: [
                              Text(
                                "الوظيفة القائم بها",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CardRequestInfo["CurrentJob"].toString() == ""
                                    ? "لايوجد"
                                    : CardRequestInfo["CurrentJob"],
                                style: descTx1(secondryColorText),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (CardRequestInfo["CompanyName"] != "")
                        Card(
                          child: Container(
                            decoration: containerdecoration(BackGWhiteColor),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 100.w,
                            child: Column(
                              children: [
                                Text(
                                  "إسم الشركة",
                                  style: subtitleTx(secondryColor),
                                ),
                                Text(
                                  CardRequestInfo["CompanyName"],
                                  style: descTx1(secondryColorText),
                                )
                              ],
                            ),
                          ),
                        ),
                      if (CardRequestInfo["ProjectName"] != "")
                        Card(
                          child: Container(
                            decoration: containerdecoration(BackGWhiteColor),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: 100.w,
                            child: Column(
                              children: [
                                Text(
                                  "إسم المشروع",
                                  style: subtitleTx(secondryColor),
                                ),
                                Text(
                                  CardRequestInfo["ProjectName"],
                                  style: descTx1(secondryColorText),
                                )
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _notes,
                              maxLines: 3,
                              style: TextStyle(
                                color: baseColorText,
                              ),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: secondryColorText),
                                errorStyle: TextStyle(color: redColor),

                                contentPadding: EdgeInsets.symmetric(
                                    vertical: responsiveMT(12, 30),
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(color: bordercolor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bordercolor),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: bordercolor),
                                  borderRadius: BorderRadius.circular(4),
                                ),

                                // filled: true,
                                // fillColor: Colors.white,
                                labelText: "ملاحظات",
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال ملاحظات";
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: BorderSide(
                                width: 0.5,
                                color: bordercolor,
                              ),
                              elevation: 0,
                              primary: baseColor,
                            ),
                            onPressed: () async {
                              Alerts.confirmAlrt(
                                      context, "", "هل تريد قبول الطلب", "نعم")
                                  .show()
                                  .then((value) async {
                                if (value == true) {
                                  EasyLoading.show(
                                    status: '... جاري المعالجة',
                                    maskType: EasyLoadingMaskType.black,
                                  );

                                  var respose = await postAction(
                                      "Inbox/ApproveCard",
                                      jsonEncode({
                                        "RequestNumber":
                                            CardRequestInfo["RequestNumber"],
                                        "ApproveFlag": 1,
                                        "SignedBy": CardRequestInfo["SignBy"],
                                        "Notes": ""
                                      }));
                                  EasyLoading.dismiss();
                                  if (jsonDecode(respose.body)["StatusCode"] !=
                                      400) {
                                    Alerts.errorAlert(
                                            context,
                                            "خطأ",
                                            jsonDecode(
                                                respose.body)["ErrorMessage"])
                                        .show();
                                    return;
                                  } else {
                                    Alerts.successAlert(
                                            context, "", "تم قبول الطلب")
                                        .show()
                                        .then((value) {
                                      Navigator.pop(context, index);
                                    });
                                  }
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "قبول",
                                  style: descTx1(BackGWhiteColor),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: BorderSide(
                                width: 0.5,
                                color: bordercolor,
                              ),
                              elevation: 0,
                              primary: redColor,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Alerts.confirmAlrt(
                                        context, "", "هل تريد رفض الطلب", "نعم")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    var respose = await postAction(
                                        "Inbox/ApproveCard",
                                        jsonEncode({
                                          "RequestNumber":
                                              CardRequestInfo["RequestNumber"],
                                          "ApproveFlag": 2,
                                          "SignedBy": CardRequestInfo["SignBy"],
                                          "Notes": _notes.text
                                        }));
                                    EasyLoading.dismiss();
                                    if (jsonDecode(
                                            respose.body)["StatusCode"] !=
                                        400) {
                                      Alerts.errorAlert(
                                              context,
                                              "خطأ",
                                              jsonDecode(
                                                  respose.body)["ErrorMessage"])
                                          .show();
                                      return;
                                    } else {
                                      Alerts.successAlert(
                                              context, "", "تم رفض الطلب")
                                          .show()
                                          .then((value) {
                                        Navigator.pop(context, index);
                                      });
                                    }
                                  }
                                });
                              }
                            },
                            child: Text(
                              "رفض",
                              style: descTx1(BackGWhiteColor),
                              maxLines: 2,
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
