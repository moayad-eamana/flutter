// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MyEmployees extends StatefulWidget {
  List _employeesList;
  List _checkedEmployees;
  MyEmployees(this._employeesList, this._checkedEmployees);

  @override
  State<MyEmployees> createState() => _MyEmployeesState();
}

class _MyEmployeesState extends State<MyEmployees> {
  bool flag = false;
  @override
  void initState() {
    widget._employeesList.length <= 0 ? getData() : super.initState();
  }

  getData() async {
    var response = await getAction("HR/GetAllEmployeesByManagerNumber/4261003");
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
      ///
      // Alerts.successAlert(context, "", "test attendence").show().then((value) {
      //   Navigator.pop(context);

      setState(() {
        widget._employeesList = jsonDecode(response.body)['EmpInfo'];
        print(widget._employeesList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(children: [
        
        Container(
            // color: BackGWhiteColor,
            margin: EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
                itemCount: widget._employeesList.length,
                itemBuilder: (context, index) {
                  return Container(
                      height: 100,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        elevation: 1,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    backgroundColor: baseColor,
                                    radius: responsiveMT(24, 26),
                                    child: ClipOval(
                                      child: widget._employeesList[index]
                                                      ["ImageURL"] ==
                                                  "" ||
                                              widget._employeesList[index]
                                                      ["GenderID"] ==
                                                  "2"
                                          ? Image.asset(
                                              "assets/image/blank-profile.png",
                                            )
                                          : ClipOval(
                                              child: FadeInImage.assetNetwork(
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                                image:
                                                    "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                        widget._employeesList[
                                                            index]["ImageURL"],
                                                placeholder:
                                                    "assets/image/blank-profile.png",
                                                imageErrorBuilder: (context,
                                                        error, stackTrace) =>
                                                    Image.asset(
                                                  "assets/image/blank-profile.png",
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  widget._employeesList[index]["EmployeeName"],
                                  style: TextStyle(
                                      color: baseColorText,
                                      fontFamily: "Cairo",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Spacer(),
                                Checkbox(
                                  checkColor: Colors.white,
                                  value: widget._employeesList[index]
                                          ["isSelected"] ??
                                      false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      widget._employeesList[index]
                                          ["isSelected"] = value;

                                      if (widget._employeesList[index]
                                              ["isSelected"] ==
                                          true) {
                                        flag = true;
                                        widget._checkedEmployees.add(
                                            widget._employeesList[index]
                                                ["EmployeeNumber"]);
                                        print("Hellooo");
                                      } else {
                                        flag = false;
                                        widget._checkedEmployees.remove(
                                            widget._employeesList[index]
                                                ["EmployeeNumber"]);
                                      }
                                    });
                                  },
                                ),
                              ],
                            )),
                      ));
                })),
      ]),
    );
  }
}
