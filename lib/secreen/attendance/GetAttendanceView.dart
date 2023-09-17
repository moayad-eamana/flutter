import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class GetAttendanceView extends StatefulWidget {
  GetAttendanceView({Key? key}) : super(key: key);

  @override
  State<GetAttendanceView> createState() => _GetAttendanceViewState();
}

//
class _GetAttendanceViewState extends State<GetAttendanceView> {
  List _AttendanceList = [];
  List<String> monthsList = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  bool showdatePick = false;
  var startDate;
  var endDate;
  @override
  void initState() {
    getData(false);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  getData(bool customeDate) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await postAction(
        "HR/GetAttendance",
        jsonEncode({
          "EmployeeNumber": EmployeeProfile.getEmployeeNumber(),
          "FromDate":
              customeDate ? startDate : getLastFiveDays(), //5 days after
          "ToDate": customeDate ? endDate : Today() //today
        }));
//check if the response is valid
    if (jsonDecode(response.body)["StatusCode"] != 400) {
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "GetAttendance";
      logapiO.ClassName = "GetAttendance";
      logapiO.ActionMethodName = "سجل الحضور والانصراف";
      logapiO.ActionMethodType = 2;
      logapiO.ErrorMessage = jsonDecode(response.body)["ErrorMessage"];
      logapiO.StatusCode = 0;

      logApi(logapiO);
      Alerts.errorAlert(
              context, "خطأ", jsonDecode(response.body)["ErrorMessage"])
          .show();
      return;
    } else {
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "GetAttendance";
      logapiO.ClassName = "GetAttendance";
      logapiO.ActionMethodName = "سجل الحضور والانصراف";
      logapiO.ActionMethodType = 2;
      logapiO.StatusCode = 1;
      logApi(logapiO);
      setState(() {
        _AttendanceList = jsonDecode(response.body)['ReturnResult'];
        print(_AttendanceList);
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("سجل الحضور و الإنصراف", context, null),
          body: Column(children: [
            // -- date picker button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  width: 60,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(BackGWhiteColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the border radius
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          showdatePick = true;
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/SVGs/calendar.svg",
                      width: responsiveMT(30, 60),
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
            // -- months row
            Row(),
            // -- attendance card
            Expanded(
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 40),
                child: ListView.builder(
                  itemCount: _AttendanceList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          padding: EdgeInsets.fromLTRB(16, 7, 16, 7),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                color: BackGWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //time and distance (in)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                " الحضور: ",
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                _AttendanceList[index]
                                                    ["InTime"],
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "على بُعد " +
                                                    DistanceConverter(
                                                        _AttendanceList[index]
                                                                ["InDistance"]
                                                            .toString()
                                                            .split(".")[0]),
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      //time and distance (out)
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //time and distance (in)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                " الإنصراف: ",
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                _AttendanceList[index]
                                                    ["OutTime"],
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "على بُعد " +
                                                    DistanceConverter(_AttendanceList[
                                                                    index]
                                                                ["OutDistance"]
                                                            .toString()
                                                            .split(".")[
                                                        0]), //(distance).toString().split(".")[0],
                                                style: fontsStyle.px13(
                                                    fontsStyle.thirdColor(),
                                                    FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      //date and day
                                      Container(
                                        width: 60,
                                        height: 70,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: isToday(_AttendanceList[index]
                                                  ["AttendanceDate"])
                                              ? fontsStyle.HeaderColor()
                                              : fontsStyle.LightGreyColor(),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _AttendanceList[index]
                                                      ["AttendanceDate"]
                                                  .toString()
                                                  .split("-")[2]
                                                  .split("T")[0],
                                              style: TextStyle(
                                                color: isToday(
                                                        _AttendanceList[index]
                                                            ["AttendanceDate"])
                                                    ? Colors.white
                                                    : fontsStyle.FourthColor(),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              _AttendanceList[index]["Day"],
                                              style: TextStyle(
                                                color: isToday(
                                                        _AttendanceList[index]
                                                            ["AttendanceDate"])
                                                    ? Colors.white
                                                    : fontsStyle.FourthColor(),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    //   Container(
                    //       height: 270,
                    //       margin:
                    //           EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //       child: Card(
                    //         elevation: 1,
                    //         child: Container(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 10, vertical: 15),
                    //             child: Column(children: [
                    //               Text(
                    //                 _AttendanceList[index]["Day"] +
                    //                     ", " +
                    //                     _AttendanceList[index]["AttendanceDate"]
                    //                         .split("T")[0],
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 18,
                    //                     color: baseColor),
                    //               ),
                    //               Divider(
                    //                 thickness: 0.5,
                    //                 color: bordercolor,
                    //               ),
                    //               SizedBox(
                    //                 height: 13,
                    //               ),
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceAround,
                    //                 children: [
                    //                   Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         "الحضور",
                    //                         style: TextStyle(
                    //                             color: baseColorText,
                    //                             fontFamily: "Cairo",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 14),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 20,
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           Icon(
                    //                             Icons.wb_sunny_rounded,
                    //                             color: baseColor,
                    //                           ),
                    //                           SizedBox(
                    //                             width: 5,
                    //                           ),
                    //                           Text(
                    //                               "الساعة " +
                    //                                   _AttendanceList[index]
                    //                                       ["InTime"],
                    //                               style: TextStyle(fontSize: 12)),
                    //                         ],
                    //                       ),
                    //                       sizeBox(),
                    //                       Row(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Icon(
                    //                             Icons.location_on_outlined,
                    //                             color: baseColor,
                    //                           ),
                    //                           SizedBox(
                    //                             width: 5,
                    //                           ),
                    //                           Text(
                    //                               "على بُعد " +
                    //                                   DistanceConverter(
                    //                                       _AttendanceList[index][
                    //                                                   "InDistance"]
                    //                                               .toString()
                    //                                               .split(".")[
                    //                                           0]) + //(distance).toString().split(".")[0]
                    //                                   " من \n" +
                    //                                   _AttendanceList[index]
                    //                                       ["AttendaceBuilding"],
                    //                               style: TextStyle(fontSize: 12)),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text(
                    //                         "الإنصراف",
                    //                         style: TextStyle(
                    //                             color: baseColorText,
                    //                             fontFamily: "Cairo",
                    //                             fontWeight: FontWeight.bold,
                    //                             fontSize: 14),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 20,
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           Icon(
                    //                             Icons.bedtime,
                    //                             color: baseColor,
                    //                           ),
                    //                           SizedBox(
                    //                             width: 5,
                    //                           ),
                    //                           Text(
                    //                               "الساعة " +
                    //                                   _AttendanceList[index]
                    //                                       ["OutTime"],
                    //                               style: TextStyle(fontSize: 12)),
                    //                         ],
                    //                       ),
                    //                       sizeBox(),
                    //                       Row(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           Icon(
                    //                             Icons.location_on_outlined,
                    //                             color: baseColor,
                    //                           ),
                    //                           SizedBox(
                    //                             width: 5,
                    //                           ),
                    //                           Text(
                    //                             "على بُعد " +
                    //                                 DistanceConverter(
                    //                                     _AttendanceList[index][
                    //                                                 "OutDistance"]
                    //                                             .toString()
                    //                                             .split(".")[
                    //                                         0]) + //(distance).toString().split(".")[0]
                    //                                 " من \n" +
                    //                                 _AttendanceList[index]
                    //                                     ["AttendaceBuilding"],
                    //                             style: TextStyle(fontSize: 12),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               )
                    //             ])),
                    //       ));
                  },
                ),
              ),
            ),
            showdatePick
                ? Center(
                    child: Card(
                      child: Container(
                        decoration: containerdecoration(Colors.white),
                        height: 350,
                        width: 350,
                        child: SfDateRangePicker(
                          // showTodayButton: true,
                          showActionButtons: true,
                          cancelText: "إغلاق",
                          confirmText: "تطبيق",
                          onSelectionChanged: (value) {
                            print(value);
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                          backgroundColor: Colors.white,
                          onCancel: () {
                            showdatePick = false;
                            setState(() {});
                          },
                          onSubmit: (dynamic value) {
                            print(value);
                            startDate = value.startDate.toString();
                            endDate = value.endDate.toString();
                            showdatePick = false;
                            if (startDate != "null" && endDate != "null") {
                              getData(true);
                            }
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  )
                : Container(),
          ]),
        ));
  }

  DistanceConverter(String d) {
    // m if the distance < 100:
    int distance = int.parse(d);
    if (distance < 1000) {
      return distance.toString() + " متر ";
    } else {
      return (distance ~/ 1000).toString() + " كم";
    }
  }

  getLastFiveDays() {
    var now = new DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);
    startDate = new DateTime(today.year, today.month, today.day - 7);
    print(startDate.toString());
    return startDate.toString();
  }

  Today() {
    var now = new DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);
    endDate = new DateTime(today.year, today.month, today.day);
    return endDate.toString();
  }

  bool isToday(String date) {
    var Date = date.split("T")[0];
    DateTime today = DateTime.now();
    DateTime Today_dateOnly = DateTime(today.year, today.month, today.day);
    String StringOfToday = Today_dateOnly.toString().split("00")[0].trim();

    return Date.split("-")[0] == StringOfToday.split("-")[0] &&
        Date.split("-")[1] == StringOfToday.split("-")[1] &&
        Date.split("-")[2] == StringOfToday.split("-")[2];
  }

//later use
  String getAMPM(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    if (dateTime.hour < 12) {
      return 'صباحاً';
    } else {
      return 'مساءاً';
    }
  }
}
