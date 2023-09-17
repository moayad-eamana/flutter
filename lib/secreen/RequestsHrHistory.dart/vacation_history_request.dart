import 'dart:convert';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/vacation_history_request_datiels.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart' as date;
import 'package:eamanaapp/utilities/functions/convertDaysAndMonthToAR.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class vacation_old_request extends StatefulWidget {
  @override
  State<vacation_old_request> createState() => _vacation_old_requestState();
}

class _vacation_old_requestState extends State<vacation_old_request>
    with TickerProviderStateMixin {
  dynamic list = [];
  //bool _expanded = false;
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
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      String Empno =
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0];

      list = await getAction((sharedPref.getInt("empTypeID") != 8
              ? "HR/GetUserVacations/"
              : "HR/GetUserVacationsCompanies/") +
          Empno);
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "VacationsController";
      logapiO.ClassName = "VacationsController";
      logapiO.ActionMethodName = "عرض طلبات طلبات الاجازة";
      logapiO.ActionMethodType = 1;
      if (jsonDecode(list.body)["ErrorMessage"] == null) {
        logapiO.StatusCode = 1;
        logApi(logapiO);
        list = jsonDecode(list.body)["VacationsList"] ?? [];
      } else {
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(list.body)["ErrorMessage"];
        logApi(logapiO);
      }
    } else {
      await Future.delayed(Duration(seconds: 1));
      list = [];
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إجازاتي", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Container(
              margin: EdgeInsets.all(10),
              child: list.length == 0
                  ? Center(
                      child: Text(
                        "لا يوجد طلبات",
                        style: subtitleTx(baseColorText),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpandableTheme(
                          data: ExpandableThemeData(
                            //iconPlacement: ExpandablePanelIconPlacement.right,
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
                                      color:
                                          Color(0xff0E1F35).withOpacity(0.06),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
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
                                      if (list[index]["_expanded"] == null ||
                                          list[index]["_expanded"] == false) {
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  " لمدة  " +
                                                      list[index]
                                                              ["VacationDays"]
                                                          .toString() +
                                                      " أيام",
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
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          color:
                                                              Color(0xffF3F3F3),
                                                        ),
                                                        child: Text(
                                                          list[index]
                                                              ["VacationType"],
                                                          style: fontsStyle.px13(
                                                              Color(0xff9699A1),
                                                              FontWeight.w500),
                                                        ),
                                                      ),
                                                      RotationTransition(
                                                        turns: Tween(
                                                                begin: 0.0,
                                                                end: 1.0)
                                                            .animate(dataCtrl[
                                                                index]),
                                                        child: IconButton(
                                                          icon: Icon(Icons
                                                              .expand_more),
                                                          onPressed: () {},
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
                                    margin: EdgeInsets.symmetric(vertical: 10),
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
                                                titleText("نوع الإجازة"),
                                                titleText("عدد الأيام"),
                                                titleText("رقم الطلب"),
                                                titleText("حالة الطلب"),
                                                titleText("الموظف البديل"),
                                                titleText("الملاحظات"),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                titleText2(dayString(
                                                    list[index]["StartDateG"])),
                                                titleText2(dayString(
                                                    list[index]["EndDateG"])),
                                                titleText2(list[index]
                                                    ["VacationType"]),
                                                titleText2(list[index]
                                                        ["VacationDays"]
                                                    .toString()),
                                                titleText2(list[index]
                                                        ["RequestNumber"]
                                                    .toString()),
                                                titleText2(list[index]["Status"]
                                                    .toString()),
                                                titleText2(list[index]
                                                        ["ReplaceEmployeeName"]
                                                    .toString()),
                                                titleText2(list[index]["Notes"]
                                                    .toString()
                                                    .trim()),
                                              ],
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
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }

  Widget richText(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: text1 + ":",
            style: fontsStyle.px13(Color(0xff838383), FontWeight.w500),
            children: <TextSpan>[
              // TextSpan(
              //     text: text2,
              //     style: fontsStyle.px13(
              //         fontsStyle.SecondaryColor(), FontWeight.w500)),
            ],
          ),
        ),
        Text(text2)
      ],
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
