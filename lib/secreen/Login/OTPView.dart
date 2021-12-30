import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OTPView extends StatefulWidget {
  const OTPView({Key? key}) : super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("دخول"),
          ],
        ),
      ),
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
      child: SvgPicture.asset(
        'assets/SVGs/panel-bg.svg',
        alignment: Alignment.center,
        //  width: MediaQuery.of(context).size.width,
        //  height: MediaQuery.of(context).size.height,
        height: 250,
        //fit: BoxFit.,
      ),
    );
  }

  Widget smsTxt() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 100, right: 100),
      child: const TextField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
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
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/tab");
        },
        child: const Text('إستمرار'),
      ),
    );
  }
}
