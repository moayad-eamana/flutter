import 'dart:convert';
import 'dart:typed_data';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:http/http.dart' as http;

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/secreen/widgets/slider.dart';
import 'package:eamanaapp/utilities/ActionOfServices.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/functions/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eamanaapp/utilities/searchX.dart';

class MainHome extends StatefulWidget {
  final Function goto;
  MainHome(this.goto);
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<dynamic> listofFavs = [];

  TextEditingController _search = TextEditingController();
  var _currentIndex = 0;
  var _currentIndexBanner = 0;
  dynamic id;
  bool? image;
  List<int> selectsilder = [0, 1];

  List<dynamic> imageBanner = [
    "assets/image/flag1.png",
  ];
  List<int> selectsilderBanner = [0];
  List<String> selectsilderTitle = ["تهنئة العيد"];

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    setState(() {});
    if (sharedPref.getBool("imageLoad2023-0") == null) {
      sharedPref.setBool("imageLoad2023-0", true);
      await http.get(Uri.parse(
          'https://srv.eamana.gov.sa/EidCongrats/Home/index?employeeNumber=${EmployeeProfile.getEmployeeNumber()}'));
      image = true;
    } else {
      image = true;
    }
    // myDialog(); // --> test
    var v = sharedPref.getBool("oneTimeDialog2023-0");
    // if (v == null) {
    //   myDialog();
    //   sharedPref.setBool("oneTimeDialog2023-0", false);
    // }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    embId();

    print(packageInfo.version);
    if (sharedPref.getString("dumyuser") != "10284928492") {
      getAction("Offers/GetCategories");
    }

