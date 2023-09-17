import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/CategoriesFilter.dart';
import 'package:eamanaapp/secreen/EamanaDiscount/OfferDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class EamanaDiscount extends StatefulWidget {
  bool? navBack;
  bool? showappBar;
  EamanaDiscount(this.navBack, this.showappBar);
  @override
  _EamanaDiscountState createState() => _EamanaDiscountState();
}

class _EamanaDiscountState extends State<EamanaDiscount> {
  List<dynamic> _OffersList = [];
  List<dynamic> OffersListfiltred = [];
  List<dynamic> GetCategories = [];
  //  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController _search = TextEditingController();
  int selectedTextIndex = 0;
  List<dynamic> selectedCategories = [];
  List<dynamic> GetCategoriesReversed = [];
  List<dynamic> filteredOffers = []; //store
  var testCateg;
  @override
  void initState() {
    getdata();

    // TODO: implement initState
    super.initState();
  }

  getdata() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      var respose = await getAction("Offers/GetActiveOffers/0");

      var respose2 = await getAction("Offers/GetCategories/");

      setState(() {
        _OffersList = (jsonDecode(respose.body)["OffersList"]) ?? [];
        _OffersList = _OffersList.reversed.toList();
        GetCategories = (jsonDecode(respose2.body)["CategoriesList"]);
        // GetCategories.add({
        //   "CategoryID": GetCategories.length + 1,
        //   "CategoryName": "الكل",
        // });
        // GetCategoriesReversed = GetCategories.reversed.toList();
        filteredOffers = _OffersList;
        print(GetCategories);
        OffersListfiltred = _OffersList;
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "OffersController";
        logapiO.ClassName = "OffersController";
        logapiO.ActionMethodName = "العروض";
        logapiO.ActionMethodType = 1;
        logapiO.StatusCode = 1;
        logApi(logapiO);

        print(_OffersList);
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      _OffersList = [];
      setState(() {});
    }
    //   var respose = await getAction("Offers/GetOffersByStatusID/1");

    EasyLoading.dismiss();
  }

  var givenDate = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  // goToCategoriesPage(BuildContext context) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => CategoriesFilter(GetCategories: GetCategories)),
  //   ).then((value) => updatefilter());
  // }

  // updatefilter() {
  //   OffersListfiltred = [];
  //   bool check = false;
  //   bool hasSelected = false;
  //   // print("wwwwwww = " + GetCategories[0]['selected'].toString());
  //   for (var i = 0; i < _OffersList.length; i++) {
  //     int CategoryID = _OffersList[i]['CategoryID'];
  //     for (var x = 0; x < GetCategories.length; x++) {
  //       if (GetCategories[x]['CategoryID'] == CategoryID) {
  //         check = GetCategories[x]['selected'] ?? false;
  //       }
  //       if (GetCategories[x]['selected'] != null &&
  //           GetCategories[x]['selected'] == true) {
  //         hasSelected = true;
  //       }
  //     }

  //     // bool check = GetCategories.contains(_OffersList[i]['CategoryID']);
  //     //  = GetCategories[] ?? false;
  //     print(check);
  //     if (check) {
  //       OffersListfiltred.add(_OffersList[i]);
  //       print(OffersListfiltred);
  //     }
  //   }
  //   print(hasSelected);

  //   OffersListfiltred = OffersListfiltred.isEmpty && hasSelected == false
  //       ? _OffersList
  //       : OffersListfiltred;
  //   setState(() {});
  // }

  void filterOffers() {
    setState(() {
      if (selectedCategories.isEmpty) {
        filteredOffers = List<dynamic>.from(_OffersList);
      } else {
        filteredOffers = _OffersList.where((offer) => selectedCategories.any(
            (category) => offer["CategoryName"].contains(category))).toList();
      }
    });
  }

