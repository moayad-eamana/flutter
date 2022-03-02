import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/secreen/widgets/slider.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

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
    "assets/image/banner.png",
    "assets/image/banner2.jpeg"
  ];

  List<int> selectsilderBanner = [0, 1];
  List<String> selectsilderTitle = ["اليوم الوطني السعودي 90", "يوم التأسيس"];

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    embId();
    super.initState();
  }

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
                  height: 90,
                ),
                TextField(
                  showCursor: false,
                  readOnly: true,
                  controller: _search,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: baseColor,
                          size: 35,
                        ),
                        onPressed: () async {}),
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
                    filled: true,
                    fillColor: BackGWhiteColor,
                    labelText: "بحث الخدمات",
                    alignLabelWithHint: true,
                  ),
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(context, id));

                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
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
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (id == 1)
                                widgetsUni.servicebutton(
                                  "مواعيد",
                                  Icons.calendar_today,
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
                                "بياناتي",
                                Icons.data_saver_off_outlined,
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
                                Icons.people_alt,
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
                              widgetsUni.servicebutton(
                                "تعريف بالراتب",
                                Icons.money,
                                () {
                                  ViewFile.open(testbase64Pfd, "pdf");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
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
                  height: responsiveMT(300, 500),
                  width: 100.w,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "الخدمات الاكثر أستخداماً",
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
                                        : secondryColorText),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 5,
                        bottom: 5,
                        child: Image(
                            width: responsiveMT(60, 120),
                            //height: responsiveMT(30, 100),
                            image:
                                AssetImage("assets/image/rakamy-logo-21.png")),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      "الفعاليات",
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
                Container(
                  decoration: containerdecoration(BackGWhiteColor),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          // aspectRatio: 3 / 4,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          height: responsiveMT(100, 200),
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                _currentIndexBanner = index;
                              },
                            );
                          },
                        ),
                        items: imageBanner
                            .map(
                              (e) => Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Image(
                                      height: responsiveMT(100, 200),
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(e),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectsilderTitle.elementAt(_currentIndexBanner),
                              style: descTx2(secondryColorText),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: selectsilderBanner.map((urlOfItem2) {
                                int index =
                                    selectsilderBanner.indexOf(urlOfItem2);
                                return Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndexBanner == index
                                          ? baseColor
                                          : secondryColorText),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SvgPicture.asset(
                //   'assets/SVGs/dalel-emp.svg',
                //   width: 150,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