    print("object");
    super.initState();
  }

  EmployeeProfile empinfo = new EmployeeProfile();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/71807696/flutter-future-delayed-on-endless-loop 😅
    // but it is not working with favs.dart
    // Future.delayed(Duration.zero).then((value) {
    listofFavs = listOfFavs(context);
    setState(() {});

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(),
                //my dialog:

                SizedBox(
                  height: responsiveMT(95, 130),
                ),
                GestureDetector(
                  onTap: () {
                    print("object");
                    showSearchX(
                            context: context,
                            delegate: CustomSearchDelegate(context, id, false))
                        .then((value) {
                      setState(() {
                        listofFavs = listOfFavs(context);
                      });
                    });

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
                            print("object");
                            showSearchX(
                                context: context,
                                delegate:
                                    CustomSearchDelegate(context, id, false));

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
                      disabledBorder: OutlineInputBorder(
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
                      print("object");
                      //FocusScope.of(context).unfocus();

                      showSearchX(
                          context: context,
                          delegate: CustomSearchDelegate(context, id, false));
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
                        listofFavs.length == 0 ? "خدمة سريعة" : "المفضلة",
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
                            child: listofFavs.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                        ...listofFavs.map((e) =>
                                            servicebuttonFavs(e, context)),
                                      ])
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ...listOfServices(context)
                                          .fastservices()
                                          .map((e) =>
                                              servicebuttonFavs(e, context)),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: baseColorText,
                        ),
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
                //       "مشاركة تهنئة بطاقة العيد",
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
                //       CarouselSlider(
                //         options: CarouselOptions(
                //           // aspectRatio: 3 / 4,
                //           viewportFraction: 1.0,
                //           enlargeCenterPage: false,
                //           autoPlay: false,
                //           height: responsiveMT(300, 200),
                //           onPageChanged: (index, reason) {
                //             setState(
                //               () {
                //                 _currentIndexBanner = index;
                //               },
                //             );
                //           },
                //         ),
                //         items: imageBanner
                //             .map(
                //               (e) => Row(
                //                 mainAxisSize: MainAxisSize.max,
                //                 children: [
                //                   Expanded(
                //                     child: GestureDetector(
                //                       onTap: () async {
                //                         EasyLoading.show(
                //                           status: '... جاري المعالجة',
                //                           maskType: EasyLoadingMaskType.black,
                //                         );
                //                         Uint8List? bytes;
                //                         logApiModel logapiO = logApiModel();
                //                         logapiO.ControllerName =
                //                             "RamadanCongratulation";
                //                         logapiO.ClassName =
                //                             "RamadanCongratulation";
                //                         logapiO.EmployeeNumber = int.parse(
                //                             EmployeeProfile
                //                                 .getEmployeeNumber());
                //                         logapiO.ActionMethodName =
                //                             "بطاقة تهنئة";
                //                         logapiO.ActionMethodType = 2;
                //                         logapiO.StatusCode = 1;
                //                         logApi(logapiO);
                //                         try {
                //                           await http.get(Uri.parse(
                //                               'https://srv.eamana.gov.sa/EidCongrats/Home/index?employeeNumber=${EmployeeProfile.getEmployeeNumber()}'));
                //                           final ByteData imageData =
                //                               await NetworkAssetBundle(Uri.parse(
                //                                       "https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png"))
                //                                   .load("");

                //                           bytes =
                //                               imageData.buffer.asUint8List();
                //                         } catch (e) {}

                //                         final imageEncoded = base64.encode(bytes
                //                             as Uint8List); // returns base64 string
                //                         ViewFile.open(imageEncoded, ".png");
                //                         setState(() {});
                //                         EasyLoading.dismiss();
                //                       },
                //                       child: Container(
                //                           decoration: BoxDecoration(
                //                             border: Border.all(
                //                                 width: 2.0, color: baseColor),
                //                             color: Colors.white,
                //                           ),
                //                           child: image == true
                //                               ? Image.network(
                //                                   "https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png",
                //                                   height:
                //                                       responsiveMT(300, 200),
                //                                   fit: BoxFit.fill,
                //                                 )
                //                               : Container()),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             )
                //             .toList(),
                //       ),
                //       Container(
                //         margin: EdgeInsets.symmetric(
                //             vertical: 5.0, horizontal: 2.0),
                //         // child: Row(
                //         //   mainAxisAlignment: MainAxisAlignment.center,
                //         //   children: selectsilderBanner.map((urlOfItem2) {
                //         //     int index = selectsilderBanner.indexOf(urlOfItem2);
                //         //     return Container(
                //         //       width: 10.0,
                //         //       height: 10.0,
                //         //       margin: EdgeInsets.symmetric(
                //         //           vertical: 5.0, horizontal: 2.0),
                //         //       decoration: BoxDecoration(
                //         //           shape: BoxShape.circle,
                //         //           color: _currentIndexBanner == index
                //         //               ? baseColor
                //         //               : secondryColor),
                //         //     );
                //         //   }).toList(),
                //         // ),
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Center(
                //             child: Text(
                //               selectsilderTitle.elementAt(_currentIndexBanner) +
                //                   "\n",
                //               style: descTx1(baseColorText),
                //             ),
                //           ),
                //         ],
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

  myDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Center(
          child: AlertDialog(
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.all(0),
            content: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "عاد عيدكم ودامت أفراحكم",
                      style: TextStyle(
                          fontSize: 24,
                          color: baseColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "يمكنكم الآن تهنئة احباءكم عبر الضغط على ",
                        style: TextStyle(
                          fontSize: 14,
                          color: secondryColor,
                        ), //
                      ),
                    ),
                    Center(
                      child: Text(
                        "مشاركة تهنئة العيد اسفل الصفحة",
                        style: TextStyle(
                          fontSize: 14,
                          color: secondryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secondryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("حسناً"),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: baseColor,
                      ),
                      onPressed: () async {
                        EasyLoading.show(
                          status: '... جاري المعالجة',
                          maskType: EasyLoadingMaskType.black,
                        );
                        Uint8List? bytes;
                        logApiModel logapiO = logApiModel();
                        logapiO.ControllerName = "RamadanCongratulation";
                        logapiO.ClassName = "RamadanCongratulation";
                        logapiO.EmployeeNumber =
                            int.parse(EmployeeProfile.getEmployeeNumber());
                        logapiO.ActionMethodName = "بطاقة تهنئة";
                        logapiO.ActionMethodType = 2;
                        logapiO.StatusCode = 1;
                        logApi(logapiO);
                        try {
                          await http.get(Uri.parse(
                              'https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png}'));
                          final ByteData imageData = await NetworkAssetBundle(
                                  Uri.parse(
                                      "https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png"))
                              .load("");

                          bytes = imageData.buffer.asUint8List();
                        } catch (e) {}

                        final imageEncoded = base64.encode(
                            bytes as Uint8List); // returns base64 string
                        ViewFile.open(imageEncoded, ".png");
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text("مشاركة"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
    // sharedPref.setBool("oneTimeDialog", true);
  }
}
