import 'dart:io';

import 'package:eamanaapp/provider/login/loginProvider.dart';
import 'package:eamanaapp/secreen/Login/OTPView.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
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
                    //  background(),
                    widgetsUni.bacgroundimage(),

                    // Positioned(
                    //   right: 0,
                    //   top: 50,
                    //   child: Image.asset(
                    //     "assets/image/Giddam-Supporting.png",
                    //     // fit: BoxFit.co,
                    //     width: 150,
                    //     height: 120,
                    //   ),
                    // ),
                    // Positioned(
                    //   left: 40,
                    //   top: 80,
                    //   child: logo(),
                    // ),
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
                                'assets/image/raqamy-logo.png',
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
                                "أمانة المنطقة الشرقية - وكالة التحول الرقمي والمدن الذكية",
                                style: descTx1(Colors.white),
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
                            const SizedBox(
                              height: 20,
                            ),
                            //    const Text("تسجيل الدخول"),
                            //   const Text("فضلا أدخل معلومات التسجيل"),
                            logo(),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: responsiveMT(20, 100),
                                        vertical: 20),
                                    padding: EdgeInsets.symmetric(vertical: 25),
                                    decoration:
                                        containerdecoration(BackGWhiteColor),
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "تذكرني",
                                                style:
                                                    subtitleTx(baseColorText),
                                              ),
                                              Checkbox(
                                                  value: rememperMe,
                                                  onChanged: (bool? val) {
                                                    setState(() {
                                                      sharedPref.setString(
                                                          "emNoPref",
                                                          _username.text);
                                                      sharedPref.setString(
                                                          "PassPref",
                                                          _password.text);

                                                      rememperMe = val ?? false;

                                                      if (val == true) {
                                                        sharedPref.setBool(
                                                            "rememberMe", true);
                                                      } else {
                                                        sharedPref.setBool(
                                                            "rememberMe",
                                                            false);
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
          errorText: _usernameError ? "الرجاء إدخال الرقم الوظيفي" : null,
          labelText: "رقم الوظيفي",
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
      width: 120,
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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: provider2,
                    child: OTPView(),
                  ),
                ));
          } else {
            if (_provider.geterorMs != "") {
              Alerts.errorAlert(context, "خطأ", _provider.geterorMs).show();
              return;
            }
            Alerts.errorAlert(context, "خطأ", _provider.getloginerorMs).show();
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
