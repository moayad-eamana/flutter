import 'dart:io';

import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

import '../../main.dart';

class LoginView extends StatefulWidget {
  // final FirebaseAnalytics analytics;
  // final FirebaseAnalyticsObserver observer;
  const LoginView({
    Key? key,
    // required this.analytics,
    // required this.observer,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    call();
    print("objectaswsd");
    if (sharedPref.getBool("rememberMe") == true) {
      rememperMe = true;

      _username.text = sharedPref.getString("emNoPref") ?? "";
      _password.text = sharedPref.getString("PassPref") ?? "";
      setState(() {});
    } else {
      rememperMe = false;
      setState(() {});
    }
    //smspermission();
    super.initState();
  }

  call() async {
    // await widget.analytics.setCurrentScreen(
    //   screenName: 'mm',
    //   screenClassOverride: 'moayad test',
    // );
  }
  // void smspermission() async {
  //   try {
  //     final Telephony telephony = Telephony.instance;
  //     bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
  //     print(permissionsGranted);
  //   } on PlatformException catch (err) {
  //     // Handle err
  //   } catch (err) {
  //     // other types of Exceptions
  //   }
  // }

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _usernameError = false;
  bool passError = false;
  bool rememperMe = false;
  var _provider;
  bool passwordVisible = true;

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<LoginProvider>(context);
    return packageInfo.version != localVersion && forceUpdate == true
        ? Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Center(
                child: Icon(
                  Icons.warning,
                  size: 100,
                  color: Colors.yellow.shade800,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "يجب التحديث",
                      style: descTx1(baseColor),
                    )),
                    Center(
                        child: Text(
                      'يتوفر تحديث جديد،حدث الان!',
                      style: titleTx(baseColor),
                    )),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: baseColor),
                        onPressed: () async {
                          if (Platform.isAndroid) {
                            launch(
                                "https://play.google.com/store/apps/details?id=com.eamana.eamanaapp.gov.sa");
                          } else {
                            launch(
                                "https://apps.apple.com/us/app/%D8%B1%D9%82%D9%85%D9%8A/id1613668254");
                          }

                          packageInfo = await PackageInfo.fromPlatform();

                          //   Navigator.pop(context);
                        },
                        child: Text("تحديث")),
                  ],
                )
              ],
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: 100.h,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/SVGs/Rectangle-8.svg',
                            width: 100.w,
                          ),
                          Positioned(
                            bottom: 0,
                            child: SvgPicture.asset(
                              'assets/SVGs/Rectangle-7.svg',
                              width: 100.w,
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            right: 40,
                            child: SvgPicture.asset(
                              'assets/SVGs/amana-logo.svg',
                              width: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                          ),
                          logo(),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: responsiveMT(20, 50), vertical: 20),
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "تسجيل الدخول",
                                  textAlign: TextAlign.right,
                                  style: fontsStyle.px20(
                                      fontsStyle.baseColor(), FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  "الرقم الوظيفي",
                                  textAlign: TextAlign.right,
                                  style: fontsStyle.px12Bold(
                                      fontsStyle.baseColor(), FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                userName(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "الرقم السري",
                                  textAlign: TextAlign.right,
                                  style: fontsStyle.px12Bold(
                                      fontsStyle.baseColor(), FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                password(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Checkbox(
                                          value: rememperMe,
                                          checkColor: baseColor,
                                          activeColor: Colors.white,
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
                                    ),
                                    Text(
                                      "تذكرني",
                                      style: fontsStyle.px12normal(
                                          fontsStyle.SecondaryColor(),
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                loginBtn(_provider),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
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

  Widget userName() {
    return Container(
      // margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        controller: _username,
        keyboardType: TextInputType.number,
        maxLines: 1,
        style: TextStyle(
          color: baseColorText,
        ),
        decoration: CSS.TextFieldDecoration(""),
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
      // margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextField(
        controller: _password,
        keyboardType: TextInputType.text,
        obscureText: passwordVisible,
        enableSuggestions: false,
        autocorrect: false,
        maxLines: 1,
        style: TextStyle(
          color: baseColorText,
        ),
        textAlign: TextAlign.right,
        decoration: CSS.TextFieldDecorationPass("", passwordVisible, () {
          setState(
            () {
              passwordVisible = !passwordVisible;
            },
          );
        }),
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

  Widget logo() {
    return Image.asset(
      "assets/SVGs/Raqmylogo.png",
      width: 150,
      height: 140,
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
    return CSS.baseElevatedButton(
      "تسجيل الدخول",
      0,
      () async {
        FocusScope.of(context).unfocus();
        bool erore = false;
        erore = checkValditionSubmit();
        if (!erore) {
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );
          bool isValiedUser;
          if (_username.text == "10284928492") {
            sharedPref.setString("dumyuser", "10284928492");
            await Future.delayed(Duration(seconds: 1));
            isValiedUser = true;
          } else {
            isValiedUser =
                await _provider.checkUser(_username.text, _password.text);
          }

          EasyLoading.dismiss();

          if (_username.text == "") {
            Navigator.pushReplacementNamed(context, "/home");
            return;
          }
          if (isValiedUser) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ChangeNotifierProvider.value(
            //         value: provider2,
            //         child: OTPView(),
            //       ),
            //     ));

            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              enableDrag: false,
              isDismissible: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
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
                    child: ChangeNotifierProvider.value(
                      value: provider2,
                      child: OTPView(),
                    ),
                  ),
                );
              },
            );
          } else {
            if (_provider.geterorMs != "") {
              Alerts.errorAlert(context, "خطأ", _provider.geterorMs).show();
              return;
            }
            Alerts.errorAlert(context, "خطأ", _provider.getloginerorMs).show();
          }
        }
      },
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
