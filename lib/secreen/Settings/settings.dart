import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  final Function? update;
  Settings(this.update);
  @override
  State<Settings> createState() => _SettingsState();
}

bool fingerprint = false;
bool darkmode = false;
bool blindness = false;

class _SettingsState extends State<Settings> {
  //
  void getSettings() async {
    final settingSP = await SharedPreferences.getInstance();
    fingerprint = settingSP.getBool("fingerprint") ?? false;
    blindness = settingSP.getBool('blindness') ?? false;
    darkmode = settingSP.getBool("darkmode") ?? false;
    setState(() {});
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  bool? _authenticated;

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _authenticated = authenticated;
      });
    } on PlatformException catch (e) {
      setState(() {
        _authenticated = authenticated;
      });
      print(e);
      return;
    }
    if (!mounted) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // backgroundColor: BackGColor,
          appBar: AppBarHome.appBarW("الاعدادات", context),
          body: Stack(
            children: [
              Image.asset(
                imageBG,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Container(
                  //color: Colors.amber,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "إعدادات الحساب",
                        style: titleTx(baseColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 150,
                          //margin: EdgeInsets.all(20),
                          decoration: containerdecoration(BackGWhiteColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // InkWell(
                                //   onTap: () {},
                                //   child: Text("تغيير كلمة المرور",
                                //       style: descTx1(baseColorText)),
                                // ),
                                Row(
                                  children: [
                                    Text("الدخول عن طريق البصمة",
                                        style: descTx1(baseColorText)),
                                    Spacer(),
                                    Switch(
                                        activeColor: baseColor,
                                        value: fingerprint,
                                        onChanged: (bool newValue) async {
                                          EasyLoading.show(
                                            status: 'جاري المعالجة...',
                                            maskType: EasyLoadingMaskType.black,
                                          );

                                          if (fingerprint == false) {
                                            await _checkBiometrics();

                                            if (_canCheckBiometrics == true) {
                                              await _authenticate();
                                            } else {
                                              setState(() {
                                                _authenticated = false;
                                              });
                                              Alerts.warningAlert(
                                                      context,
                                                      "تنبيه",
                                                      "لا يمكن تفعيل البصمة, لعدم توفره بالجهاز")
                                                  .show();
                                            }

                                            if (_authenticated == true) {
                                              final fingerprintSP =
                                                  await SharedPreferences
                                                      .getInstance();
                                              fingerprintSP.setBool(
                                                  "fingerprint", newValue);
                                              setState(() {
                                                fingerprint = fingerprintSP
                                                    .getBool('fingerprint')!;
                                              });
                                              print("fingerprint = " +
                                                  fingerprint.toString());
                                            } else {
                                              //if canceleds
                                            }
                                          } else {
                                            final fingerprintSP =
                                                await SharedPreferences
                                                    .getInstance();
                                            fingerprintSP.setBool(
                                                "fingerprint", newValue);
                                            setState(() {
                                              fingerprint = fingerprintSP
                                                  .getBool('fingerprint')!;
                                            });
                                            print("fingerprint = " +
                                                fingerprint.toString());
                                          }
                                          EasyLoading.dismiss();
                                        }

                                        //   final fingerprintSP =
                                        //       await SharedPreferences.getInstance();
                                        //   fingerprintSP.setBool(
                                        //       "fingerprint", newValue);
                                        //   setState(() {
                                        //     fingerprint =
                                        //         fingerprintSP.getBool('fingerprint')!;
                                        //   });
                                        //   print("fingerprint = " +
                                        //       fingerprint.toString());
                                        // },
                                        ),
                                  ],
                                ),
                                Divider(
                                  color: bordercolor,
                                ),
                                Center(
                                  child: Container(
                                    height: 50,
                                    // width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        side: BorderSide(
                                          width: 0.5,
                                          color: bordercolor,
                                        ),
                                        elevation: 0,
                                        primary: baseColor,
                                      ),
                                      onPressed: () async {
                                        Alerts.confirmAlrt(
                                                context,
                                                "تسجيل خروج",
                                                "هل تريد الخروج من التطبيق",
                                                "نعم")
                                            .show()
                                            .then((value) async {
                                          if (value == true) {
                                            SharedPreferences _pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            _pref.setString(
                                                "EmployeeNumber", "");
                                            _pref.setString("hasePerm", "");
                                            hasePerm = "";
                                            //_pref.clear();
                                            //setSettings();

                                            Navigator.pushReplacementNamed(
                                                context, '/loginView');
                                          }
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.logout,
                                              color: Colors.white, size: 18),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "تسجيل خروج",
                                            style: descTx1(Colors.white),
                                            maxLines: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                    // widgetsUni.actionbutton(
                                    //   "تسجيل خروج",
                                    //   Icons.logout,
                                    //   () async {
                                    //     Alerts.confirmAlrt(context, "تسجيل خروج",
                                    //             "هل تريد الخروج من التطبيق", "نعم")
                                    //         .show()
                                    //         .then((value) async {
                                    //       if (value == true) {
                                    //         SharedPreferences _pref =
                                    //             await SharedPreferences.getInstance();
                                    //         _pref.setString("EmployeeNumber", "");

                                    //         Navigator.pushReplacementNamed(
                                    //             context, '/loginView');
                                    //       }
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "إعدادات ذوي الهمم",
                        style: titleTx(baseColor),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          //margin: EdgeInsets.all(20),
                          decoration: containerdecoration(BackGWhiteColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text("عمى الألوان",
                                        style: descTx1(baseColorText)),
                                    Spacer(),
                                    Switch(
                                      activeColor: baseColor,
                                      value: blindness,
                                      onChanged: (bool newValue) async {
                                        final blindnessSP =
                                            await SharedPreferences
                                                .getInstance();
                                        blindnessSP.setBool(
                                            "blindness", newValue);
                                        setState(() {
                                          blindness =
                                              blindnessSP.getBool('blindness')!;
                                        });
                                        print("blindness = " +
                                            blindness.toString());
                                        await getColorSettings();
                                        widget.update!();
                                      },
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: bordercolor,
                                ),
                                Row(
                                  children: [
                                    Text("النظام الليلي",
                                        style: descTx1(baseColorText)),
                                    Spacer(),
                                    Switch(
                                      activeColor: baseColor,
                                      value: darkmode,
                                      onChanged: (bool newValue) async {
                                        final darkmodeSP =
                                            await SharedPreferences
                                                .getInstance();
                                        darkmodeSP.setBool(
                                            "darkmode", newValue);
                                        setState(() {
                                          darkmode =
                                              darkmodeSP.getBool('darkmode')!;
                                        });
                                        print("darkmode = " +
                                            darkmode.toString());
                                        await getColorSettings();
                                        widget.update!();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "تواصل معنا",
                        style: titleTx(baseColor),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 190,
                          //margin: EdgeInsets.all(20),
                          decoration: containerdecoration(BackGWhiteColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.chat_bubble_outline,
                                            color: secondryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "للبلاغات 940",
                                            style: descTx1(baseColorText),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        launch("tel://940");
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.email_outlined,
                                            color: secondryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "للمساعدة : help@eamana.gov.sa",
                                            style: descTx1(baseColorText),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        launch("mailto:help@eamana.gov.sa");
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.contact_support_outlined,
                                            color: secondryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("الدعم الفني : 8046333 - 013",
                                              style: descTx1(baseColorText)),
                                        ],
                                      ),
                                      onTap: () {
                                        launch("tel://0138046333");
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.local_phone_outlined,
                                            color: secondryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "العلاقات العامة : 8046000 - 013",
                                              style: descTx1(baseColorText)),
                                        ],
                                      ),
                                      onTap: () {
                                        launch("tel://0138046000");
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.whatsapp,
                                            color: secondryColor,
                                            size: 24.0,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("واتساب : 0530245555",
                                              style: descTx1(baseColorText)),
                                        ],
                                      ),
                                      onTap: () {
                                        launch("https://wa.me/+966530245555/");
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Image(
                              //width: responsiveMT(90, 150),
                              alignment: Alignment.center,
                              width: 150,
                              color: darkmode == true ? Colors.white : null,
                              image:
                                  AssetImage("assets/image/rakamy-logo-2.png"),
                            ),
                            Text("الإصدار الأول 1.20.22",
                                style: descTx1(baseColorText)),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