  void toggleItem(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
      filterOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      // child: Scaffold(
      //   appBar: AppBarW.appBarW(
      //       "عروض الموظفين", context, widget.navBack, goToCategoriesPage),
      //   body: Stack(
      //     children: [
      //       widgetsUni.bacgroundimage(),
      //       OffersListfiltred.length == 0
      //           ? Center(
      //               child: Text(
      //                 "لا يوجد عروض",
      //                 style: subtitleTx(secondryColorText),
      //               ),
      //             )
      //           : SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   ...OffersListfiltred.map(
      //                     (e) => GestureDetector(
      //                       onTap: () {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                               builder: (context) => OfferDetails(e)),
      //                         );
      //                       },
      //                       child: Stack(
      //                         children: [
      //                           Container(
      //                             height: 120,
      //                             margin: EdgeInsets.symmetric(
      //                                 horizontal: 5, vertical: 5),
      //                             decoration:
      //                                 containerdecoration(BackGWhiteColor),
      //                             child: Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceAround,
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.center,
      //                               children: [
      //                                 Column(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.center,
      //                                   children: [
      //                                     Row(
      //                                       children: [
      //                                         Container(
      //                                           width: 100.w <= 375 ? 100 : 120,
      //                                           child: Stack(
      //                                             fit: StackFit.loose,
      //                                             overflow: Overflow.visible,
      //                                             clipBehavior: Clip.hardEdge,
      //                                             children: [
      //                                               Padding(
      //                                                 padding:
      //                                                     const EdgeInsets.only(
      //                                                   right: 5.0,
      //                                                 ),
      //                                                 child: Container(
      //                                                   height: 45,
      //                                                   width: 110,
      //                                                   decoration:
      //                                                       containerdecoration(
      //                                                           baseColor),
      //                                                   child: Row(
      //                                                     crossAxisAlignment:
      //                                                         CrossAxisAlignment
      //                                                             .center,
      //                                                     mainAxisAlignment:
      //                                                         MainAxisAlignment
      //                                                             .spaceEvenly,
      //                                                     children: [
      //                                                       Text(
      //                                                         "خصم",
      //                                                         style: TextStyle(
      //                                                             color: Colors
      //                                                                 .white,
      //                                                             fontSize: 15,
      //                                                             fontWeight:
      //                                                                 FontWeight
      //                                                                     .bold),
      //                                                       ),
      //                                                       Text(
      //                                                         e["DiscoutRatio"]
      //                                                                 .toString() +
      //                                                             "%",
      //                                                         style: TextStyle(
      //                                                             color: Colors
      //                                                                 .white,
      //                                                             fontSize: 20,
      //                                                             fontWeight:
      //                                                                 FontWeight
      //                                                                     .bold),
      //                                                       ),
      //                                                     ],
      //                                                   ),
      //                                                 ),
      //                                               ),
      //                                               // Positioned(
      //                                               //   top: -9,
      //                                               //   left: 0.2,
      //                                               //   child: Container(
      //                                               //     height: 25,
      //                                               //     width: 100,
      //                                               //     decoration:
      //                                               //         containerdecoration(
      //                                               //             secondryColor),
      //                                               //     child: Center(
      //                                               //         child: Text(
      //                                               //       e["CategoryName"],
      //                                               //       style: descTx1(
      //                                               //           Colors.white),
      //                                               //     )),
      //                                               //   ),
      //                                               // ),
      //                                             ],
      //                                           ),
      //                                         ),
      //                                         SizedBox(
      //                                           width: 5,
      //                                         ),
      //                                         Container(
      //                                           height: 60,
      //                                           width: 200,
      //                                           // color: Colors.amber,
      //                                           child: Column(
      //                                             crossAxisAlignment:
      //                                                 CrossAxisAlignment.start,
      //                                             children: [
      //                                               // Text((DateTime.parse(
      //                                               //                 e["OfferExpiryDate"]
      //                                               //                     .toString()
      //                                               //                     .split(
      //                                               //                         "T")[0])
      //                                               //             .difference(
      //                                               //                 givenDate)
      //                                               //             .inDays +
      //                                               //         1)
      //                                               //     .toString()),
      //                                               givenDate.isBefore(
      //                                                       DateTime.parse(
      //                                                           e["OfferStartDate"]
      //                                                               .toString()
      //                                                               .split(
      //                                                                   "T")[0]))
      //                                                   ? Text(
      //                                                       "يبدأ في " +
      //                                                           e["OfferStartDate"]
      //                                                               .toString()
      //                                                               .split(
      //                                                                   "T")[0],
      //                                                       style: TextStyle(
      //                                                           fontSize: 14,
      //                                                           color:
      //                                                               secondryColorText),
      //                                                     )
      //                                                   : Text(
      //                                                       "صالح لغاية " +
      //                                                           e["OfferExpiryDate"]
      //                                                               .toString()
      //                                                               .split(
      //                                                                   "T")[0],
      //                                                       style: TextStyle(
      //                                                           fontSize: 14,
      //                                                           color:
      //                                                               secondryColorText),
      //                                                     ),

      //                                               Container(
      //                                                 child: Text(
      //                                                   e["OfferName"]
      //                                                               .toString()
      //                                                               .length >=
      //                                                           22
      //                                                       ? e["OfferName"]
      //                                                               .toString()
      //                                                               .substring(
      //                                                                   0, 22) +
      //                                                           " ..."
      //                                                       : e["OfferName"],
      //                                                   // overflow: TextOverflow.ellipsis,
      //                                                   textAlign:
      //                                                       TextAlign.right,
      //                                                   maxLines: 1,
      //                                                   style: TextStyle(
      //                                                     fontSize: 14,
      //                                                     color:
      //                                                         secondryColorText,
      //                                                   ),
      //                                                 ),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         )
      //                                       ],
      //                                     ),
      //                                     Container(
      //                                       // color: Colors.amber,
      //                                       width: MediaQuery.of(context)
      //                                               .size
      //                                               .width *
      //                                           0.8,
      //                                       margin: EdgeInsets.only(
      //                                           right: 10, top: 3),
      //                                       child: Text(
      //                                         // "اسم شركة الخصم المتحدة للقهوة والشاهي",
      //                                         e["CompanyName"],
      //                                         overflow: TextOverflow.ellipsis,
      //                                         style: subtitleTx(baseColorText),
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                                 Column(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.center,
      //                                   children: [
      //                                     IconButton(
      //                                       color: secondryColor,
      //                                       icon: Icon(
      //                                         Icons.arrow_forward_ios_rounded,
      //                                         size: 20,
      //                                       ),
      //                                       onPressed: () async {
      //                                         Navigator.push(
      //                                           context,
      //                                           MaterialPageRoute(
      //                                               builder: (context) =>
      //                                                   OfferDetails(e)),
      //                                         );
      //                                         // print(e);
      //                                         // await ViewFile.open(
      //                                         //     testbase64Pfd, "pdf");
      //                                       },
      //                                     ),
      //                                     // Text(
      //                                     //   "تفاصيل",
      //                                     //   style: TextStyle(
      //                                     //       fontSize: 10,
      //                                     //       color: secondryColorText,
      //                                     //       fontWeight: FontWeight.bold),
      //                                     // )
      //                                   ],
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                           givenDate.isBefore(DateTime.parse(
      //                                   e["OfferStartDate"]
      //                                       .toString()
      //                                       .split("T")[0]))
      //                               ? Positioned(
      //                                   left: 6,
      //                                   top: 12,
      //                                   child: Container(
      //                                     decoration: BoxDecoration(
      //                                       color: secondryColor,
      //                                       borderRadius: BorderRadius.only(
      //                                         bottomRight:
      //                                             new Radius.circular(20),
      //                                         topRight: new Radius.circular(20),
      //                                       ),
      //                                     ),
      //                                     width: 95,
      //                                     // color: Colors.blue.shade900,
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.symmetric(
      //                                           horizontal: 8, vertical: 5),
      //                                       child: Row(
      //                                         children: [
      //                                           // Text(
      //                                           //   "",
      //                                           //   textAlign: TextAlign.right,
      //                                           //   style: descTx1(Colors.white),
      //                                           // ),
      //                                           Text(
      //                                             "يبدأ بعد " +
      //                                                 (DateTime.parse(e["OfferStartDate"]
      //                                                                     .toString()
      //                                                                     .split(
      //                                                                         "T")[
      //                                                                 0])
      //                                                             .difference(
      //                                                                 givenDate)
      //                                                             .inDays +
      //                                                         1)
      //                                                     .toString() +
      //                                                 " يوم",
      //                                             textAlign: TextAlign.right,
      //                                             style: descTx1(Colors.white),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 )
      //                               : Positioned(
      //                                   left: 6,
      //                                   top: 12,
      //                                   child: Container(
      //                                     decoration: BoxDecoration(
      //                                       color: redColor,
      //                                       borderRadius: BorderRadius.only(
      //                                         bottomRight:
      //                                             new Radius.circular(20),
      //                                         topRight: new Radius.circular(20),
      //                                       ),
      //                                     ),
      //                                     width: 95,
      //                                     // color: Colors.blue.shade900,
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.symmetric(
      //                                           horizontal: 8, vertical: 5),
      //                                       child: Row(
      //                                         children: [
      //                                           // Text(
      //                                           //   "",
      //                                           //   textAlign: TextAlign.right,
      //                                           //   style: descTx1(Colors.white),
      //                                           // ),
      //                                           Text(
      //                                             "تبقى " +
      //                                                 (DateTime.parse(e["OfferExpiryDate"]
      //                                                                     .toString()
      //                                                                     .split(
      //                                                                         "T")[
      //                                                                 0])
      //                                                             .difference(
      //                                                                 givenDate)
      //                                                             .inDays +
      //                                                         1)
      //                                                     .toString() +
      //                                                 " يوم",
      //                                             textAlign: TextAlign.right,
      //                                             style: descTx1(Colors.white),
      //                                           ),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ),
      //                                 ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             )
      //     ],
      //   ),
      // ),

      child: Scaffold(
        appBar: AppBarW.appBarW(" العروض", context, widget.showappBar),
        body: Column(
          children: [
            Container(
              width: 400,
              // Categories List:
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategories.clear();
                                    filterOffers();
                                  });
                                },
                                child: Container(
                                    child: Text(
                                      "الكل",
                                      style: fontsStyle.px16(
                                          fontsStyle.thirdColor(),
                                          FontWeight.normal),
                                    ),
                                    decoration: selectedCategories.isEmpty
                                        ? BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: fontsStyle.baseColor(),
                                                width: 2,
                                              ),
                                            ),
                                          )
                                        : BoxDecoration()),
                              ),
                              for (var category in GetCategories)
                                Container(
                                  padding: EdgeInsets.all(12),
                                  child: GestureDetector(
                                    onTap: () =>
                                        toggleItem(category["CategoryName"]),
                                    child: Container(
                                        child: Text(
                                          category["CategoryName"],
                                          style: fontsStyle.px16(
                                              fontsStyle.thirdColor(),
                                              FontWeight.normal),
                                        ),
                                        decoration: selectedCategories.contains(
                                                category["CategoryName"])
                                            ? BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        fontsStyle.baseColor(),
                                                    width: 2,
                                                  ),
                                                ),
                                              )
                                            : BoxDecoration()),
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
            filteredOffers.length == 0
                ? Center(
                    child: Text("لا يوجد عروض"),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredOffers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OfferDetails(filteredOffers[index]),
                                    ));
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 360,
                                      // height: 104,
                                      padding: EdgeInsets.all(17),
                                      decoration: BoxDecoration(
                                        color: BackGColor,
                                        borderRadius: BorderRadius.circular(7),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                14, 31, 53, 0.12),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    filteredOffers[index]
                                                        ["CompanyName"],
                                                    style: fontsStyle.px16(
                                                      fontsStyle.thirdColor(),
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "خصم " +
                                                      filteredOffers[index]
                                                              ["DiscoutRatio"]
                                                          .toString()
                                                          .split(".")[0] +
                                                      " %",
                                                  style: fontsStyle.px16(
                                                      fontsStyle.HeaderColor(),
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  filteredOffers[index]
                                                      ["CategoryName"],
                                                  style: fontsStyle.px13(
                                                      fontsStyle.thirdColor(),
                                                      FontWeight.normal),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 16, 0, 0),
                                                  child: Text(
                                                    "ينتهي بتاريخ " +
                                                        filteredOffers[index][
                                                                "OfferExpiryDate"]
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
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> getOffersSearchFunction() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    // if (sharedPref.getString("dumyuser") != "10284928492") {
    //   bool hasinfo = await Provider.of<EmpInfoProvider>(context, listen: false)
    //       .fetchEmpInfo(_search.text.trim());
    //   logApiModel logapiO = logApiModel();
    //   logapiO.ControllerName = "DaleelController";
    //   logapiO.ClassName = "DaleelController";
    //   logapiO.ActionMethodName = "دليل الموظفين";
    //   logapiO.ActionMethodType = 1;
    //   logapiO.StatusCode = 1;
    //   logApi(logapiO);
    //   if (hasinfo == false) {
    //     Alert(
    //       context: context,
    //       type: AlertType.warning,
    //       title: "",
    //       desc: "لايوجد موظفين",
    //       buttons: [
    //         DialogButton(
    //           child: Text(
    //             "حسنا",
    //             style: TextStyle(color: Colors.white, fontSize: 20),
    //           ),
    //           onPressed: () => Navigator.pop(context),
    //           width: 120,
    //         )
    //       ],
    //     ).show();
    //   }
    // } else {
    //   await Future.delayed(Duration(seconds: 1));
    //   Alert(
    //     context: context,
    //     type: AlertType.warning,
    //     title: "",
    //     desc: "لايوجد موظفين",
    //     buttons: [
    //       DialogButton(
    //         child: Text(
    //           "حسنا",
    //           style: TextStyle(color: Colors.white, fontSize: 20),
    //         ),
    //         onPressed: () => Navigator.pop(context),
    //         width: 120,
    //       )
    //     ],
    //   ).show();
    // }

    EasyLoading.dismiss();
  }

  Widget ClickableCategoriesList(int index, String text) {
    bool isSelected = index == selectedTextIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTextIndex = index;
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5),
        decoration: isSelected
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: fontsStyle.baseColor(),
                    width: 2,
                  ),
                ),
              )
            : BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: Text(
            text,
            style: fontsStyle.px14(fontsStyle.thirdColor(), FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
