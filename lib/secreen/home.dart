import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/community/community.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/settings.dart';
import 'package:eamanaapp/secreen/statistics/statistics.dart';
import 'package:eamanaapp/secreen/widgets/exit_popup.dart';
import 'package:eamanaapp/secreen/widgets/image_view.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'EmpInfo/EmpInfoView.dart';
import 'package:sizer/sizer.dart';

import 'package:eamanaapp/secreen/widgets/alerts.dart';

import 'main_home.dart';

class HomePanel extends StatefulWidget {
  const HomePanel({Key? key}) : super(key: key);

  @override
  State<HomePanel> createState() => _HomPanelState();
}

class _HomPanelState extends State<HomePanel>
    with SingleTickerProviderStateMixin {
  String usernam = "drefr";
  final PanelController panlC = PanelController();
  bool isOpen = false;
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 4;
  EmployeeProfile empinfo = new EmployeeProfile();
  void openpanel() {
    _bottomNavIndex == 4
        ? panlC.isPanelOpen
            ? panlC.close()
            : panlC.open()
        : setState(() {
            _bottomNavIndex = 4;
          });
  }

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  bool animatedPositionedStart = false;

  bool showpanel = false;

  final iconList = <IconData>[
    Icons.settings,
    Icons.data_usage,
    Icons.design_services,
    Icons.comment_bank
  ];

  List<String> list = ['الاعدادات', 'بياناتي', 'الخدمات', 'تواصل'];

  String name = "";
  double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
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

  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) => cheackNetwork());
    getuserinfo();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          animatedPositionedStart = true;
        });
        return _animationController.forward();
      },
    );
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      print("isBackground");
    }

    /* if (isBackground) {
      // service.stop();
    } else {
      // service.start();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> screen = [
      //page 1
      Settings(() {
        setState(() {});
      }),
      // ChangeNotifierProvider(
      //   create: (_) => MettingsProvider(),
      //   // ignore: prefer_const_constructors
      //   child: MeetingView(),
      // ),
      // page 2
      ChangeNotifierProvider(
        create: (context) => EmpInfoProvider(),
        // ignore: prefer_const_constructors
        child: EmpProfile(true),
      ),

      //page 3
      ServicesView(),
      //page 4
      Community(),
      //home page
      MainHome(),
    ];

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isMobile = Responsive.isMobile(context);

    // print("isPortrait = " + isPortrait.toString());
    // print("width = " + 100.w.toString());
    // print("is mobile = " + Responsive.isMobile(context).toString());
    // print("is tablet = " + Responsive.isTablet(context).toString());

    isMobile == true
        ? {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ])
          }
        : null;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_bottomNavIndex == 4) {
            return showExitPopup(context);
          }
          setState(() {
            _bottomNavIndex = 4;
          });
          return false;
        },
        child: Scaffold(
          backgroundColor: BackGColor,
          body: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            clipBehavior: Clip.hardEdge,
            children: [
              screen[_bottomNavIndex],
              //show panel only in home screens
              _bottomNavIndex == 4
                  ? SlidingUpPanel(
                      //renderPanelSheet: false,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.25))
                      ],
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      onPanelClosed: () => setState(() {
                        isOpen = false;
                        showpanel = false;
                      }),
                      onPanelOpened: () => setState(() {
                        isOpen = true;
                      }),
                      onPanelSlide: (position) {
                        setState(() {
                          showpanel = true;
                        });
                      },
                      controller: panlC,
                      maxHeight: responsiveMT(380, 500),
                      minHeight: responsiveMT(90, 120),
                      slideDirection: SlideDirection.DOWN,
                      border: Border.all(color: bordercolor),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(4.0),
                          bottomRight: Radius.circular(4.0)),
                      parallaxEnabled: true,
                      parallaxOffset: 0,
                      collapsed: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: bordercolor),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0))),
                            child: Image(
                              //width: responsiveMT(90, 150),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fitWidth,
                              image: AssetImage(imageBG),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Center(
                                        child: Image(
                                            width: responsiveMT(90, 150),
                                            image: AssetImage(
                                                "assets/image/rakamy-logo-21.png")),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                Badge(
                                                  badgeColor: secondryColor,
                                                  badgeContent: Text(
                                                    '0',
                                                    style:
                                                        descTx2(Colors.white),
                                                  ),
                                                  child: Icon(
                                                    Icons.notifications_active,
                                                    color: baseColor,
                                                    size: responsiveMT(45, 45),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0,
                                                ),
                                                Text(
                                                  "تنبيهات",
                                                  style: descTx1(baseColorText),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: baseColor,
                                                  radius: responsiveMT(26, 28),
                                                  child: empinfo.ImageURL ==
                                                              null ||
                                                          empinfo.ImageURL == ""
                                                      ? Image.asset(
                                                          "assets/image/avatar.jpg")
                                                      : ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            height: 50,
                                                            width: 50,
                                                            fit: BoxFit.cover,
                                                            imageUrl: "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                                empinfo.ImageURL
                                                                        .toString()
                                                                    .split(
                                                                        "\$")[1],
                                                          ),
                                                        ),
                                                  // ClipOval(
                                                  //     child: FadeInImage
                                                  //         .assetNetwork(
                                                  //       fit: BoxFit.cover,
                                                  //       width: 50,
                                                  //       height: 50,
                                                  //       image: "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                  //           empinfo.ImageURL
                                                  //                   .toString()
                                                  //               .split(
                                                  //                   "\$")[1],
                                                  //       placeholder:
                                                  //           "assets/image/avatar.jpg",
                                                  //     ),
                                                  //   ),
                                                ),
                                                Text(
                                                  ("مرحبا / ") +
                                                      (empinfo.FirstName ?? ""),
                                                  style: descTx1(baseColorText),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: showpanel,
                            child: Positioned(
                              bottom: -20,
                              right: isPortrait == true ? 50.w - 40 : 50.h - 40,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: bordercolor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_upward_rounded),
                                  onPressed: () {
                                    openpanel();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      panel: Visibility(
                        visible: showpanel,
                        child: Stack(
                          fit: StackFit.loose,
                          overflow: Overflow.visible,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: bordercolor,
                                ),
                                //  Border(
                                //   bottom: BorderSide(
                                //     color: Color(0xFFDDDDDD),
                                //   ),
                                //   left: BorderSide(
                                //     color: Color(0xFFDDDDDD),
                                //   ),
                                //   right: BorderSide(
                                //     color: Color(0xFFDDDDDD),
                                //   ),
                                // ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                                child:
                                    // SvgPicture.asset(
                                    //   'assets/SVGs/Asset_1.svg',
                                    //   alignment: Alignment.topLeft,
                                    //   width: MediaQuery.of(context).size.width,
                                    //   fit: BoxFit.fitWidth,
                                    // ),
                                    Image(
                                  //width: responsiveMT(90, 150),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(imageBG),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: baseColor,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: new Radius.circular(20),
                                        topRight: new Radius.circular(20),
                                      ),
                                    ),
                                    width: 100,
                                    // color: Colors.blue.shade900,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        empinfo.StatusName.toString(),
                                        textAlign: TextAlign.right,
                                        style: descTx1(Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: responsiveMT(52, 92),
                                        backgroundColor: baseColor,
                                        child: empinfo.ImageURL == null ||
                                                empinfo.ImageURL == ""
                                            ? Image.asset(
                                                "assets/image/avatar.jpg")
                                            : GestureDetector(
                                                child: Hero(
                                                  tag: "profile",
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                              empinfo.ImageURL
                                                                      .toString()
                                                                  .split(
                                                                      "\$")[1],
                                                    ),
                                                    // FadeInImage
                                                    //     .assetNetwork(
                                                    //   fit: BoxFit.cover,
                                                    //   width: 100,
                                                    //   height: 100,
                                                    //   image:
                                                    //       "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                    //           empinfo.ImageURL
                                                    //                   .toString()
                                                    //               .split(
                                                    //                   "\$")[1],
                                                    //   placeholder:
                                                    //       "assets/image/avatar.jpg",
                                                    // ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                    return ProfileImage();
                                                  }));
                                                }),
                                      ),
                                      Text(
                                        empinfo.EmployeeName ?? "",
                                        style: titleTx(baseColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                          empinfo.Title == null ||
                                                  empinfo.Title == "" ||
                                                  empinfo.Title == "-"
                                              ? empinfo.JobName.toString()
                                              : empinfo.Title.toString(),
                                          style: descTx2(baseColor)),
                                      Container(
                                        margin: EdgeInsets.all(12),
                                        height: 125,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              baseColor,
                                              secondryColor,
                                            ],
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "بطاقة تسجيل الدخول",
                                                    textAlign: TextAlign.right,
                                                    style:
                                                        titleTx(Colors.white),
                                                  ),
                                                  Text(
                                                    "أمانة المنطقة الشرقية",
                                                    textAlign: TextAlign.right,
                                                    style:
                                                        descTx2(Colors.white),
                                                  ),
                                                  Text(
                                                    empinfo.JobName == null ||
                                                            empinfo.JobName ==
                                                                ""
                                                        ? empinfo.empTypeName
                                                            .toString()
                                                        : empinfo.JobName
                                                                .toString() +
                                                            " - " +
                                                            empinfo.empTypeName
                                                                .toString(),
                                                    textAlign: TextAlign.right,
                                                    style:
                                                        descTx2(Colors.white),
                                                  ),

                                                  // AutoSizeText(
                                                  //   "تاريخ الدخول: الأحد 14/9/2022 - 14:00",
                                                  //   maxLines: 1,
                                                  //   style: TextStyle(
                                                  //       color: Colors.white),
                                                  //   group: autoSizeGroup,
                                                  // ),
                                                  Text(
                                                    "تاريخ الدخول: الأحد 14/9/2022 - 14:00",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 18),
                                              width: 90,
                                              height: 90,
                                              child: SfBarcodeGenerator(
                                                backgroundColor: Colors.white,
                                                value: (empinfo.EmployeeNumber)
                                                    .toString()
                                                    .split(".")[0],
                                                symbology: QRCode(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: showpanel,
                              child: Positioned(
                                bottom: -20,
                                right:
                                    isPortrait == true ? 50.w - 40 : 50.h - 40,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: bordercolor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_upward_rounded),
                                    onPressed: () {
                                      openpanel();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          floatingActionButton: ScaleTransition(
            scale: animation,
            child: Visibility(
              visible: !keyboardIsOpen,
              child: SizerUtil.deviceType == DeviceType.mobile
                  ? FloatingActionButton(
                      elevation: 8,
                      backgroundColor: BackGWhiteColor,
                      child: AnimatedSwitcher(
                        duration: Duration(seconds: 50),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _bottomNavIndex == 4
                              ? Icon(
                                  Icons.card_membership,
                                  key: ValueKey<int>(0),
                                  color: baseColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.home,
                                  key: ValueKey<int>(1),
                                  color: baseColor,
                                  size: 24,
                                ),
                        ),
                      ),
                      onPressed: () {
                        openpanel();
                      },
                    )
                  : FloatingActionButton.large(
                      elevation: 8,
                      backgroundColor: BackGWhiteColor,
                      child: _bottomNavIndex == 4
                          ? Icon(
                              Icons.card_membership,
                              color: baseColor,
                              size: 50,
                            )
                          : Icon(
                              Icons.home,
                              color: baseColor,
                              size: 50,
                            ),
                      onPressed: () {
                        openpanel();
                      },
                    ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Stack(
            children: [
              AnimatedBottomNavigationBar.builder(
                itemCount: iconList.length,
                tabBuilder: (
                  int index,
                  bool isActive,
                ) {
                  Color color = isActive ? secondryColor : BackGWhiteColor;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconList[index],
                        size: responsiveMT(25, 45),
                        color: color,
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AutoSizeText(
                          list[index],
                          maxLines: 1,
                          style: TextStyle(color: color),
                          group: autoSizeGroup,
                        ),
                      )
                    ],
                  );
                },
                splashRadius: 0,
                notchMargin: 0,
                height: responsiveMT(70, 90),
                backgroundColor: baseColor,
                activeIndex: _bottomNavIndex,
                splashColor: secondryColor,
                notchAndCornersAnimation: animation,
                splashSpeedInMilliseconds: 300,
                notchSmoothness: NotchSmoothness.defaultEdge,
                gapLocation: GapLocation.center,
                leftCornerRadius: 0,
                rightCornerRadius: 0,
                onTap: (index) => setState(() {
                  Statistics();
                  _bottomNavIndex = index;
                }),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                child: Text(
                  "بطاقتي",
                  style: TextStyle(
                      color: BackGWhiteColor, fontWeight: FontWeight.bold),
                ),
                right: isPortrait == true ? (50.w - 21) : (50.h - 21),
                bottom: _bottomNavIndex == 4
                    ? animatedPositionedStart
                        ? 5
                        : -25
                    : animatedPositionedStart
                        ? -25
                        : 5,
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                child: Text(
                  "الرئيسية",
                  style: TextStyle(
                      color: BackGWhiteColor, fontWeight: FontWeight.bold),
                ),
                right: isPortrait == true ? (50.w - 21) : (50.h - 21),
                bottom: _bottomNavIndex == 4 ? -25 : 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// appBar: AppBar(
//   automaticallyImplyLeading: false,
//   flexibleSpace: Container(
//     decoration: const BoxDecoration(
//         gradient: LinearGradient(
//       begin: Alignment.topRight,
//       end: Alignment.bottomLeft,
//       colors: [
//         Color(0xffDBF3FF),
//         Color(0xffE8FEFF),
//       ],
//     )),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/SVGs/header.png',
//           //width: 100,
//         ),
//       ],
//     ),
//   ),
//   bottom: PreferredSize(
//     preferredSize: const Size.fromHeight(80.0),
//     child: Container(
//       width: double.maxFinite,
//       color: Colors.white,
//       alignment: Alignment.center,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         reverse: true,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TabBar(
//               //padding: EdgeInsets.all(0),
//               isScrollable: true,
//               tabs: usernam == ""
//                   ? [
//                       Tab(
//                         text: "إحصائيات",
//                       ),
//                       Tab(
//                         text: "دليل الموظفين",
//                       ),
//                       Tab(
//                         text: "اعتماداتي",
//                       ),
//                     ]
//                   : [
//                       Tab(
//                         text: "لوحة البيانات",
//                       ),
//                       Tab(
//                         text: "إحصائيات",
//                       ),
//                       Tab(
//                         text: "دليل الموظفين",
//                       ),
//                       Tab(
//                         text: "اعتماداتي",
//                       ),
//                       Tab(
//                         text: "مواعيدي",
//                       ),
//                     ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),
// ),
// body: TabBarView(
//     children: usernam == ""
//         ? [
//             ChangeNotifierProvider(
//               create: (_) => EmpInfoProvider(),
//               // ignore: prefer_const_constructors
//               child: EmpProfile(),
//             ),
//             Statistics(),
//             ChangeNotifierProvider(
//               create: (context) => EatemadatProvider(),
//               // ignore: prefer_const_constructors
//               child: InboxHedersView(),
//             ),
//           ]
//         : [
//             ChangeNotifierProvider(
//               create: (_) => EmpInfoProvider(),
//               // ignore: prefer_const_constructors
//               child: EmpProfile(),
//             ),
//             Statistics(),
//             ChangeNotifierProvider(
//               create: (_) => EmpInfoProvider(),
//               // ignore: prefer_const_constructors
//               child: EmpInfoView(),
//             ),
//             ChangeNotifierProvider(
//               create: (context) => EatemadatProvider(),
//               // ignore: prefer_const_constructors
//               child: InboxHedersView(),
//             ),
//             ChangeNotifierProvider(
//               create: (_) => MettingsProvider(),
//               // ignore: prefer_const_constructors
//               child: MeetingView(),
//             ),
//           ]),
