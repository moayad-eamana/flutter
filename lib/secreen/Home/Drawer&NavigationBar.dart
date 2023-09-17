import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/EamanaDiscount.dart';
import 'package:eamanaapp/secreen/EmpInfo/newEmpinfo.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/responsive.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/secreen/notification/bagenotification.dart';
import 'main_home.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final PanelController panlC = PanelController();
  bool isOpen = false;

  var _bottomNavIndex = 0;
  EmployeeProfile empinfo = new EmployeeProfile();
  bool updateVersion = false;

  double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;

  getuserinfo() async {
    empinfo = empinfo.getEmployeeProfile();
    await badgenotification.shownotfNub();
    setState(() {});
  }

  void cheackNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      Alerts.errorAlert(context, "تنبيه", "لا يوجد شبكة").show();
    }
  }

  void didChangeDependencies() {
    precacheImage(AssetImage("assets/image/raqmy-icon.png"), context);
    super.didChangeDependencies();
  }

  void initState() {
    getuserinfo();
    cheackNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> screen = [
      //home page
      MainHome(() {
        setState(() {
          _bottomNavIndex = 1;
        });
      }),
      //page 2
      ServicesView(),
      //page 3
      EamanaDiscount(true, false),
      //page 4
      newEmpInfo(false),
    ];

    var isMobile = Responsive.isMobile(context);

    isMobile == true
        ? {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ])
          }
        : null;

    return SafeArea(
      // top: _bottomNavIndex == 1 ? false : true,
      bottom: false,
      top: false,
      child: WillPopScope(
        onWillPop: () async {
          if (_bottomNavIndex == 0) {
            if (isOpen == true) {
              panlC.close();
            } else {
              Alerts.confirmAlrt(
                      context, "خروج", "هل تريد الخروج من التطبيق", "نعم")
                  .show()
                  .then((value) async {
                if (value == true) {
                  exit(0);
                }
              });
            }
          }
          setState(() {
            _bottomNavIndex = 0;
          });
          return false;
        },
        child: Scaffold(
          endDrawer: Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: bordercolor),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0))),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Drawer(
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                empinfo.ImageURL == null ||
                                        empinfo.ImageURL == ""
                                    ? CircleAvatar(
                                        radius: responsiveMT(24, 26),
                                        child: ClipOval(
                                          child: Image.asset(
                                            "assets/image/blank-profile.png",
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                  empinfo.ImageURL.toString(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/image/blank-profile.png",
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  (empinfo.FirstName == null
                                      ? ""
                                      : "${empinfo.FirstName} ${empinfo.SecondName} ${empinfo.LastName}"),
                                  style: fontsStyle.px14(
                                      fontsStyle.SecondaryColor(),
                                      FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'بطاقتي',
                          style: fontsStyle.px14(
                              fontsStyle.thirdColor(), FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/MyCard");
                        },
                      ),
                      ListTile(
                        title: Text(
                          'الإعدادات',
                          style: fontsStyle.px14(
                              fontsStyle.thirdColor(), FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/Settings");
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 109),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 40,
                                width: 126,
                                child: CSS.baseElevatedButton(
                                  "تسجيل خروج",
                                  0,
                                  () async {
                                    Alerts.confirmAlrt(context, "تسجيل خروج",
                                            "هل تريد الخروج من التطبيق", "نعم")
                                        .show()
                                        .then((value) async {
                                      if (value == true) {
                                        // FirebaseMessaging.instance
                                        //     .deleteToken();

                                        sharedPref.setDouble(
                                            "EmployeeNumber", 0);
                                        sharedPref.setString("hasePerm", "");
                                        sharedPref.setBool(
                                            "permissionforCRM", false);

                                        hasePerm = "";
                                        //_pref.clear();
                                        //setSettings();

                                        Navigator.pushReplacementNamed(
                                            context, '/loginView');
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: BackGColor,
          body: packageInfo.version != localVersion && forceUpdate == true
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
                              style:
                                  ElevatedButton.styleFrom(primary: baseColor),
                              onPressed: () async {
                                if (Platform.isAndroid) {
                                  launch(
                                      "https://play.google.com/store/apps/details?id=com.eamana.eamanaapp.gov.sa");
                                } else {
                                  launch(
                                      "https://apps.apple.com/us/app/%D8%B1%D9%82%D9%85%D9%8A/id1613668254");
                                }

                                //   Navigator.pop(context);
                              },
                              child: Text("تحديث")),
                        ],
                      )
                    ],
                  ),
                )
              : Stack(
                  fit: StackFit.loose,
                  overflow: Overflow.visible,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: responsiveMT(90, 120),
                      ),
                      //  width: 100.w,
                    ),

                    screen[_bottomNavIndex],

                    //show panel only in home screens
                    _bottomNavIndex == 0
                        ? Container(
                            height: 230,
                            width: 100.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  child: SvgPicture.asset(
                                    'assets/SVGs/Rectangle-661.svg',
                                    width: 100.w,
                                  ),
                                ),
                                Positioned(
                                  bottom: 7,
                                  child: SvgPicture.asset(
                                    'assets/SVGs/Rectangle-660.svg',
                                    width: 100.w,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: SvgPicture.asset(
                                    "assets/SVGs/app-bar-pattren.svg",

                                    // width: 100.w,
                                    // height: 220,
                                    color: Colors.white,

                                    // opacity: AlwaysStoppedAnimation(0.5),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 30),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      badgenotification
                                                          .badgewidget(context),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 35),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Scaffold.of(context)
                                                          .openEndDrawer(),
                                                  child: SvgPicture.asset(
                                                    'assets/SVGs/drawer-icon.svg',
                                                    // width: 100.w,
                                                  ),
                                                ),
                                                // IconButton(
                                                //   icon: Icon(
                                                //     Icons.format_align_right,
                                                //     color: Colors.white,
                                                //   ),
                                                //   onPressed: () {
                                                //     Scaffold.of(context)
                                                //         .openEndDrawer();
                                                //   },
                                                // ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100.w,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            ", مرحباً بك",
                                            style: fontsStyle.px20(Colors.white,
                                                FontWeight.normal),
                                            textAlign: TextAlign.end,
                                          ),
                                          Text(
                                            (empinfo.FirstName == null
                                                ? ""
                                                : "${empinfo.FirstName} ${empinfo.LastName}"),
                                            style: fontsStyle.px20(Colors.white,
                                                FontWeight.normal),
                                            textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        // Container(
                        //     height: 100,
                        //     child: Container(
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Container(
                        //             margin: EdgeInsets.only(left: 10, top: 30),
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.center,
                        //                     children: [
                        //                       badgenotification
                        //                           .badgewidget(context),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           Image.asset(
                        //             "assets/image/raqmy-icon.png",
                        //             width: 150,
                        //           ),
                        //           StatefulBuilder(
                        //             builder: (BuildContext context, setState) {
                        //               return Container(
                        //                 margin: EdgeInsets.only(bottom: 20),
                        //                 child: IconButton(
                        //                   icon: Icon(
                        //                     Icons.format_align_right,
                        //                     color: Color(0xff666666),
                        //                   ),
                        //                   onPressed: () {
                        //                     Scaffold.of(context)
                        //                         .openEndDrawer();
                        //                   },
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   )
                        : Container(),
                  ],
                ),
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                height: 90,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(0.17),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color: BackGWhiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed, // Fixed

                    backgroundColor:
                        BackGWhiteColor, // <-- This works for fixed
                    selectedItemColor: secondryColor,
                    unselectedItemColor: fontsStyle.FourthColor(),
                    currentIndex: _bottomNavIndex,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                    unselectedLabelStyle: fontsStyle.px12normal(
                        fontsStyle.FourthColor(), FontWeight.normal),
                    selectedLabelStyle:
                        fontsStyle.px12normal(secondryColor, FontWeight.normal),
                    onTap: (value) => setState(() {
                      _bottomNavIndex = value;
                    }),
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          _bottomNavIndex == 0
                              ? 'assets/SVGs/home-icon-2.svg'
                              : 'assets/SVGs/home-icon.svg',
                          width: 20,
                          height: 20,
                          // color: _bottomNavIndex == 0 ? secondryColor : null,
                        ),
                        label: 'الرئيسية',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          _bottomNavIndex == 1
                              ? 'assets/SVGs/services-icon-2.svg'
                              : 'assets/SVGs/services-icon.svg',
                          // color: _bottomNavIndex == 1 ? secondryColor : null,
                          width: 20,
                          height: 20,
                        ),
                        label: 'خدمات',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          _bottomNavIndex == 2
                              ? 'assets/SVGs/offers-icon-2.svg'
                              : 'assets/SVGs/offers-icon.svg',
                          // color: _bottomNavIndex == 2 ? secondryColor : null,
                          width: 20,
                          height: 20,
                        ),
                        label: 'عروض',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          _bottomNavIndex == 3
                              ? 'assets/SVGs/mydata-icon-2.svg'
                              : 'assets/SVGs/mydata-icon.svg',
                          // color: _bottomNavIndex == 3 ? secondryColor : null,
                          width: 20,
                          height: 20,
                        ),
                        label: 'بياناتي',
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
