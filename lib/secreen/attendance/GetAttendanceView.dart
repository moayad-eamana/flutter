import 'dart:convert';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class GetAttendanceView extends StatefulWidget {
  GetAttendanceView({Key? key}) : super(key: key);

  @override
  State<GetAttendanceView> createState() => _GetAttendanceViewState();
}

class _GetAttendanceViewState extends State<GetAttendanceView> {
  List _AttendanceList = [];
  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    var response = await postAction(
        "HR/GetAttendance",
        jsonEncode({
          "EmployeeNumber": 4438104,
          "FromDate": "2023-02-01",
          "ToDate": "2023-02-12"
        }));
//check if the response is valid
    if (jsonDecode(response.body)["StatusCode"] != 400) {
      // logapiO.StatusCode = 0;
      // logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
      // logApi(logapiO);
      Alerts.errorAlert(
              context, "خطأ", jsonDecode(response.body)["ErrorMessage"])
          .show();
      return;
    } else {
      // logapiO.StatusCode = 1;
      // logApi(logapiO);

      // Alerts.successAlert(context, "", "test attendence").show().then((value) {
      //   Navigator.pop(context);

      setState(() {
        _AttendanceList = jsonDecode(response.body)['ReturnResult'];
        print(_AttendanceList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("سجل الحضور و الإنصراف", context, null, null),
          backgroundColor: Colors.grey[200],
          body: Stack(children: [
            widgetsUni.bacgroundimage(),
            Container(
                // color: BackGWhiteColor,
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
                                        _AttendanceList[index]["AttendanceDate"]
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
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                                                                      ["InDistance"]
                                                                  .toString()
                                                                  .split(".")[
                                                              0]) + //(distance).toString().split(".")[0]
                                                      " من \n" +
                                                      _AttendanceList[index]
                                                          ["AttendaceBuilding"],
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                                                    DistanceConverter(_AttendanceList[
                                                                    index]
                                                                ["OutDistance"]
                                                            .toString()
                                                            .split(".")[
                                                        0]) + //(distance).toString().split(".")[0]
                                                    " من \n" +
                                                    _AttendanceList[index]
                                                        ["AttendaceBuilding"],
                                                style: TextStyle(fontSize: 12),
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
          ]),
        ));
  }
//hjhgjj
  DistanceConverter(String d) {
    // m if the distance < 100:
    int distance = int.parse(d);
    if (distance < 1000) {
      return distance.toString() + " متر ";
    } else {
      return (distance ~/ 1000).toString() + " كم";
    }
  }

  // WeekDays(String string) {
  //   switch (string) {
  //     case 'SUN':
  //       return "الاحد";
  //     case 'MON':
  //       return "الاثنين";
  //     case 'TUE':
  //       return "الثلاثاء";
  //     case 'WED':
  //       return "الاربعاء";
  //     case 'THU':
  //       return "الخميس";
  //     case 'FRI':
  //       return "الجمعة";
  //     case 'SAT':
  //       return "السبت";
  //     default:
  //       "";
  //   }
  // }

//   FlipCards(String title, String day, String date, String hour, double distance,
//       String building, IconData icon) {
//     return Container(
//       height: 220,
//       color: BackGWhiteColor,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         SizedBox(
//           height: 10,
//         ),
//         Center(
//           child: Text(
//             //date & day
//             day + ", " + date.split("T")[0],
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 18, color: baseColor),
//           ),
//         ),
//         Divider(
//           thickness: 0.5,
//           color: bordercolor,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                       color: baseColorText,
//                       fontFamily: "Cairo",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Icon(icon, color: baseColor),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(//hour and min
//                         hour),
//                   ],
//                 ),
//                 sizeBox(),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.location_on_outlined,
//                       color: baseColor,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(//distance and building
//                         "على بُعد " +
//                             distance
//                                 .toString() + //(distance).toString().split(".")[0]
//                             " متر من " +
//                             building),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 30)
//           ],
//         ),
//       ]),
//     );
//   }
}
