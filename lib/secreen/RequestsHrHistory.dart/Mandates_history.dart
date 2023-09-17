import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/Mandates_history_detailes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/convertDaysAndMonthToAR.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:intl/intl.dart' as date;
import 'package:sizer/sizer.dart';

class Mandates_history extends StatefulWidget {
  const Mandates_history({Key? key}) : super(key: key);

  @override
  State<Mandates_history> createState() => _Mandates_historyState();
}

class _Mandates_historyState extends State<Mandates_history>
    with TickerProviderStateMixin {
  dynamic list = [];
  late List<AnimationController> dataCtrl;
  @override
  void initState() {
    super.initState();
    dataCtrl = List.generate(
        100,
        (int index) => AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 300),
              upperBound: 0.5,
            ));
    getInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  getInfo() async {
    if (sharedPref.getString("dumyuser") != "10284928492") {
      String Empno =
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0];
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      list = await getAction("HR/GetUserMandates/" + Empno);
      EasyLoading.dismiss();
      if (jsonDecode(list.body)["ErrorMessage"] == null) {
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "MandatesController";
        logapiO.ClassName = "MandatesController";
        logapiO.ActionMethodName = "عرض طلبات الإنتداب";
        logapiO.ActionMethodType = 1;
        logapiO.StatusCode = 1;
        logApi(logapiO);
        list = jsonDecode(list.body)["MandatesList"] ?? [];
      } else {
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "MandatesController";
        logapiO.ClassName = "MandatesController";
        logapiO.ActionMethodName = "عرض طلبات الإنتداب";
        logapiO.ActionMethodType = 1;
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(list.body)["ErrorMessage"];
        logApi(logapiO);
      }
    } else {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      await Future.delayed(Duration(seconds: 1));
      list = [];
      EasyLoading.dismiss();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إنتداباتي", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            list.length > 0
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Mandates_history_detailes(list[index]);
                              }));
                            },
                            child: ExpandableTheme(
                              data: const ExpandableThemeData(
                                iconPlacement:
                                    ExpandablePanelIconPlacement.right,
                                useInkWell: true,
                                hasIcon: false,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7),
                                          bottomLeft: Radius.circular(7),
                                          bottomRight: Radius.circular(7)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0E1F35)
                                              .withOpacity(0.06),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    // color: Colors.white,
                                    child: ExpandablePanel(
                                      header: Listener(
                                        behavior: HitTestBehavior.opaque,
                                        onPointerDown: (e) {
                                          if (list[index]["_expanded"] ==
                                                  null ||
                                              list[index]["_expanded"] ==
                                                  false) {
                                            dataCtrl[index]..forward(from: 0.0);
                                          } else {
                                            dataCtrl[index]..reverse(from: 0.5);
                                          }

                                          print(list[index]["_expanded"]);
                                          list[index]["_expanded"] =
                                              list[index]["_expanded"] == null
                                                  ? true
                                                  : !(list[index]["_expanded"]);
                                          print(list[index]["_expanded"]);
                                          //   setState(() {});
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      list[index]
                                                          ["MandateLocation"],
                                                      style: fontsStyle.px13(
                                                          Color(0xff838383),
                                                          FontWeight.w500),
                                                    ),
                                                    Text(
                                                      (dayString(list[index]
                                                              ["StartDateG"]) +
                                                          "-" +
                                                          (dayString(list[index]
                                                              ["EndDateG"]))),
                                                      style: fontsStyle.px13(
                                                          Color(0xff000000),
                                                          FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      width: 80.w,
                                                      // color: Colors.amber,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              color: Color(
                                                                  0xffF3F3F3),
                                                            ),
                                                            child: Text(
                                                              list[index][
                                                                  "MandateStatus"],
                                                              style: fontsStyle.px13(
                                                                  Color(
                                                                      0xff9699A1),
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                          RotationTransition(
                                                            turns: Tween(
                                                                    begin: 0.0,
                                                                    end: 1.0)
                                                                .animate(
                                                                    dataCtrl[
                                                                        index]),
                                                            child: IconButton(
                                                              icon: Icon(Icons
                                                                  .expand_more),
                                                              onPressed: () {
                                                                setState(() {});
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                // Text("معلقة"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      collapsed: SizedBox(
                                        height: 0,
                                        child: Text(
                                          "",
                                          //  softWrap: true,
                                          //  maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      expanded: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 100.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widgetsUni.divider2(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    titleText("تاريخ البداية"),
                                                    titleText("تاريخ النهاية"),
                                                    titleText("مكان الإنتداب"),
                                                    titleText("نوع الإنتداب"),
                                                    titleText("عدد الأيام"),
                                                    titleText("رقم الطلب"),
                                                    titleText("حالة الطلب"),
                                                    titleText("الملاحظات"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      titleText2(dayString(
                                                          list[index]
                                                              ["StartDateG"])),
                                                      titleText2(dayString(
                                                          list[index]
                                                              ["EndDateG"])),
                                                      titleText2(list[index]
                                                          ["MandateLocation"]),
                                                      titleText2(list[index]
                                                              ["MandateType"]
                                                          .toString()),
                                                      titleText2(list[index]
                                                              ["MandateDays"]
                                                          .toString()),
                                                      titleText2(list[index]
                                                              ["RequestNumber"]
                                                          .toString()),
                                                      titleText2(list[index]
                                                              ["MandateStatus"]
                                                          .toString()),
                                                      titleText2(list[index]
                                                              ["Notes"]
                                                          .toString()
                                                          .trim()),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // child: Card(
                            //   color: BackGWhiteColor,
                            //   elevation: 1,
                            //   child: Container(
                            //     padding: EdgeInsets.all(10),
                            //     child: Column(
                            //       children: [
                            //         Text.rich(TextSpan(
                            //             text: "إنتداب إلى : ",
                            //             style: descTx1(baseColorText),
                            //             children: [
                            //               TextSpan(
                            //                   style: titleTx(secondryColor),
                            //                   text: list[index][
                            //                                   "MandateLocation"]
                            //                               .toString() ==
                            //                           ""
                            //                       ? "النعيرية"
                            //                       : list[index]
                            //                               ["MandateLocation"]
                            //                           .toString())
                            //             ])),
                            //         SizedBox(
                            //           height: 10,
                            //         ),
                            //         Row(
                            //           children: [
                            //             Expanded(
                            //               child: Column(
                            //                 children: [
                            //                   Text(
                            //                     "عدد الأيام",
                            //                     style:
                            //                         subtitleTx(baseColorText),
                            //                   ),
                            //                   Text(
                            //                     list[index]["MandateDays"]
                            //                         .toString(),
                            //                     style:
                            //                         descTx1(secondryColorText),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //             Expanded(
                            //               child: Column(
                            //                 children: [
                            //                   Text(
                            //                     "تاريخ البداية",
                            //                     style:
                            //                         subtitleTx(baseColorText),
                            //                   ),
                            //                   Text(
                            //                     list[index]["StartDateG"]
                            //                         .toString()
                            //                         .split("T")[0],
                            //                     style:
                            //                         descTx1(secondryColorText),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //             Expanded(
                            //               child: Column(
                            //                 children: [
                            //                   Text(
                            //                     "تاريخ النهاية",
                            //                     style:
                            //                         subtitleTx(baseColorText),
                            //                   ),
                            //                   Text(
                            //                     list[index]["EndDateG"]
                            //                         .toString()
                            //                         .split("T")[0],
                            //                     style:
                            //                         descTx1(secondryColorText),
                            //                   )
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         SizedBox(
                            //           height: 5,
                            //         ),
                            //         widgetsUni.divider(),
                            //         SizedBox(
                            //           height: 5,
                            //         ),
                            //         Stack(
                            //           children: [
                            //             Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: [
                            //                 Expanded(
                            //                   child: Center(
                            //                     child: Column(
                            //                       children: [
                            //                         Text(
                            //                           "حالة الطلب",
                            //                           style: titleTx(
                            //                               baseColorText),
                            //                         ),
                            //                         Text(
                            //                             list[index]
                            //                                 ["MandateStatus"],
                            //                             style: descTx1(
                            //                                 secondryColorText))
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             Positioned(
                            //               left: 0,
                            //               child: Container(
                            //                 height: 60,
                            //                 child: Row(
                            //                   children: [
                            //                     Icon(
                            //                       Icons
                            //                           .arrow_forward_ios_rounded,
                            //                       size: 20,
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          );
                        }),
                  )
                : Center(
                    child: Text(
                      "لايوجد إنتدابات",
                      style: titleTx(baseColor),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return SizedBox(
      height: 30,
      child: Text(
        text + " :",
        style: fontsStyle.px13(Color(0xff838383), FontWeight.w500),
      ),
    );
  }

  Widget titleText2(String text) {
    return SizedBox(
      height: 30,
      child: Text(text,
          style: fontsStyle.px13(fontsStyle.SecondaryColor(), FontWeight.bold)),
    );
  }

  String dayString(String txt) {
    return convertDaysAndMonthToAR.convertDayToAR(
            date.DateFormat('EEEE').format(DateTime.parse(txt)).toString()) +
        " " +
        txt.toString().split("T")[0].toString().split("-")[2] +
        " " +
        convertDaysAndMonthToAR
            .getmonthname(txt.split("T")[0].toString().split("-")[1]);
  }
}
