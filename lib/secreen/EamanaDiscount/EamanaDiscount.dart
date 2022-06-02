import 'dart:convert';

import 'package:eamanaapp/secreen/EamanaDiscount/OfferDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class EamanaDiscount extends StatefulWidget {
  bool? navBack;
  EamanaDiscount(this.navBack);
  @override
  _EamanaDiscountState createState() => _EamanaDiscountState();
}

class _EamanaDiscountState extends State<EamanaDiscount> {
  dynamic _OffersList = [];
  //  final DateFormat formatter = DateFormat('yyyy-MM-dd');

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

    //   var respose = await getAction("Offers/GetOffersByStatusID/1");
    var respose = await getAction("Offers/GetActiveOffers/0");

    setState(() {
      _OffersList = (jsonDecode(respose.body)["OffersList"]);

      print(_OffersList);
    });
    EasyLoading.dismiss();
  }

  // List<dynamic> icon = [
  //   "assets/SVGs/offers.svg",
  //   "assets/SVGs/offers.svg",
  //   "assets/SVGs/offers.svg",
  // ];

  var givenDate = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:
            AppBarW.appBarW("عروض الموظفين تجريبي", context, widget.navBack),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            _OffersList == null
                ? Center(
                    child: Text(
                      "لا يوجد عروض",
                      style: subtitleTx(secondryColorText),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ..._OffersList.map(
                          (e) =>
                              // for (int i = 0; i < 10; i++)
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OfferDetails(e)),
                              );
                            },
                            child: Container(
                              height: 120,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: containerdecoration(BackGWhiteColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 100.w <= 375 ? 100 : 120,
                                            child: Stack(
                                              fit: StackFit.loose,
                                              overflow: Overflow.visible,
                                              clipBehavior: Clip.hardEdge,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 5.0,
                                                  ),
                                                  child: Container(
                                                    height: 45,
                                                    width: 110,
                                                    decoration:
                                                        containerdecoration(
                                                            baseColor),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "خصم",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          e["DiscoutRatio"]
                                                                  .toString() +
                                                              "%",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Positioned(
                                                //   top: -9,
                                                //   left: 0.2,
                                                //   child: Container(
                                                //     height: 25,
                                                //     width: 100,
                                                //     decoration:
                                                //         containerdecoration(
                                                //             secondryColor),
                                                //     child: Center(
                                                //         child: Text(
                                                //       e["CategoryName"],
                                                //       style: descTx1(
                                                //           Colors.white),
                                                //     )),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 60,
                                            width: 200,
                                            // color: Colors.amber,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                givenDate.isBefore(
                                                        DateTime.parse(
                                                            e["OfferStartDate"]
                                                                .toString()
                                                                .split("T")[0]))
                                                    ? Text(
                                                        "يبدأ في " +
                                                            e["OfferStartDate"]
                                                                .toString()
                                                                .split("T")[0],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                secondryColorText),
                                                      )
                                                    : Text(
                                                        "صالح لغاية " +
                                                            e["OfferExpiryDate"]
                                                                .toString()
                                                                .split("T")[0],
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                secondryColorText),
                                                      ),
                                                Container(
                                                  child: Text(
                                                    e[
                                                                    "OfferName"]
                                                                .toString()
                                                                .length >=
                                                            22
                                                        ? e["OfferName"]
                                                                .toString()
                                                                .substring(
                                                                    0, 22) +
                                                            " ..."
                                                        : e["OfferName"],
                                                    // overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: secondryColorText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        margin:
                                            EdgeInsets.only(right: 10, top: 3),
                                        child: Text(
                                          // "اسم شركة الخصم المتحدة للقهوة والشاهي",
                                          e["CompanyName"],
                                          overflow: TextOverflow.ellipsis,
                                          style: subtitleTx(baseColorText),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        color: secondryColor,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OfferDetails(e)),
                                          );
                                          // print(e);
                                          // await ViewFile.open(
                                          //     testbase64Pfd, "pdf");
                                        },
                                      ),
                                      // Text(
                                      //   "تفاصيل",
                                      //   style: TextStyle(
                                      //       fontSize: 10,
                                      //       color: secondryColorText,
                                      //       fontWeight: FontWeight.bold),
                                      // )
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
        ),
      ),
    );
  }
}
