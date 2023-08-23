import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class forgetPassword extends StatefulWidget {
  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  TextEditingController _EmpNo = TextEditingController();
  TextEditingController _newpass = TextEditingController();

  TextEditingController _otp = TextEditingController();
  bool isValidOtp = false;
  bool errorM = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("نسيت كلمة المرور ", context, null),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              Container(
                margin: EdgeInsets.all(40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _EmpNo,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        counterStyle: TextStyle(color: baseColorText),
                        labelText: "الرقم الوظيفي",
                        labelStyle: TextStyle(color: secondryColorText),
                        errorStyle: TextStyle(color: redColor),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: responsiveMT(8, 30), horizontal: 10.0),
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
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: bordercolor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isValidOtp
                        ? TextFormField(
                            controller: _newpass,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              counterStyle: TextStyle(color: baseColorText),
                              labelText: "كلمة المرور الجديدة",
                              labelStyle: TextStyle(color: secondryColorText),
                              errorStyle: TextStyle(color: redColor),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: responsiveMT(8, 30),
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
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: bordercolor.withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 160,
                      child: widgetsUni.actionbutton(
                          isValidOtp == false ? "إرسال" : "تغيير كلمة المرور",
                          Icons.send, () async {
                        EasyLoading.show(
                          status: '... جاري المعالجة',
                          maskType: EasyLoadingMaskType.black,
                        );
                        if (isValidOtp) {
                          dynamic response = await postAction(
                              "HR/ResetPassword",
                              jsonEncode({
                                "EmployeeNumber": _EmpNo.text,
                                "RequestID": sharedPref.getInt("RequestID"),
                                "NewPassword": _newpass.text
                              }));
                          EasyLoading.dismiss();
                          if (jsonDecode(response.body)["StatusCode"] == 400) {
                            Alerts.successAlert(
                                    context, "", "تم تغير كلمة المرور")
                                .show()
                                .then((value) {
                              Get.back();
                            });
                          } else {
                            isValidOtp = false;
                            setState(() {});
                            Alerts.errorAlert(
                                    context,
                                    "خطأ",
                                    jsonDecode(response.body)["ErrorMessage"]
                                        .toString())
                                .show();
                          }
                        } else {
                          dynamic respose = await Dio().post(
                              Url + "Authentication/ForgotPassowrdOtpRequest",
                              data: jsonEncode({
                                "EmployeeNumber": _EmpNo.text,
                                "ModuleID": 4
                              }),
                              options: Options(headers: {
                                "Content-Type": "application/json"
                              }));
                          EasyLoading.dismiss();

                          if (respose.data["StatusCode"] == 400) {
                            sharedPref.setString(
                                "PrivateToken", respose.data["PrivateToken"]);
                            sharedPref.setInt(
                                "RequestID", respose.data["RequestID"]);
                            showbotomsheet(_EmpNo.text);
                          }
                        }
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showbotomsheet(String empNo) {
    TextEditingController _otp1 = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      builder: (BuildContext context) {
        return Container(
          height: 70.h,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: bordercolor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            margin: EdgeInsets.all(30),
                            child: PinCodeTextField(
                              appContext: context,
                              autoFocus: true,
                              pastedTextStyle: TextStyle(
                                color: secondryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: false,
                              obscuringCharacter: '*',
                              animationType: AnimationType.fade,

                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(6.7),
                                fieldHeight: 50,
                                fieldWidth: 50,
                                activeColor:
                                    errorM == false ? secondryColor : redColor,
                                inactiveColor: bordercolor,
                                selectedColor: secondryColor,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(fontSize: 20, height: 1.6),
                              // backgroundColor: BackGWhiteColor,
                              // errorAnimationController: errorController,
                              controller: _otp1,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                setState(() {
                                  errorM = false;
                                });
                              },

                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),

                          Container(
                            width: 120,
                            child: widgetsUni.actionbutton("تحقق", Icons.send,
                                () async {
                              EasyLoading.show(
                                status: '... جاري المعالجة',
                                maskType: EasyLoadingMaskType.black,
                              );
                              dynamic respose = await http.post(
                                  Uri.parse(
                                    Url + "Authentication/IsValidOTP",
                                  ),
                                  body: jsonEncode({
                                    "EmployeeNumber": int.parse(empNo),
                                    "PrivateToken":
                                        sharedPref.getString("PrivateToken"),
                                    "UserName": "DevTeam",
                                    "Password": "DevTeam",
                                    "OTP": int.parse(_otp1.text),

                                    // "DeviceKey": udid
                                  }),
                                  headers: {
                                    "Content-Type": "application/json"
                                  });
                              EasyLoading.dismiss();
                              if (jsonDecode(respose.body)["StatusCode"] ==
                                  400) {
                                sharedPref.setString("AccessToken",
                                    jsonDecode(respose.body)["AccessToken"]);

                                isValidOtp = true;
                                setState(() {});
                                Navigator.pop(context);
                              } else {
                                Alerts.errorAlert(
                                        context,
                                        "خطأ",
                                        jsonDecode(respose.body)["ErrorMessage"]
                                            .toString())
                                    .show();
                              }
                            }),
                          )
                          // errorM == false
                          //     ? Container()
                          //     : Text(
                          //         isValid ?? "الرجاء إدخال الرمز",
                          //         style: descTx2(redColor),
                          //       ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
