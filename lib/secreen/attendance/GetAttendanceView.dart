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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class GetAttendanceView extends StatefulWidget {
  GetAttendanceView({Key? key}) : super(key: key);

  @override
  State<GetAttendanceView> createState() => _GetAttendanceViewState();
}

//
class _GetAttendanceViewState extends State<GetAttendanceView> {
  List _AttendanceList = [];
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
          appBar: AppBarW.appBarW("سجل الحضور و الإنصراف", context, null, () {
            showdatePick = true;
            setState(() {});
          }),
          backgroundColor: Colors.grey[200],
          body: Stack(children: [
            widgetsUni.bacgroundimage(),
            Opacity(
              opacity: showdatePick ? 0.6 : 1,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: ListView.builder(
                      itemCount: _AttendanceList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            height: 270,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(children: [
                                    Text(
                                      _AttendanceList[index]["Day"] +
                                          ", " +
                                          _AttendanceList[index]
                                                  ["AttendanceDate"]
                                              .split("T")[0],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: baseColor),
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: bordercolor,
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "الحضور",
                                              style: TextStyle(
                                                  color: baseColorText,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.wb_sunny_rounded,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "الساعة " +
                                                        _AttendanceList[index]
                                                            ["InTime"],
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            sizeBox(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "على بُعد " +
                                                        DistanceConverter(
                                                            _AttendanceList[index]
                                                                        [
                                                                        "InDistance"]
                                                                    .toString()
                                                                    .split(".")[
                                                                0]) + //(distance).toString().split(".")[0]
                                                        " من \n" +
                                                        _AttendanceList[index][
                                                            "AttendaceBuilding"],
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "الإنصراف",
                                              style: TextStyle(
                                                  color: baseColorText,
                                                  fontFamily: "Cairo",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.bedtime,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    "الساعة " +
                                                        _AttendanceList[index]
                                                            ["OutTime"],
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            sizeBox(),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: baseColor,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "على بُعد " +
                                                      DistanceConverter(
                                                          _AttendanceList[index]
                                                                      [
                                                                      "OutDistance"]
                                                                  .toString()
                                                                  .split(".")[
                                                              0]) + //(distance).toString().split(".")[0]
                                                      " من \n" +
                                                      _AttendanceList[index]
                                                          ["AttendaceBuilding"],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ])),
                            ));
                      })),
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
}
