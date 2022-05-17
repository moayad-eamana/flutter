import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _usernameError = false;
  bool passError = false;
  bool rememperMe = false;
  var _provider;
  void initState() {
    if (sharedPref.getBool("rememberMe") == true) {
      rememperMe = true;

      _username.text = sharedPref.getString("emNoPref") ?? "";
      _password.text = sharedPref.getString("PassPref") ?? "";
      setState(() {});
    } else {
      rememperMe = false;
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          child: Stack(
            children: [
              background(),
              Positioned(
                bottom: 0,
                child: Row(
                  //  mainAxisAlignment: Ma,
                  children: [
                    Container(
                      width: 40.w,
                      height: 65,
                      child: Container(
                        //  height: 50,
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/image/rakamy-logo-2.png',
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width,
                          //height: MediaQuery.of(context).size.height,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: 60.w,
                      height: 65,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          "أمانة المنطقة الشرقية - إدارة تقنية المعلومات",
                          style: descTx1(baseColorText),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: baseColor,
                      ),
                    ),
                  ],
                ),
              ),
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
                      //    const Text("تسجيل الدخول"),
                      //   const Text("فضلا أدخل معلومات التسجيل"),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              padding: EdgeInsets.symmetric(vertical: 25),
                              decoration: containerdecoration(BackGWhiteColor),
                              child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "أھلا بك في رقمي جوال\n من فضلك نحتاج معلومات الدخول",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: titleTx(baseColor),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  userName(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  password(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      children: [
                                        Text(
                                          "تذكرني",
                                          style: subtitleTx(baseColorText),
                                        ),
                                        Checkbox(
                                            value: rememperMe,
                                            onChanged: (bool? val) {
                                              setState(() {
                                                sharedPref.setString(
                                                    "emNoPref", _username.text);
                                                sharedPref.setString(
                                                    "PassPref", _password.text);

                                                rememperMe = val ?? false;

                                                if (val == true) {
                                                  sharedPref.setBool(
                                                      "rememberMe", true);
                                                } else {
                                                  sharedPref.setBool(
                                                      "rememberMe", false);
                                                }
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Text(
                                      //   "تغير كلمة المرور",
                                      //   style: subtitleTx(baseColor),
                                      // ),
                                      loginBtn(_provider),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
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

  Widget userName() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        controller: _username,
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: TextStyle(
          color: baseColorText,
        ),
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
          // filled: true,
          // fillColor: Colors.white,
          errorText: _usernameError ? "الرجاء إدخال الرقم الوضيفي" : null,
          labelText: "رقم الوضيفي",
          // labelStyle: TextStyle(color: lableTextcolor),
          alignLabelWithHint: true,
        ),
        onChanged: (String val) {
          sharedPref.setString("emNoPref", _username.text);

          setState(() {
            if (val.isEmpty) {
              _usernameError = true;
            } else {
              _usernameError = false;
            }
          });
        },
      ),
    );
  }

  Widget password() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        controller: _password,
        keyboardType: TextInputType.text,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
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
          // filled: true,
          // fillColor: Colors.white,
          labelText: "الرقم السري",
          // labelStyle: TextStyle(color: lableTextcolor),
          errorText: (passError ? "الرجاء إدخال الرقم السري" : null),
        ),
        onChanged: (String val) {
          sharedPref.setString("PassPref", _password.text);
          setState(() {
            if (val.isEmpty) {
              passError = true;
            } else {
              passError = false;
            }
          });
        },
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

  Widget bagPanel() {
    return Center(
      child: Container(
        height: 500,
        decoration: containerdecoration(Colors.white),
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget loginBtn(_provider) {
    var provider2 = Provider.of<LoginProvider>(context, listen: false);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: baseColor, // background
          onPrimary: Colors.white, // foreground
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8)),
      onPressed: () async {
        bool erore = false;
        erore = checkValditionSubmit();
        if (!erore) {
          EasyLoading.show(
            status: 'جاري المعالجة...',
            maskType: EasyLoadingMaskType.black,
          );

          bool isValiedUser =
              await _provider.checkUser(_username.text, _password.text);
          EasyLoading.dismiss();

          if (_username.text == "") {
            Navigator.pushReplacementNamed(context, "/home");
            return;
          }
          if (isValiedUser) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: provider2,
                    child: OTPView(),
                  ),
                ));
          } else {
            Alerts.errorAlert(
                    context, "خطأ", "خطأ في كلمة المرور أو إسم المستخدم")
                .show();
          }
        }
      },
      child: const Text('دخول'),
    );
  }

  bool checkValditionSubmit() {
    bool erore = false;
    if (_password.text.isEmpty) {
      setState(() {
        passError = true;
        erore = true;
      });
    }
    if (_username.text.isEmpty) {
      setState(() {
        _usernameError = true;
        erore = true;
      });
    }
    if (_password.text.isNotEmpty) {
      setState(() {
        passError = false;
      });
    }
    if (_username.text.isNotEmpty) {
      setState(() {
        _usernameError = false;
      });
    }
    return erore;
  }
}
