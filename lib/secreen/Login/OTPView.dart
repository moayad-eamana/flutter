import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController _otp = TextEditingController();

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
      body: Stack(
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
    );
  }

  Widget background() {
    return Image.asset(
      imageBG,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
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
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
              status: 'جاري المعالجة...',
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
