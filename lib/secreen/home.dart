import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/statistics/statistics.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'EmpInfo/EmpInfoView.dart';
import 'package:sizer/sizer.dart';

import 'main_home.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  String usernam = "drefr";
  final PanelController panlC = PanelController();
  bool isOpen = false;
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0;

  void openpanel() {
    _bottomNavIndex == 0
        ? panlC.isPanelOpen
            ? panlC.close()
            : panlC.open()
        : setState(() {
            _bottomNavIndex = 0;
          });
  }

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  bool animatedPositionedStart = false;

  final iconList = <IconData>[
    Icons.home,
    Icons.support_rounded,
    Icons.grid_4x4,
    Icons.star_outline
  ];

  List<String> list = ['الرئيسية', 'دعم الفني', 'الخدمات', 'تواصل'];
  List<dynamic> screen = [
    MainHome(),
    ChangeNotifierProvider(
      create: (_) => MettingsProvider(),
      // ignore: prefer_const_constructors
      child: MeetingView(),
    ),

    // ignore: prefer_const_constructors
    ServicesView(),

    ChangeNotifierProvider(
      create: (_) => EmpInfoProvider(),
      // ignore: prefer_const_constructors
      child: EmpInfoView(),
    ),
    ChangeNotifierProvider(
      create: (_) => EmpInfoProvider(),
      // ignore: prefer_const_constructors
      child: EmpProfile(),
    ),
  ];

  double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;

  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isMobile = Responsive.isMobile(context);

    print("isPortrait = " + isPortrait.toString());
    print("width = " + 100.w.toString());
    print("is mobile = " + Responsive.isMobile(context).toString());
    print("is tablet = " + Responsive.isTablet(context).toString());

    isMobile == true
        ? {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ])
          }
        : null;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Column(children: [
              _bottomNavIndex == 0
                  ? SizedBox(
                      height: 10.h,
                    )
                  : Container(),
              Expanded(
                child: screen[_bottomNavIndex],
              ),
            ]),
            _bottomNavIndex == 0
                ? SlidingUpPanel(
                    boxShadow: [
                        BoxShadow(
                            blurRadius: 0, color: Color.fromRGBO(0, 0, 0, 0.25))
                      ],
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    onPanelClosed: () => setState(() {
                          isOpen = false;
                        }),
                    onPanelOpened: () => setState(() {
                          isOpen = true;
                        }),
                    controller: panlC,
                    maxHeight: 380,
                    minHeight: 80,
                    slideDirection: SlideDirection.DOWN,
                    border: Border.all(color: Color(0xff9F9F9F)),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0)),
                    parallaxEnabled: true,
                    parallaxOffset: 0,
                    panel: isOpen
                        ? Container(
                            child: Center(
                            child: Column(
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
                                        "على رأس العمل",
                                        textAlign: TextAlign.right,
                                        style: descTx1(Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 42.sp,
                                        backgroundColor: Color(0xff274690),
                                        child: CircleAvatar(
                                          radius: 40.sp,
                                          backgroundImage: AssetImage(
                                              "assets/image/avatar.jpg"),
                                        ),
                                      ),
                                      Text(
                                        "عبدالله أحمد آل الكبيش",
                                        style: titleTx(baseColor),
                                      ),
                                      Text(
                                          "مدير إدارة التطبيقات والخدمات الالكترونية",
                                          style: descTx2(baseColor)),
                                      Container(
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
                                                    style:
                                                        descTx2(Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 18),
                                              width: 100,
                                              height: 100,
                                              child: SfBarcodeGenerator(
                                                backgroundColor: Colors.white,
                                                value: '444444',
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
                          ))
                        : Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    Center(
                                      child: Image(
                                          width: 25.w,
                                          //height: 15.h,
                                          image: AssetImage(
                                              "assets/image/raqmy-logo.png")),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Column(
                                          //   children: [
                                          //     Icon(Icons.notifications_active),
                                          //     Text("تنبيهات")
                                          //   ],
                                          // ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.notifications_active,
                                                  color: baseColor,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "تنبيهات",
                                                  style: descTx1(baseColorText),
                                                )
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xff274690),
                                                  radius: 18.sp,
                                                  child: CircleAvatar(
                                                    radius: 16.sp,
                                                    backgroundImage: AssetImage(
                                                        "assets/image/avatar.jpg"),
                                                  ),
                                                ),
                                                Text(
                                                  "مرحبا / عبدالله",
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
                          )
                    // AnimatedAlign(
                    //   alignment:
                    //       isOpen ? Alignment.center : Alignment.bottomCenter,
                    //   duration: const Duration(milliseconds: 200),
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(20.0),
                    //     child: Text(
                    //       "This is the sliding Widget",
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    )
                : Container(),
          ],
        ),
        floatingActionButton: ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            elevation: 8,
            backgroundColor: Colors.white,
            child: _bottomNavIndex == 0
                ? Icon(
                    Icons.card_membership,
                    color: baseColor,
                    size: isMobile == true ? 24.sp : 18.sp,
                  )
                : Icon(
                    Icons.home,
                    color: baseColor,
                    size: isMobile == true ? 24.sp : 18.sp,
                  ),
            onPressed: () {
              openpanel();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Stack(
          children: [
            AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? secondryColor : Colors.white;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: isMobile == true ? 20.sp : 18.sp,
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
              height: isMobile == true ? 7.h : 7.h,
              backgroundColor: baseColor,
              activeIndex: _bottomNavIndex,
              splashColor: Colors.blueGrey,
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              right: isPortrait == true ? (50.w - 21) : (50.h - 21),
              bottom: _bottomNavIndex == 0
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              right: isPortrait == true ? (50.w - 21) : (50.h - 21),
              bottom: _bottomNavIndex == 0 ? -25 : 5,
            ),

            // AnimatedPositioned(
            //   duration: Duration(seconds: 1),
            //   child: _bottomNavIndex == 0
            //       ? Text(
            //           "بطاقتي",
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         )
            //       : Text(
            //           "رئيسية",
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         ),
            //   right: isPortrait == true ? (50.w - 20) : (50.h - 20),
            //   bottom: animatedPositionedStart ? 5 : -25,
            // ),

            // Positioned(
            //   bottom: 5,
            //   right: isPortrait == true ? (50.w - 20) : (50.h - 20),
            //   child: _bottomNavIndex == 0
            //       ? Text(
            //           "بطاقتي",
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         )
            //       : Text(
            //           "رئيسية",
            //           style: TextStyle(
            //               color: Colors.white, fontWeight: FontWeight.bold),
            //         ),
            // ),
          ],
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
