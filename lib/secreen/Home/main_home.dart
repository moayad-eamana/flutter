import 'dart:convert';
import 'dart:developer';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmpInfo.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Home/panel&NavigationBar.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/secreen/widgets/slider.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eamanaapp/secreen/old/search.dart';
import 'package:http/http.dart' as http;

class MainHome extends StatefulWidget {
  final Function goto;
  MainHome(this.goto);
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController _search = TextEditingController();
  var _currentIndex = 0;
  var _currentIndexBanner = 0;
  dynamic id;

  List<int> selectsilder = [0, 1];

  List<dynamic> imageBanner = [
    "assets/image/Ramdan_kreem.jpg",
    "assets/image/banner2.jpeg",
  ];

  List<int> selectsilderBanner = [0, 1];
  List<String> selectsilderTitle = ["رمضان كريم", "اليوم الوطني السعودي 90"];

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    embId();
    super.initState();
    //hasPermission();
    // subscribeToNotification();
  }

  // subscribeToNotification() async {
  //   // await FirebaseMessaging.instance.subscribeToTopic('raqame_eamana');
  // }

  EmployeeProfile empinfo = new EmployeeProfile();

  // Future<void> hasPermission() async {
  //   if (hasePerm == null) {
  //     empinfo = await empinfo.getEmployeeProfile();
  //     var respose = await http.post(
  //         Uri.parse(
  //             "https://crm.eamana.gov.sa/agendaweekend/api/api-mobile/getAppointmentsPermission.php"),
  //         body: jsonEncode({
  //           "token": "RETTErhyty45ythTRH45y45y",
  //           "username": empinfo.Email
  //         }));
  //     hasePerm = jsonDecode(respose.body)["message"];
  //     hasePerm = hasePerm;
  //     print("rr" + hasePerm.toString());
  //     SharedPreferences? sharedPref = await SharedPreferences.getInstance();
  //     hasePerm = sharedPref.setBool("hasePerm", hasePerm);
  //   }
  // }

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: responsiveMT(95, 130),
                ),
                GestureDetector(
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(context, id));

                    FocusScope.of(context).unfocus();
                  },
                  child: TextField(
                    showCursor: false,
                    enabled: false,
                    readOnly: true,
                    controller: _search,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                      //   floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: baseColor,
                            size: 35,
                          ),
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate(context, id));

                            FocusScope.of(context).unfocus();
                          }),
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
                      contentPadding: EdgeInsets.all(10),
                      filled: true,
                      fillColor: BackGWhiteColor,
                      labelText: "تبحث عن خدمة محددة ؟",
                      alignLabelWithHint: true,
                      labelStyle: subtitleTx(lableTextcolor),
                    ),
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(context, id));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (id != 0101)
                  Row(
                    children: [
                      Text(
                        "خدمة سريعة",
                        style: titleTx(baseColorText),
                      ),
                      Expanded(
                        child: Container(
                            // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                          color: baseColorText,
                          height: 20,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        )),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                if (id != 0101)
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (hasePerm == "true")
                                  widgetsUni.servicebutton(
                                    "مواعيد",
                                    'assets/SVGs/mawa3idi.svg',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                            create: (context) =>
                                                MettingsProvider(),
                                            // ignore: prefer_const_constructors
                                            child: MeetingView(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                widgetsUni.servicebutton(
                                  "تعريف بالراتب",
                                  'assets/SVGs/ta3refalratb.svg',
                                  () async {
                                    // final fingerprintSP =
                                    //     await SharedPreferences.getInstance();
                                    bool fingerprint =
                                        sharedPref.getBool('fingerprint')!;
                                    EasyLoading.show(
                                      status: 'جاري المعالجة...',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    String emNo = await EmployeeProfile
                                        .getEmployeeNumber();
                                    var respons = await getAction(
                                        "HR/GetEmployeeSalaryReport/" + emNo);
                                    EasyLoading.dismiss();
                                    if (fingerprint) {
                                      Navigator.pushNamed(
                                              context, "/auth_secreen")
                                          .then((value) async {
                                        if (value == true) {
                                          //      print(jsonDecode(respons.body)["salaryPdf"]);

                                          ViewFile.open(
                                              jsonDecode(
                                                  respons.body)["salaryPdf"],
                                              "pdf");
                                        }
                                      });
                                    } else {
                                      ViewFile.open(
                                          jsonDecode(respons.body)["salaryPdf"],
                                          "pdf");
                                    }
                                  },
                                ),
                                widgetsUni.servicebutton(
                                  "معلوماتي",
                                  'assets/SVGs/baynaty.svg',
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                            create: (context) =>
                                                EmpInfoProvider(),
                                            // ignore: prefer_const_constructors
                                            child: EmpProfile(null),
                                          ),
                                        ));
                                  },
                                ),
                                widgetsUni.servicebutton(
                                  "دليل الموظفين",
                                  'assets/SVGs/dalelalmowzafen.svg',
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                            create: (context) =>
                                                EmpInfoProvider(),
                                            // ignore: prefer_const_constructors
                                            child: EmpInfoView(null),
                                          ),
                                        ));
                                  },
                                ),
                                // widgetsUni.servicebutton(
                                //   "طلب استيكر",
                                //   Icons.directions_car,
                                //   () {
                                //     print("ee");
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.ease);
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: BackGWhiteColor,
                    border: Border.all(
                      color: bordercolor,
                    ),
                    //color: baseColor,
                    borderRadius: BorderRadius.all(
                      new Radius.circular(4),
                    ),
                  ),
                  //color: Colors.red,
                  height: responsiveMT(320, 500),
                  width: 100.w,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "الخدمات الرئیسیة",
                            style: titleTx(baseColor),
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              height: responsiveMT(200, 400),
                              onPageChanged: (index, reason) {
                                setState(
                                  () {
                                    _currentIndex = index;
                                  },
                                );
                              },
                            ),
                            items: SliderWidget.sliderw(context, id),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: selectsilder.map((urlOfItem) {
                              int index = selectsilder.indexOf(urlOfItem);
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentIndex == index
                                        ? baseColor
                                        : secondryColor),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Image(
                            width: responsiveMT(40, 120),
                            //height: responsiveMT(30, 100),
                            image:
                                AssetImage("assets/image/rakamy-logo-21.png")),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 10,
                          child: InkWell(
                            onTap: () {
                              widget.goto();
                            },
                            child: Text(
                              "> عرض جميع الخدمات",
                              style: descTx2(baseColor),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   children: [
                //     Text(
                //       "الفعالیات و المناسبات",
                //       style: titleTx(baseColorText),
                //     ),
                //     Expanded(
                //       child: Container(
                //           // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                //           child: Divider(
                //         color: baseColorText,
                //         height: 20,
                //         thickness: 1,
                //         indent: 5,
                //         endIndent: 5,
                //       )),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   decoration: containerdecoration(BackGWhiteColor),
                //   child: Column(
                //     children: [
                //       GestureDetector(
                //         onTap: () => Navigator.pushNamed(context, "/events"),
                //         child: CarouselSlider(
                //           options: CarouselOptions(
                //             // aspectRatio: 3 / 4,
                //             viewportFraction: 1.0,
                //             enlargeCenterPage: false,
                //             autoPlay: true,
                //             height: responsiveMT(100, 200),
                //             onPageChanged: (index, reason) {
                //               setState(
                //                 () {
                //                   _currentIndexBanner = index;
                //                 },
                //               );
                //             },
                //           ),
                //           items: imageBanner
                //               .map(
                //                 (e) => Row(
                //                   mainAxisSize: MainAxisSize.max,
                //                   children: [
                //                     Expanded(
                //                       child: Image(
                //                         height: responsiveMT(100, 200),
                //                         fit: BoxFit.fitWidth,
                //                         image: AssetImage(e),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               selectsilderTitle.elementAt(_currentIndexBanner),
                //               style: descTx2(secondryColorText),
                //             ),
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.end,
                //               children: selectsilderBanner.map((urlOfItem2) {
                //                 int index =
                //                     selectsilderBanner.indexOf(urlOfItem2);
                //                 return Container(
                //                   width: 10.0,
                //                   height: 10.0,
                //                   margin: EdgeInsets.symmetric(
                //                       vertical: 10.0, horizontal: 2.0),
                //                   decoration: BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       color: _currentIndexBanner == index
                //                           ? baseColor
                //                           : secondryColor),
                //                 );
                //               }).toList(),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
