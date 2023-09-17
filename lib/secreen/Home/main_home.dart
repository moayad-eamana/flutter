import 'dart:convert';
import 'dart:typed_data';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/OfferDetails.dart';
import 'package:eamanaapp/secreen/services/ListViewServices.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/searchX.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/utilities/ActionOfServices.dart';
import 'package:eamanaapp/utilities/functions/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

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

  List<dynamic> OffersListfiltred = [];
  List<dynamic> _OffersList = [];

  bool isloading = true;

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    setState(() {});
    if (sharedPref.getBool("imageLoad2023-23-jun") == null) {
      sharedPref.setBool("imageLoad2023-23-jun", true);
      await http.get(Uri.parse(
          'https://srv.eamana.gov.sa/EidCongrats/Home/index?employeeNumber=${EmployeeProfile.getEmployeeNumber()}'));
      image = true;
    } else {
      image = true;
    }
    // myDialog(); // --> test
    var v = sharedPref.getBool("imageLoad2023-23-jun");
    if (v == null) {
      myDialog();
      sharedPref.setBool("imageLoad2023-23-jun", false);
    }
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

    getdata();

    print("object");
    super.initState();
  }

  getdata() async {
    // EasyLoading.show(
    //   status: '... جاري المعالجة',
    //   maskType: EasyLoadingMaskType.black,
    // );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      var respose = await getAction("Offers/GetActiveOffers/0");

      var respose2 = await getAction("Offers/GetCategories/");

      setState(() {
        _OffersList = (jsonDecode(respose.body)["OffersList"]) ?? [];
        _OffersList = _OffersList.reversed.toList();
        // GetCategories = (jsonDecode(respose2.body)["CategoriesList"]);
        // GetCategories.add({
        //   "CategoryID": GetCategories.length + 1,
        //   "CategoryName": "الكل",
        // });
        // GetCategoriesReversed = GetCategories.reversed.toList();
        // selectedTextIndex = GetCategories.length;
        // print(GetCategories);

        //  OffersListfiltred = _OffersList;
        _OffersList.sort((a, b) => b["OfferID"].compareTo(a["OfferID"]));
        OffersListfiltred.add(_OffersList[0]);
        OffersListfiltred.add(_OffersList[1]);
        OffersListfiltred.add(_OffersList[2]);

        // logApiModel logapiO = logApiModel();
        // logapiO.ControllerName = "OffersController";
        // logapiO.ClassName = "OffersController";
        // logapiO.ActionMethodName = "العروض";
        // logapiO.ActionMethodType = 1;
        // logapiO.StatusCode = 1;
        // logApi(logapiO);

        // _OffersList = _OffersList.where((element) => null);

        //  _OffersList = _OffersList.sort((a, b) => a.compareTo(b));

        // _OffersList.sort((a, b) {
        //   //sorting in ascending order
        //   return DateTime.parse(a["OfferExpiryDate"])
        //       .compareTo(DateTime.parse(b["OfferExpiryDate"]));
        // });

        print(_OffersList);
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      _OffersList = [];
      setState(() {});
    }
    //   var respose = await getAction("Offers/GetOffersByStatusID/1");
    // EasyLoading.dismiss();
    setState(() {
      isloading = false;
    });
  }

  EmployeeProfile empinfo = new EmployeeProfile();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/71807696/flutter-future-delayed-on-endless-loop 😅
    // but it is not working with favs.dart
    // Future.delayed(Duration.zero).then((value) {
    listOfServices list = listOfServices(context);
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
                //my dialog:

                SizedBox(
                  height: responsiveMT(220, 130),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          SizerUtil.deviceType == DeviceType.mobile ? 10 : 120,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVGs/Vector-60.svg',
                          // height: 20,
                          width: 4,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "الخدمات الأكثر إستخداما",
                          style: fontsStyle.px14(
                              Color(0xFF454141), FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StaggeredGrid.count(
                      crossAxisCount:
                          SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0,
                      children: [
                        StaggeredGridTileW(
                            1,
                            SizerUtil.deviceType == DeviceType.mobile
                                ? 120
                                : 140,
                            widgetsUni.servicebuttonMainPage(
                                list.AllService()[0]["service_name"],
                                list.AllService()[0]["icon"],
                                list.AllService()[0]["Action"] == null
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListViewServices(
                                                      list.AllService()[0]
                                                          ["List"],
                                                      list.AllService()[0]
                                                          ["service_name"])),
                                        );
                                      }
                                    : list.AllService()[0]["Action"])),

                        StaggeredGridTileW(
                            1,
                            SizerUtil.deviceType == DeviceType.mobile
                                ? 120
                                : 140,
                            widgetsUni.servicebuttonMainPage(
                                list.AllService()[4]["service_name"],
                                list.AllService()[4]["icon"],
                                list.AllService()[4]["Action"] == null
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListViewServices(
                                                      list.AllService()[4]
                                                          ["List"],
                                                      list.AllService()[4]
                                                          ["service_name"])),
                                        );
                                      }
                                    : list.AllService()[4]["Action"])),

                        StaggeredGridTileW(
                            1,
                            SizerUtil.deviceType == DeviceType.mobile
                                ? 120
                                : 140,
                            widgetsUni.servicebuttonMainPage(
                                list.AllService()[3]["service_name"],
                                list.AllService()[3]["icon"],
                                list.AllService()[3]["Action"] == null
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListViewServices(
                                                      list.AllService()[3]
                                                          ["List"],
                                                      list.AllService()[3]
                                                          ["service_name"])),
                                        );
                                      }
                                    : list.AllService()[3]["Action"])),

                        SizedBox(
                          height: 20,
                        )

                        // ...list.AllService().map((e) {
                        //   if (e["service_name"] == "الإجازات" ||
                        //       e["service_name"] == "دليل الموظفين" ||
                        //       e["service_name"] == "المناسبات") {
                        //     return StaggeredGridTileW(
                        //         1,
                        //         SizerUtil.deviceType == DeviceType.mobile
                        //             ? 120
                        //             : 140,
                        //         widgetsUni.servicebuttonMainPage(
                        //             e["service_name"],
                        //             e["icon"],
                        //             e["Action"] == null
                        //                 ? () {
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                           builder: (context) =>
                        //                               ListViewServices(
                        //                                   e["List"],
                        //                                   e["service_name"])),
                        //                     );
                        //                   }
                        //                 : e["Action"]));
                        //   }  else{
                        //     return Container();
                        //   }
                        // }),
                      ],
                    ),
                  ],
                ),
                Offers(),

                // SizedBox(
                //   height: 10,
                // ),
                // if (id != 0101)
                //   Row(
                //     children: [
                //       Text(
                //         listofFavs.length == 0 ? "خدمة سريعة" : "المفضلة",
                //         style: titleTx(baseColorText),
                //       ),
                //       Expanded(
                //         child: Container(
                //             // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                //             child: Divider(
                //           color: baseColorText,
                //           height: 20,
                //           thickness: 1,
                //           indent: 5,
                //           endIndent: 5,
                //         )),
                //       ),
                //     ],
                //   ),
                // SizedBox(
                //   height: 10,
                // ),
                // if (id != 0101)
                //   Row(
                //     children: [
                //       Expanded(
                //         child: SingleChildScrollView(
                //           controller: _scrollController,
                //           scrollDirection: Axis.horizontal,
                //           child: Container(
                //             height: 65,
                //             child: listofFavs.length > 0
                //                 ? Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                         ...listofFavs.map((e) =>
                //                             servicebuttonFavs(e, context)),
                //                       ])
                //                 : Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceAround,
                //                     children: [
                //                       ...listOfServices(context)
                //                           .fastservices()
                //                           .map((e) =>
                //                               servicebuttonFavs(e, context)),
                //                     ],
                //                   ),
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //         icon: Icon(
                //           Icons.arrow_forward_ios_rounded,
                //           color: baseColorText,
                //         ),
                //         onPressed: () {
                //           _scrollController.animateTo(
                //               _scrollController.position.maxScrollExtent,
                //               duration: Duration(milliseconds: 1000),
                //               curve: Curves.ease);
                //         },
                //       ),
                //     ],
                //   ),
                // SizedBox(
                //   height: 2.h,
                // ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: BackGWhiteColor,
                //     border: Border.all(
                //       color: bordercolor,
                //     ),
                //     //color: baseColor,
                //     borderRadius: BorderRadius.all(
                //       new Radius.circular(4),
                //     ),
                //   ),
                //   //color: Colors.red,
                //   height: responsiveMT(320, 500),
                //   width: 100.w,
                //   child: Stack(
                //     children: [
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //   crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           SizedBox(
                //             height: 5,
                //           ),
                //           Text(
                //             "الخدمات الرئیسیة",
                //             style: titleTx(baseColor),
                //           ),
                //           CarouselSlider(
                //             options: CarouselOptions(
                //               viewportFraction: 1.0,
                //               enlargeCenterPage: false,
                //               height: responsiveMT(200, 400),
                //               onPageChanged: (index, reason) {
                //                 setState(
                //                   () {
                //                     _currentIndex = index;
                //                   },
                //                 );
                //               },
                //             ),
                //             items: SliderWidget.sliderw(context, id),
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: selectsilder.map((urlOfItem) {
                //               int index = selectsilder.indexOf(urlOfItem);
                //               return Container(
                //                 width: 10.0,
                //                 height: 10.0,
                //                 margin: EdgeInsets.symmetric(
                //                     vertical: 10.0, horizontal: 2.0),
                //                 decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: _currentIndex == index
                //                         ? baseColor
                //                         : secondryColor),
                //               );
                //             }).toList(),
                //           ),
                //         ],
                //       ),
                //       Positioned(
                //         left: 10,
                //         bottom: 10,
                //         child: Image(
                //             width: responsiveMT(40, 120),
                //             //height: responsiveMT(30, 100),
                //             image:
                //                 AssetImage("assets/image/rakamy-logo-21.png")),
                //       ),
                //       Positioned(
                //           right: 10,
                //           bottom: 10,
                //           child: InkWell(
                //             onTap: () {
                //               widget.goto();
                //             },
                //             child: Text(
                //               "> عرض جميع الخدمات",
                //               style: descTx2(baseColor),
                //             ),
                //           )),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // if (showImage)
                //   Row(
                //     children: [
                //       Text(
                //         "مشاركة تهنئة بطاقة العيد",
                //         style: titleTx(baseColorText),
                //       ),
                //       Expanded(
                //         child: Container(
                //             // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                //             child: Divider(
                //           color: baseColorText,
                //           height: 20,
                //           thickness: 1,
                //           indent: 5,
                //           endIndent: 5,
                //         )),
                //       ),
                //     ],
                //   ),
                // SizedBox(
                //   height: 10,
                // ),
                // if (showImage)
                //   Container(
                //     decoration: containerdecoration(BackGWhiteColor),
                //     child: Column(
                //       children: [
                //         CarouselSlider(
                //           options: CarouselOptions(
                //             // aspectRatio: 3 / 4,
                //             viewportFraction: 1.0,
                //             enlargeCenterPage: false,
                //             autoPlay: false,
                //             height: responsiveMT(300, 200),
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
                //                       child: GestureDetector(
                //                         onTap: () async {
                //                           EasyLoading.show(
                //                             status: '... جاري المعالجة',
                //                             maskType: EasyLoadingMaskType.black,
                //                           );
                //                           Uint8List? bytes;
                //                           logApiModel logapiO = logApiModel();
                //                           logapiO.ControllerName =
                //                               "RamadanCongratulation";
                //                           logapiO.ClassName =
                //                               "RamadanCongratulation";
                //                           logapiO.EmployeeNumber = int.parse(
                //                               EmployeeProfile
                //                                   .getEmployeeNumber());
                //                           logapiO.ActionMethodName =
                //                               "بطاقة تهنئة";
                //                           logapiO.ActionMethodType = 2;
                //                           logapiO.StatusCode = 1;
                //                           logApi(logapiO);
                //                           try {
                //                             await http.get(Uri.parse(
                //                                 'https://srv.eamana.gov.sa/EidCongrats/Home/index?employeeNumber=${EmployeeProfile.getEmployeeNumber()}'));
                //                             final ByteData imageData =
                //                                 await NetworkAssetBundle(Uri.parse(
                //                                         "https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png"))
                //                                     .load("");

                //                             bytes =
                //                                 imageData.buffer.asUint8List();
                //                           } catch (e) {}

                //                           final imageEncoded = base64.encode(bytes
                //                               as Uint8List); // returns base64 string
                //                           ViewFile.open(imageEncoded, ".png");
                //                           setState(() {});
                //                           EasyLoading.dismiss();
                //                         },
                //                         child: Container(
                //                             decoration: BoxDecoration(
                //                               border: Border.all(
                //                                   width: 2.0, color: baseColor),
                //                               color: Colors.white,
                //                             ),
                //                             child: image == true
                //                                 ? Image.network(
                //                                     "https://srv.eamana.gov.sa/EidCongrats/Content/Files/${EmployeeProfile.getEmployeeNumber()}.png",
                //                                     height:
                //                                         responsiveMT(300, 200),
                //                                     fit: BoxFit.fill,
                //                                   )
                //                                 : Container()),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //         Container(
                //           margin: EdgeInsets.symmetric(
                //               vertical: 5.0, horizontal: 2.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: selectsilderBanner.map((urlOfItem2) {
                //               int index =
                //                   selectsilderBanner.indexOf(urlOfItem2);
                //               return Container(
                //                 width: 10.0,
                //                 height: 10.0,
                //                 margin: EdgeInsets.symmetric(
                //                     vertical: 5.0, horizontal: 2.0),
                //                 decoration: BoxDecoration(
                //                     shape: BoxShape.circle,
                //                     color: _currentIndexBanner == index
                //                         ? baseColor
                //                         : secondryColor),
                //               );
                //             }).toList(),
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Center(
                //               child: Text(
                //                 selectsilderTitle
                //                         .elementAt(_currentIndexBanner) +
                //                     "\n",
                //                 style: descTx1(baseColorText),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Offers() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/SVGs/Vector-60.svg',
              // height: 20,
              width: 4,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "أحدث العروض",
              style: fontsStyle.px14(Color(0xFF454141), FontWeight.bold),
            ),
          ],
        ),
        isloading == true
            ? Container(
                margin: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator())
            : OffersListfiltred.length == 0
                ? Text("لايوجد عروض")
                : Column(
                    children: [
                      ...OffersListfiltred.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfferDetails(e)));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: BackGColor,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(14, 31, 53, 0.12),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e["CompanyName"],
                                            style: fontsStyle.px16(
                                              fontsStyle.thirdColor(),
                                              FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "خصم " +
                                              e["DiscoutRatio"]
                                                  .toString()
                                                  .split(".")[0] +
                                              " %",
                                          style: fontsStyle.px16(
                                              fontsStyle.HeaderColor(),
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          e["CategoryName"],
                                          style: fontsStyle.px13(
                                              fontsStyle.thirdColor(),
                                              FontWeight.normal),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 16, 0, 16),
                                          child: Text(
                                            "ينتهي بتاريخ " +
                                                e["OfferExpiryDate"]
                                                    .toString()
                                                    .split("T")[0],
                                            style: fontsStyle.px13(
                                                fontsStyle.thirdColor(),
                                                FontWeight.normal),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
        SizedBox(
          height: 10,
        ),
        // OffersListfiltred.length == 0
        //     ? Center(
        //         child: Text("لا يوجد عروض"),
        //       )
        //     : Column(
        //         children: [
        //           ...OffersListfiltred.map((e) => GestureDetector(
        //                 onTap: () {
        //                   Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => OfferDetails(e)));
        //                 },
        //                 child: Stack(
        //                   children: [
        //                     Padding(
        //                       padding:
        //                           const EdgeInsets.symmetric(vertical: 8.0),
        //                       child: Container(
        //                         width: 360,
        //                         // height: 104,
        //                         padding: EdgeInsets.all(16),
        //                         decoration: BoxDecoration(
        //                           color: BackGColor,
        //                           borderRadius: BorderRadius.circular(7),
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: Color.fromRGBO(14, 31, 53, 0.12),
        //                               blurRadius: 2,
        //                             ),
        //                           ],
        //                         ),
        //                         child: Container(
        //                           child: Column(
        //                             children: [
        //                               Row(
        //                                 mainAxisAlignment:
        //                                     MainAxisAlignment.spaceBetween,
        //                                 children: [
        //                                   Expanded(
        //                                     child: Text(
        //                                       e["CompanyName"],
        //                                       style: fontsStyle.px16(
        //                                         fontsStyle.thirdColor(),
        //                                         FontWeight.bold,
        //                                       ),
        //                                     ),
        //                                   ),
        //                                   Text(
        //                                     "خصم " +
        //                                         e["DiscoutRatio"]
        //                                             .toString()
        //                                             .split(".")[0] +
        //                                         " %",
        //                                     style: fontsStyle.px16(
        //                                         fontsStyle.HeaderColor(),
        //                                         FontWeight.bold),
        //                                   ),
        //                                 ],
        //                               ),
        //                               Row(
        //                                 children: [
        //                                   Text(
        //                                     e["CategoryName"],
        //                                     style: fontsStyle.px13(
        //                                         fontsStyle.thirdColor(),
        //                                         FontWeight.normal),
        //                                   )
        //                                 ],
        //                               ),
        //                               Row(
        //                                 children: [
        //                                   Container(
        //                                     margin: EdgeInsets.fromLTRB(
        //                                         0, 16, 0, 16),
        //                                     child: Text(
        //                                       "ينتهي بتاريخ " +
        //                                           e["OfferExpiryDate"]
        //                                               .toString()
        //                                               .split("T")[0],
        //                                       style: fontsStyle.px13(
        //                                           fontsStyle.thirdColor(),
        //                                           FontWeight.normal),
        //                                     ),
        //                                   )
        //                                 ],
        //                               )
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ))
        //         ],
        //       ),
      ],
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
