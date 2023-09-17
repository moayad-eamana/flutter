import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/CSS.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../main.dart';

class changePassword extends StatefulWidget {
  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("تغير كلمة المرور", context, null),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "أدخل كلمة المرور الحالية",
                      style: fontsStyle.px14(baseColorText, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: currentpassword,
                      decoration:
                          CSS.TextFieldDecoration("كلمة المرور الحالية"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب إدخال كلمة المرور الحالية";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "أدخل كلمة المرور الجديدة",
                      style: fontsStyle.px14(baseColorText, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: newpassword,
                      decoration:
                          CSS.TextFieldDecoration("كلمة المرور الجديدة"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب إدخال كلمة المرور الجديدة";
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        child: CSS.baseElevatedButton("تغير كلمة المرور", 200,
                            () async {
                          Get.back();
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          Alerts.confirmAlrt(context, "", "هل أنت متأكد", "نعم")
                              .show()
                              .then((value) async {
                            if (value == true) {
                              EasyLoading.show(
                                status: '... جاري المعالجة',
                                maskType: EasyLoadingMaskType.black,
                              );
                              dynamic response = await postAction(
                                  "HR/UserChangePassword",
                                  jsonEncode({
                                    "UserName": sharedPref.getString("Email"),
                                    "CurrentPassword": currentpassword.text,
                                    "NewPassword": newpassword.text,
                                    "EmployeeNumber":
                                        EmployeeProfile.getEmployeeNumber()
                                  }));

                              if (jsonDecode(response.body)["StatusCode"] ==
                                  400) {
                                Alerts.errorAlert(
                                        context, "", "تم تغير كلمة المرور")
                                    .show()
                                    .then((value) {
                                  Get.back();
                                });
                              } else {
                                Alerts.errorAlert(
                                        context,
                                        "خطأ",
                                        jsonDecode(
                                            response.body)["ErrorMessage"])
                                    .show()
                                    .then((value) {});
                              }

                              EasyLoading.dismiss();
                            }
                          });
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
