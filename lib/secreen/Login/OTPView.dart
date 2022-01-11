import 'package:eamanaapp/provider/loginProvider.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController _otp = TextEditingController();
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
                  const Text("تسجيل الدخول"),
                  const Text("فضلا أدخل الرمز المرسل على الجوال"),
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
                          children: [smsTxt(), submitBtn()],
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
    return SvgPicture.asset(
      'assets/SVGs/background.svg',
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      //  height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
    );
  }

  Widget logo() {
    return SvgPicture.asset(
      'assets/SVGs/brand-logo.svg',
      alignment: Alignment.center,
    );
  }

  Widget banalPag() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: secondryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: Border.all(color: Colors.white)),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget smsTxt() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 100, right: 100),
      child: TextField(
        controller: _otp,
        keyboardType: TextInputType.text,
        maxLines: 1,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          labelText: "أدخل كلمة السر المؤقتة",
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget submitBtn() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: () async {
          EasyLoading.show(
            status: 'جاري المعالجة...',
            maskType: EasyLoadingMaskType.black,
          );
          bool isValid =
              await Provider.of<LoginProvider>(context, listen: false)
                  .checkUserOTP(_otp.text);
          EasyLoading.dismiss();
          if (isValid) {
            Navigator.pushReplacementNamed(context, "/tab");
          } else {
            Alert(
              context: context,
              type: AlertType.error,
              title: "خطأ",
              desc: "خطأ في الرمز",
              buttons: [
                DialogButton(
                  child: const Text(
                    "حسنا",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          }
        },
        child: const Text('إستمرار'),
      ),
    );
  }
}
