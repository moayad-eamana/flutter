import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/getattachment.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class CooperativeTrainingRequestsInfo extends StatefulWidget {
  @override
  State<CooperativeTrainingRequestsInfo> createState() =>
      _CooperativeTrainingRequestsInfoState();
}

class _CooperativeTrainingRequestsInfoState
    extends State<CooperativeTrainingRequestsInfo> {
  TextEditingController _notes = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? index;
  dynamic CooperativeTrainingRequestsInfo = [];
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;
    index = args["index"];
    CooperativeTrainingRequestsInfo = args["data"];
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("التفاصيل", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          decoration: containerdecoration(BackGWhiteColor),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: 100.w,
                          child: Column(
                            children: [
                              Text(
                                "رقم الطلب",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo["RequestID"]
                                    .toString(),
                                style: descTx1(baseColorText),
                              ),
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
                                "إسم الطالب",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo[
                                    "StudentNameAr"],
                                style: descTx1(baseColorText),
                              ),
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
                                "الجامعة",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo[
                                    "StudentUniversity"],
                                style: descTx1(baseColorText),
                              ),
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
                                "التخصص",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo["Major"],
                                style: descTx1(baseColorText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "المعدل",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                                  "GPAScore"]
                                              .toString() +
                                          " من " +
                                          CooperativeTrainingRequestsInfo[
                                                  "GPAType"]
                                              .toString(),
                                      style: descTx1(baseColorText),
                                    ),
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "تاريخ التخرج",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                              "GraduationYear"]
                                          .toString(),
                                      style: descTx1(baseColorText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "بداية التدريب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                              "TrainingStartDate"]
                                          .toString()
                                          .split("T")[0],
                                      style: descTx1(baseColorText),
                                    ),
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "نهاية التدريب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                              "TrainingEndDate"]
                                          .toString()
                                          .split("T")[0],
                                      style: descTx1(baseColorText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "جوال المتدرب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                          "StudentMobileNumber"],
                                      style: descTx1(baseColorText),
                                    ),
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "البريد الالكتروني للطالب",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                              "StudentEmail"]
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: descTx1(baseColorText),
                                    ),
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
                                "إسم المشرف",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo[
                                        "SupervisorName"]
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: descTx1(baseColorText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                decoration:
                                    containerdecoration(BackGWhiteColor),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "جوال المشرف",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                          "SupervisorMobileNumber"],
                                      style: descTx1(baseColorText),
                                    ),
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
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Text(
                                      "البريد الالكتروني للمشرف",
                                      style: subtitleTx(secondryColor),
                                    ),
                                    Text(
                                      CooperativeTrainingRequestsInfo[
                                              "SupervisorEmail"]
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: descTx1(baseColorText),
                                    ),
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
                                "حالة الطلب",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo["StatusName"]
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: descTx1(baseColorText),
                              ),
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
                                "ملاحظات الطالب",
                                style: subtitleTx(secondryColor),
                              ),
                              Text(
                                CooperativeTrainingRequestsInfo["StudentNotes"]
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: descTx1(baseColorText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100.w,
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
                            try {
                              String path = await getAttachment(
                                  CooperativeTrainingRequestsInfo["ArcSerial"]);
                              launch(path);
                            } catch (e) {
                              EasyLoading.dismiss();
                              Alerts.warningAlert(context, "", "لايوجد مرفقات")
                                  .show();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "عرض الملف",
                                style: descTx1(BackGWhiteColor),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Form(
                        child: Card(
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
                                  labelStyle:
                                      TextStyle(color: secondryColorText),
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
                      ),
                      Container(
                        width: 80.w,
                        child: Row(
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
                                Alerts.confirmAlrt(context, "",
                                        "هل تريد قبول الطلب", "نعم")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );

                                    var respose = await postAction(
                                        "Inbox/ApproveTraining",
                                        jsonEncode({
                                          "RequestNumber":
                                              CooperativeTrainingRequestsInfo[
                                                  "RequestID"],
                                          "StatusID": 1,
                                          "SignedBy": int.parse(sharedPref
                                              .getDouble("EmployeeNumber")
                                              .toString()
                                              .split(".")[0]),
                                          "Notes": ""
                                        }));
                                    EasyLoading.dismiss();
                                    logApiModel logapiO = logApiModel();
                                    logapiO.ControllerName =
                                        "InboxHRController";
                                    logapiO.ClassName = "InboxHRController";
                                    logapiO.ActionMethodName =
                                        "إعتماد طلب تدريب التعاوني";
                                    logapiO.ActionMethodType = 2;
                                    if (jsonDecode(
                                            respose.body)["StatusCode"] !=
                                        400) {
                                      logapiO.StatusCode = 0;
                                      logapiO.ErrorMessage = jsonDecode(
                                          respose.body)["ErrorMessage"];
                                      logApi(logapiO);
                                      Alerts.errorAlert(
                                              context,
                                              "خطأ",
                                              jsonDecode(
                                                  respose.body)["ErrorMessage"])
                                          .show();
                                      return;
                                    } else {
                                      logapiO.StatusCode = 1;

                                      logApi(logapiO);
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
                                logApiModel logapiO = logApiModel();
                                logapiO.ControllerName = "InboxHRController";
                                logapiO.ClassName = "InboxHRController";
                                logapiO.ActionMethodName =
                                    "رفض طلب تدريب التعاوني";
                                logapiO.ActionMethodType = 2;
                                if (_formKey.currentState!.validate()) {
                                  Alerts.confirmAlrt(context, "",
                                          "هل تريد رفض الطلب", "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );

                                      var respose = await postAction(
                                          "Inbox/ApproveTraining",
                                          jsonEncode({
                                            "RequestNumber":
                                                CooperativeTrainingRequestsInfo[
                                                    "RequestID"],
                                            "StatusID": 2,
                                            "SignedBy": int.parse(sharedPref
                                                .getDouble("EmployeeNumber")
                                                .toString()
                                                .split(".")[0]),
                                            "Notes": _notes.text
                                          }));
                                      EasyLoading.dismiss();
                                      if (jsonDecode(
                                              respose.body)["StatusCode"] !=
                                          400) {
                                        logapiO.StatusCode = 0;
                                        logapiO.ErrorMessage = jsonDecode(
                                            respose.body)["ErrorMessage"];
                                        logApi(logapiO);
                                        Alerts.errorAlert(
                                                context,
                                                "خطأ",
                                                jsonDecode(respose.body)[
                                                    "ErrorMessage"])
                                            .show();
                                        return;
                                      } else {
                                        logapiO.StatusCode = 1;

                                        logApi(logapiO);
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
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
