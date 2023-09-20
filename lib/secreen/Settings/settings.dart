import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/changePassword/changePaswword.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/settings_utilities/firebase_Notification.dart';
import 'package:eamanaapp/settings_utilities/setSettings.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/CSS.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class Settings extends StatefulWidget {
  final Function? update;
  Settings(this.update);
  @override
  State<Settings> createState() => _SettingsState();
}

bool fingerprint = false;
bool darkmode = false;
bool blindness = false;
bool updatenotification = true;
bool test_offers = true;

class _SettingsState extends State<Settings> {
  //
  void getSettings() {
    //final settingSP = await SharedPreferences.getInstance();
    fingerprint = sharedPref.getBool("fingerprint") ?? false;
    blindness = sharedPref.getBool('blindness') ?? false;
    darkmode = sharedPref.getBool("darkmode") ?? false;
    updatenotification = sharedPref.getBool("updatenotification") ?? true;
    test_offers = sharedPref.getBool("offers") ?? true;
    // setState(() {});
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
          options:
              AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
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

  void didChangeDependencies() {
    precacheImage(AssetImage("assets/image/Union_2.png"), context);
    super.didChangeDependencies();
  }

  @override
  initState() {
    print("permissin status is = $permissionStatusFuture");
    getSettings();
    // getpermissionStatusFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          // backgroundColor: BackGColor,
          // appBar: AppBarHome.appBarW("الاعدادات", context),
          body: SingleChildScrollView(
            child: Container(
              height: 100.h,
              child: Stack(
                //   alignment: AlignmentDirectional.topCenter,
                //overflow: Overflow.visible,
                children: [
                  Container(
                    height: 300,
                    width: 100.w,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.fromLTRB(108, 64, 24, 0),
                    decoration: BoxDecoration(
                      color: fontsStyle.HeaderColor(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                        Text(
                          "الإعدادات",
                          style: fontsStyle.px20(Colors.white, FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 140,
                    // right: 5,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.17),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                              color: BackGWhiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(17.2),
                              )),
                          width: 90.w,
                          // height: 220,
                          // color: Colors.amber,
                          margin: EdgeInsets.symmetric(horizontal: 18),
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // InkWell(
                                  //   onTap: () {},
                                  //   child: Text("تغيير كلمة المرور",
                                  //       style: descTx1(baseColorText)),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "إعدادات الحساب",
                                    style: titleTx(baseColor),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("الدخول عبر السمات الحيوية",
                                          style: descTx1(baseColorText)),
                                      Spacer(),
                                      CupertinoSwitch(
                                          // activeColor: baseColor,
                                          value: fingerprint,
                                          onChanged: (bool newValue) async {
                                            // EasyLoading.show(
                                            //   status: '... جاري المعالجة',
                                            //   maskType: EasyLoadingMaskType.black,
                                            // );

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
                                                // final fingerprintSP =
                                                //     await SharedPreferences
                                                //         .getInstance();
                                                sharedPref.setBool(
                                                    "fingerprint", newValue);
                                                setState(() {
                                                  fingerprint = sharedPref
                                                      .getBool('fingerprint')!;
                                                });
                                                print("fingerprint = " +
                                                    fingerprint.toString());
                                              } else {
                                                //if canceleds
                                              }
                                            } else {
                                              // final fingerprintSP =
                                              //     await SharedPreferences
                                              //         .getInstance();
                                              sharedPref.setBool(
                                                  "fingerprint", newValue);
                                              setState(() {
                                                fingerprint = sharedPref
                                                    .getBool('fingerprint')!;
                                              });
                                              print("fingerprint = " +
                                                  fingerprint.toString());
                                            }
                                            // EasyLoading.dismiss();
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 90.w,
                                    child: Center(
                                      child: CSS.customElevatedButton(
                                        "تغيير كلمة المرور",
                                        100.w,
                                        () {
                                          Get.to(changePassword());
                                        },
                                        Colors.white,
                                        secondryColor,
                                        secondryColor,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    color: bordercolor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "إعدادات الالوان",
                                    style: titleTx(baseColor),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("عمى الألوان",
                                          style: descTx1(baseColorText)),
                                      Spacer(),
                                      CupertinoSwitch(
                                        // activeColor: baseColor,

                                        value: blindness,
                                        onChanged: (bool newValue) {
                                          // final blindnessSP =
                                          //     await SharedPreferences
                                          //         .getInstance();
                                          sharedPref.setBool(
                                              "blindness", newValue);
                                          setState(() {
                                            blindness = sharedPref
                                                .getBool('blindness')!;
                                          });
                                          print("blindness = " +
                                              blindness.toString());
                                          getColorSettings();
                                          widget.update!();
                                          configLoading();
                                          SystemChrome.setSystemUIOverlayStyle(
                                              SystemUiOverlayStyle(
                                            statusBarColor: baseColor,
                                          ));
                                        },
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      // Text("النظام الليلي",
                                      //     style: descTx1(baseColorText)),
                                      // Spacer(),
                                      // CupertinoSwitch(
                                      //   // activeColor: baseColor,
                                      //   value: darkmode,
                                      //   onChanged: (bool newValue) async {
                                      //     // final darkmodeSP =
                                      //     //     await SharedPreferences
                                      //     //         .getInstance();
                                      //     sharedPref.setBool(
                                      //         "darkmode", newValue);
                                      //     setState(() {
                                      //       darkmode =
                                      //           sharedPref.getBool('darkmode')!;
                                      //     });
                                      //     print("darkmode = " +
                                      //         darkmode.toString());
                                      //     getColorSettings();

                                      //     widget.update!();
                                      //     configLoading();
                                      //     SystemChrome.setSystemUIOverlayStyle(
                                      //         SystemUiOverlayStyle(
                                      //       statusBarColor: baseColor,
                                      //     ));
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    color: bordercolor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "إعدادات الاشعارات",
                                            style: titleTx(baseColor),
                                            textAlign: TextAlign.right,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text("إشعارات التحديثات",
                                                  style:
                                                      descTx1(baseColorText)),
                                              Spacer(),
                                              CupertinoSwitch(
                                                // activeColor: baseColor,
                                                value: updatenotification,

                                                onChanged:
                                                    (bool newValue) async {
                                                  sharedPref.setBool(
                                                      "updatenotification",
                                                      newValue);
                                                  setState(() {
                                                    updatenotification =
                                                        sharedPref.getBool(
                                                            'updatenotification')!;
                                                  });
                                                  print(
                                                      "updatenotification = " +
                                                          updatenotification
                                                              .toString());

                                                  if (sharedPref.getBool(
                                                          "updatenotification") ==
                                                      false) {
                                                    await FirebaseMessaging
                                                        .instance
                                                        .unsubscribeFromTopic(
                                                            raqameUpdate);
                                                  } else {
                                                    await FirebaseMessaging
                                                        .instance
                                                        .subscribeToTopic(
                                                            raqameUpdate);
                                                  }

                                                  widget.update!();
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("إشعارات العروض",
                                                  style:
                                                      descTx1(baseColorText)),
                                              Spacer(),
                                              CupertinoSwitch(
                                                // activeColor: baseColor,
                                                value: test_offers,
                                                onChanged:
                                                    (bool newValue) async {
                                                  sharedPref.setBool(
                                                      "offers", newValue);
                                                  setState(() {
                                                    test_offers = sharedPref
                                                        .getBool('offers')!;
                                                  });
                                                  print("offers = " +
                                                      test_offers.toString());

                                                  if (sharedPref
                                                          .getBool("offers") ==
                                                      false) {
                                                    // await FirebaseMessaging.instance
                                                    //     .unsubscribeFromTopic(
                                                    //         'raqameUpdate');
                                                    await FirebaseMessaging
                                                        .instance
                                                        .unsubscribeFromTopic(
                                                            offers);
                                                  } else {
                                                    // await FirebaseMessaging.instance
                                                    //     .subscribeToTopic('raqameUpdate');
                                                    await FirebaseMessaging
                                                        .instance
                                                        .subscribeToTopic(
                                                            offers);
                                                  }

                                                  widget.update!();
                                                },
                                              ),
                                            ],
                                          ),
                                        ], //notification
                                      ),
                                      if (permissionStatusFuture != "granted")
                                        Container(
                                          decoration: containerdecoration(
                                              redColor.withOpacity(0.6)),
                                          height: 130,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CSS.baseElevatedButton(
                                                'تفعيل الاشعارات من الاعدادات النظام',
                                                250,
                                                () async {
                                                  NotificationPermissions
                                                      .requestNotificationPermissions(
                                                          iosSettings:
                                                              const NotificationSettingsIos(
                                                                  sound: true,
                                                                  badge: true,
                                                                  alert: true));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Divider(
                                    color: bordercolor,
                                  ),
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
                                  InkWell(
                                    child: Text(
                                      "للبلاغات 940",
                                      style: descTx1(baseColorText),
                                    ),
                                    onTap: () {
                                      launch("tel://940");
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    child: Text(
                                      "للمساعدة : help@eamana.gov.sa",
                                      style: descTx1(baseColorText),
                                    ),
                                    onTap: () {
                                      launch("mailto:help@eamana.gov.sa");
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    child: Text("الدعم الفني : 8046333 - 013",
                                        style: descTx1(baseColorText)),
                                    onTap: () {
                                      launch("tel://0138046333");
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    child: Text(
                                        "العلاقات العامة : 8046000 - 013",
                                        style: descTx1(baseColorText)),
                                    onTap: () {
                                      launch("tel://0138046000");
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    child: Text("واتساب : 0530245555",
                                        style: descTx1(baseColorText)),
                                    onTap: () {
                                      launch("https://wa.me/+966530245555/");
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ), //all inside
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
