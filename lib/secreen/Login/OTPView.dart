import 'dart:async';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController _otp = TextEditingController();
  dynamic isValid;
  bool oncomplated = false;

  @override
  void initState() {
    // SmsListener();
    // TODO: implement initState
    print(c.count);
    c.otp.text = c.count == "" ? "" : c.count.toString();
    setState(() {});
    startTimer();
    super.initState();
  }

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 5);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  bool errorM = false;

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    var _provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          child: Stack(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
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
                        // SizedBox(
                        //   height: 80,
                        // ),
                        // logo(),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "رمز التحقق",
                                style: fontsStyle.px20(
                                    fontsStyle.baseColor(), FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "فضلا أدخل الرمز المرسل على الجوال",
                                style: fontsStyle.px14(
                                    fontsStyle.SecondaryColor(),
                                    FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '$minutes:$seconds',
                                style: fontsStyle.px16(
                                    secondryColor, FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              otpTxt(),
                              SizedBox(
                                height: 30,
                              ),
                              submitBtn(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget background() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Image.asset(
        imageBG,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget logo() {
    return Image.asset(
      "assets/image/raqmy-icon.png",
      width: 200,
    );
  }

  Widget banalPag() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: containerdecoration(BackGWhiteColor),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget otpTxt() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          PinCodeTextField(
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
            // validator: (v) {
            //   if (v.toString().length >= 6) {
            //     oncomplated = true;
            //   } else {
            //     oncomplated = false;
            //   }
            // },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(6.7),
              fieldHeight: 50,
              fieldWidth: 50,
              activeColor: errorM == false ? secondryColor : redColor,
              inactiveColor: bordercolor,
              selectedColor: secondryColor,
            ),
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            textStyle: TextStyle(fontSize: 20, height: 1.6),
            // backgroundColor: BackGWhiteColor,
            // errorAnimationController: errorController,
            controller: _otp,
            keyboardType: TextInputType.number,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(" wwww =  $value");
              //for test length = 4
              if (value.length >= 4) {
                oncomplated = true;
              } else {
                oncomplated = false;
              }
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
          errorM == false
              ? Container()
              : Text(
                  isValid ?? "الرجاء إدخال الرمز",
                  style: descTx2(redColor),
                ),
        ],
      ),
    );
  }

  Widget submitBtn() {
    return CSS.baseElevatedButton(
        "تحقق",
        0,
        oncomplated == true
            ? () async {
                if (_otp.text == "") {
                  setState(() {
                    errorM = true;
                  });
                } else {
                  setState(() {
                    errorM = false;
                  });
                  EasyLoading.show(
                    status: '... جاري المعالجة',
                    maskType: EasyLoadingMaskType.black,
                  );

                  if (sharedPref.getString("dumyuser") == "10284928492") {
                    await Future.delayed(Duration(seconds: 1));
                    Provider.of<LoginProvider>(context, listen: false)
                        .checkUserOTP2(_otp.text);
                    isValid = true;
                  } else {
                    isValid =
                        await Provider.of<LoginProvider>(context, listen: false)
                            .checkUserOTP(_otp.text);
                  }

                  EasyLoading.dismiss();
                  if (isValid is bool) {
                    //here to make initialRoute is /home
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     '/home', (Route<dynamic> route) => false);
                    Navigator.pushReplacementNamed(context, "/home");
                  } else {
                    setState(() {
                      errorM = true;
                    });
                    // Alerts.errorAlert(context, "خطأ", isValid).show();
                  }
                }
              }
            : null);
  }
}
