import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class GetPromotionRequest extends StatefulWidget {
  @override
  State<GetPromotionRequest> createState() => _GetPromotionRequestState();
}

class _GetPromotionRequestState extends State<GetPromotionRequest> {
  int? text;
  bool isChecked1 = false;
  bool isChecked2 = false;

  var PromotionReques;
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await getAction("Inbox/GetPromotionRequest/" +
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
    print(PromotionReques);
    PromotionReques = jsonDecode(response.body)["PromotionInfo"];
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBarW.appBarW("إقرار ترقية", context, null),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  widgetsUni.bacgroundimage(),
                  PromotionReques["PromotionInfo"] == null
                      ? Center(
                          child: Text(
                            "تم إعتماد الطلب",
                            style: titleTx(baseColorText),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: PromotionReques == null
                                ? []
                                : [
                                    CaedW("المرتبة الجديدة",
                                        PromotionReques["NewClass"].toString()),
                                    CaedW(
                                        "الوظيفة المرقى إليها",
                                        PromotionReques["NewJobName"]
                                            .toString()),
                                    CaedW(
                                        "الإدارة المرقى إليها",
                                        PromotionReques["NewDepartmentName"]
                                            .toString()),
                                    PromotionReques[
                                                "CurrentGeneralDepartmentNumber"] !=
                                            PromotionReques[
                                                "NewGeneralDepartmentNumber"]
                                        ? Container(
                                            height: 130,
                                            width: 100.w,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Card(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        value: isChecked1,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isChecked1 = value!;
                                                            isChecked2 = false;
                                                            text = 2;
                                                            setState(() {});
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                        "النقل إلى الإدارة المرقى إليها",
                                                        style: subtitleTx(
                                                            baseColorText),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        value: isChecked2,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isChecked2 = value!;
                                                            isChecked1 = false;
                                                            text = 1;
                                                            setState(() {});
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                        "البقاء في الإدارة الحالية",
                                                        style: subtitleTx(
                                                            baseColorText),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 120,
                                      child: widgetsUni.actionbutton(
                                          "إعتماد", Icons.send, () async {
                                        if (PromotionReques[
                                                "CurrentGeneralDepartmentNumber"] ==
                                            PromotionReques[
                                                "NewGeneralDepartmentNumber"]) {
                                          text = 0;
                                        }

                                        if (PromotionReques[
                                                "CurrentGeneralDepartmentNumber"] !=
                                            PromotionReques[
                                                "NewGeneralDepartmentNumber"]) {
                                          if (text == null) {
                                            Alerts.errorAlert(context, "خطأ",
                                                    "يجب إختيار إحدى الخيارين البقاء أو النقل")
                                                .show();
                                            return;
                                          }
                                        }
                                        Alerts.confirmAlrt(
                                                context,
                                                "",
                                                "هل أنت متأكد من الإقرار",
                                                "نعم")
                                            .show()
                                            .then((value) async {
                                          if (value == true) {
                                            print({
                                              "EmployeeNumber": PromotionReques[
                                                  "EmployeeNumber"],
                                              "ApprovedBy": int.parse(sharedPref
                                                  .getDouble("EmployeeNumber")
                                                  .toString()
                                                  .split(".")[0]),
                                              "Text": text.toString()
                                            });
                                            EasyLoading.show(
                                              status: '... جاري المعالجة',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );
                                            var response = await postAction(
                                                "Inbox/ApprovePromotion",
                                                jsonEncode({
                                                  "EmployeeNumber":
                                                      PromotionReques[
                                                          "EmployeeNumber"],
                                                  "ApprovedBy": int.parse(
                                                      sharedPref
                                                          .getDouble(
                                                              "EmployeeNumber")
                                                          .toString()
                                                          .split(".")[0]),
                                                  "Text": text.toString()
                                                }));
                                            EasyLoading.dismiss();
                                            if (jsonDecode(response.body)[
                                                    "IsUpdated"] ==
                                                true) {
                                              Alerts.successAlert(context, "",
                                                      "تم الإعتماد بنجاح")
                                                  .show()
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              Alerts.errorAlert(
                                                      context,
                                                      "خطأ",
                                                      jsonDecode(response.body)[
                                                          "ErrorMessage"])
                                                  .show();
                                            }
                                          }
                                        });
                                      }),
                                    )
                                  ],
                          ),
                        )
                ],
              ),
            )));
  }

  CaedW(String Title, String desc) {
    return Container(
      width: 100.w,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 10),
      //   margin: EdgeInsets.all(10),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: PromotionReques == null
              ? []
              : [
                  Text(
                    Title,
                    style: titleTx(secondryColorText),
                  ),
                  Text(
                    desc,
                    style: subtitleTx(baseColorText),
                  )
                ],
        ),
      ),
    );
  }
}
