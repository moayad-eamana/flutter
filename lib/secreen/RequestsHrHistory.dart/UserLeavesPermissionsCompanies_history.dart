import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/convertDaysAndMonthToAR.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' as date;

class UserLeavesPermissionsCompanies_history extends StatefulWidget {
  UserLeavesPermissionsCompanies_history();

  @override
  State<UserLeavesPermissionsCompanies_history> createState() =>
      _UserLeavesPermissionsCompanies_historyState();
}

class _UserLeavesPermissionsCompanies_historyState
    extends State<UserLeavesPermissionsCompanies_history>
    with TickerProviderStateMixin {
  dynamic UserLeavesPermissionsCompanies_history;
  late List<AnimationController> dataCtrl;
  @override
  void initState() {
    // TODO: implement initState
    dataCtrl = List.generate(
        100,
        (int index) => AnimationController(
              vsync: this,
              duration: Duration(milliseconds: 300),
              upperBound: 0.5,
            ));
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await getAction("HR/GetUserLeavesPermissionsCompanies/" +
        EmployeeProfile.getEmployeeNumber());
    UserLeavesPermissionsCompanies_history =
        jsonDecode(response.body)["PermissionDataList"];
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("طلبات الإستئذان", context, null),
        body: UserLeavesPermissionsCompanies_history == null
            ? Center()
            : ListView.builder(
                itemCount: UserLeavesPermissionsCompanies_history.length,
                itemBuilder: (context, index) {
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
                                color: Color(0xff0E1F35).withOpacity(0.06),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          // color: Colors.white,
                          child: ExpandablePanel(
                            header: Listener(
                              behavior: HitTestBehavior.opaque,
                              onPointerDown: (e) {
                                if (UserLeavesPermissionsCompanies_history[
                                            index]["_expanded"] ==
                                        null ||
                                    UserLeavesPermissionsCompanies_history[
                                            index]["_expanded"] ==
                                        false) {
                                  dataCtrl[index]..forward(from: 0.0);
                                } else {
                                  dataCtrl[index]..reverse(from: 0.5);
                                }

                                print(UserLeavesPermissionsCompanies_history[
                                    index]["_expanded"]);
                                UserLeavesPermissionsCompanies_history[index]
                                        ["_expanded"] =
                                    UserLeavesPermissionsCompanies_history[
                                                index]["_expanded"] ==
                                            null
                                        ? true
                                        : !(UserLeavesPermissionsCompanies_history[
                                            index]["_expanded"]);
                                print(UserLeavesPermissionsCompanies_history[
                                    index]["_expanded"]);
                                //   setState(() {});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            (dayString(
                                                UserLeavesPermissionsCompanies_history[
                                                    index]["StartDateG"])),
                                            style: fontsStyle.px13(
                                                Color(0xff838383),
                                                FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            UserLeavesPermissionsCompanies_history[
                                                index]["PermissionType"],
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
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  // decoration: BoxDecoration(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           7),
                                                  //   color: Color(0xffF3F3F3),
                                                  // ),
                                                  // child: Text(
                                                  //   list[index]["VacationType"],
                                                  //   style: fontsStyle.px13(
                                                  //       Color(0xff9699A1),
                                                  //       FontWeight.w500),
                                                  // ),
                                                ),
                                                RotationTransition(
                                                  turns: Tween(
                                                          begin: 0.0, end: 1.0)
                                                      .animate(dataCtrl[index]),
                                                  child: IconButton(
                                                    icon:
                                                        Icon(Icons.expand_more),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          titleText("تاريخ"),
                                          titleText("الحالة"),
                                          titleText("نوع الإستئذان"),
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
                                              UserLeavesPermissionsCompanies_history[
                                                  index]["StartDateG"])),
                                          titleText2(
                                              UserLeavesPermissionsCompanies_history[
                                                  index]["Status"]),
                                          titleText2(
                                              UserLeavesPermissionsCompanies_history[
                                                  index]["PermissionType"]),
                                          titleText2(
                                              UserLeavesPermissionsCompanies_history[
                                                          index]
                                                      ["ReplaceEmployeeName"]
                                                  .toString()),
                                          titleText2(
                                              UserLeavesPermissionsCompanies_history[
                                                      index]["Notes"]
                                                  .toString()),
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
    );
  }

  Widget titleText(String text) {
    List a = text.split("").reversed.toList();
    String ee = a.toString();
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
