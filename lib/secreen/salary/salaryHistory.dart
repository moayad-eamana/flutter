import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SalaryHistory extends StatefulWidget {
  const SalaryHistory({Key? key}) : super(key: key);

  @override
  _SalaryHistoryState createState() => _SalaryHistoryState();
}

class _SalaryHistoryState extends State<SalaryHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _expanded = true;
  dynamic listOfSalary = [];
  bool isLoading = true;
  @override
  void initState() {
    getData();
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "SalaryController";
    logapiO.ClassName = "SalaryController";
    logapiO.ActionMethodName = "سجل الرواتب";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
    _controller.dispose();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      String emNo = await EmployeeProfile.getEmployeeNumber();
      listOfSalary =
          await getAction("HR/GetEmployeeLastSalariesInfo/${emNo}/6");

      setState(() {
        isLoading = false;
        listOfSalary = jsonDecode(listOfSalary.body)["LastSalaries"] == null
            ? []
            : jsonDecode(listOfSalary.body)["LastSalaries"];
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      listOfSalary = [];
      setState(() {});
    }

    EasyLoading.dismiss();
    print(listOfSalary);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("سجل الرواتب", context, null),
        body: Stack(
          // fit: StackFit.loose,
          //   overflow: Overflow.visible,
          clipBehavior: Clip.none,
          children: [
            widgetsUni.bacgroundimage(),
            listOfSalary.length == 0
                ? Center(
                    child: Text("لايوجد رواتب"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "سجل الرواتب لاخر ستة أشهر",
                                style: titleTx(baseColor),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "الترتيب",
                                    style: titleTx(secondryColorText),
                                  ),
                                  SizedBox(width: 10),
                                  RotationTransition(
                                    turns: Tween(begin: 0.0, end: 0.5)
                                        .animate(_controller),
                                    child: IconButton(
                                      color: baseColorText,
                                      icon: Icon(Icons.filter_list_rounded),
                                      onPressed: () {
                                        setState(() {
                                          if (_expanded) {
                                            _controller..reverse(from: 0.5);
                                          } else {
                                            _controller..forward(from: 0.0);
                                          }
                                          _expanded = !_expanded;
                                          print(_expanded);
                                          listOfSalary =
                                              List.from(listOfSalary.reversed);
                                        });
                                      },
                                    ),
                                  ),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       setState(() {
                                  //         listOfSalary =
                                  //             List.from(listOfSalary.reversed);
                                  //       });
                                  //     },
                                  //     child: Icon(Icons.filter_list_rounded))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: widgetsUni.divider()),
                        if (listOfSalary.length == 0 && isLoading == false)
                          Center(
                            child: Text(
                              "لا يوجد رواتب",
                              style: subtitleTx(baseColorText),
                            ),
                          ),
                        if (listOfSalary.length > 0)
                          ...listOfSalary.asMap().entries.map((entry) {
                            return Column(
                              children: [
                                Stack(
                                  // fit: StackFit.loose,
                                  //overflow: Overflow.visible,
                                  clipBehavior: Clip.none,
                                  children: [
                                    Card(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      elevation: 2,
                                      child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                            color: BackGWhiteColor,
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "التاريخ : " +
                                                  entry.value["SalaryDate"]
                                                      .toString()
                                                      .split("T")[0],
                                              style: subtitleTx(baseColor),
                                            ),
                                            SizedBox(height: 5),
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                        child: buildStack(
                                                            "إجمالي",
                                                            entry.value[
                                                                "TotalDues"],
                                                            baseColor)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: buildStack(
                                                            "صافي",
                                                            entry.value[
                                                                "NetValue"],
                                                            secondryColor)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: buildStack(
                                                            "حسميات",
                                                            entry.value[
                                                                "Deductions"],
                                                            Colors.red))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 25,
                                    //   child: Container(
                                    //     width: 25,
                                    //     height: 40,
                                    //     decoration: BoxDecoration(
                                    //         shape: BoxShape.circle,
                                    //         border: Border.all(color: Colors.black),
                                    //         color: (Colors.white)),
                                    //     child: Center(
                                    //         child: Text(
                                    //       (entry.key + 1).toString(),
                                    //       style: TextStyle(color: Colors.black),
                                    //     )),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildStack(String lable, dynamic salary, Color color) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 50,
          //   width: 120,
          decoration: containerdecoration(BackGWhiteColor),
          child: Center(
            child: Text(
              salary.toString(),
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: -17,
          right: 4,
          child: Container(
            height: 25,
            width: 60,
            decoration: containerdecoration(secondryColor),
            child: Center(
                child: Text(
              lable,
              style: descTx2(Colors.white),
            )),
          ),
        ),
      ],
    );
  }
}
