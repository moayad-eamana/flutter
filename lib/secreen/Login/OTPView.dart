import 'dart:io';

import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController _otp = TextEditingController();
  // final Telephony telephony = Telephony.instance;

  // Future<void> SmsListener() async {
  //   print("platform" + Platform.isAndroid.toString());
  //   if (Platform.isAndroid) {
  //     telephony.listenIncomingSms(
  //         onNewMessage: (SmsMessage message) {
  //           // Handle message
  //           if (message.body != null) {
  //             print(message.body.toString());
  //             setState(() {
  //               _otp.text = message.body.toString().substring(37, 41);
  //             });
  //           }
  //         },
  //         listenInBackground: false

  //         // onBackgroundMessage: backgroundMessageHandler
  //         );
  //   }
  // }

  @override
  void initState() {
    // SmsListener();
    // TODO: implement initState
    super.initState();
  }

  bool errorM = false;
  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          child: Stack(
            children: [
              background(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      logo(),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        child: Stack(
                          children: [
                            banalPag(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("تسجيل الدخول",
                                    style: titleTx(secondryColorText)),
                                Text("فضلا أدخل الرمز المرسل على الجوال",
                                    style: titleTx(secondryColorText)),
                                SizedBox(
                                  height: 10,
                                ),
                                smsTxt(),
                                submitBtn()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
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
      "assets/image/rakamy-logo-21.png",
      width: 150,
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

  Widget smsTxt() {
    return Container(
      margin: const EdgeInsets.only(left: 100, right: 100),
      child: Column(
        children: [
          TextField(
            controller: _otp,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            maxLines: 1,
            style: TextStyle(
              color: baseColorText,
            ),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
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
              labelText: "الرمز المؤقت",
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          errorM == false
              ? Container()
              : Text(
                  "فضلا ادخل الرمز المؤقت",
                  style: TextStyle(
                    fontSize: 10,
                    color: redColor,
                  ),
                )
        ],
      ),
    );
  }

  Widget submitBtn() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: baseColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () async {
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
            dynamic isValid =
                await Provider.of<LoginProvider>(context, listen: false)
                    .checkUserOTP(_otp.text);
            EasyLoading.dismiss();
            if (isValid is bool) {
              //here to make initialRoute is /home
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/home', (Route<dynamic> route) => false);
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              Alerts.errorAlert(context, "خطأ", isValid).show();
            }
          }
        },
        child: const Text('إستمرار'),
      ),
    );
  }
}
