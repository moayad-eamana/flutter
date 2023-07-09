import 'dart:convert';

import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyEmployees extends StatefulWidget {
  List _employeesList;
  List _checkedEmployees;
  Function nextPage;
  MyEmployees(this._employeesList, this._checkedEmployees, this.nextPage);

  @override
  State<MyEmployees> createState() => _MyEmployeesState();
}

class _MyEmployeesState extends State<MyEmployees> {
  bool flag = false;
  List filter = [];
  int index = 0;
  TextEditingController search = TextEditingController();
  @override

//   getData() async {
//     EasyLoading.show(
//       status: '... جاري المعالجة',
//       maskType: EasyLoadingMaskType.black,
//     );
//     var response = await getAction("HR/GetAllEmployeesByManagerNumber/4261003");
// //check if the response is valid
//     if (jsonDecode(response.body)["StatusCode"] != 400) {
//       // logapiO.StatusCode = 0;
//       // logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
//       // logApi(logapiO);
//       Alerts.errorAlert(
//               context, "خطأ", jsonDecode(response.body)["ErrorMessage"])
//           .show();
//       return;
//     } else {
//       // logapiO.StatusCode = 1;
//       // logApi(logapiO);
//       ///
//       // Alerts.successAlert(context, "", "test attendence").show().then((value) {
//       //   Navigator.pop(context);

//       setState(() {
//         widget._employeesList = jsonDecode(response.body)['EmpInfo'];
//         print(widget._employeesList);
//       });
//     }
//     EasyLoading.dismiss();
//   }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              //  height: 120,
              width: 90.w,
              child: TextField(
                controller: search,
                decoration: formlabel1("بحث"),
                onChanged: (value) {
                  if (index == 0) {
                    var cc = jsonEncode(widget._employeesList);
                    filter = jsonDecode(cc);
                    index++;
                  }
                  widget._employeesList = widget._employeesList
                      .where((element) =>
                          element["EmployeeName"].toString().contains(value))
                      .toList();
                  if (value == "") {
                    var cc = jsonEncode(filter);
                    widget._employeesList = jsonDecode(cc);
                    setState(() {});
                  }
                  setState(() {});
                },
              )),
          Container(
            height: 610,
            width: 400,
            child: ListView.builder(
                itemCount: widget._employeesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
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
                              child: widget._employeesList[index]["ImageURL"] ==
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
                                                widget._employeesList[index]
                                                    ["ImageURL"],
                                        placeholder:
                                            "assets/image/blank-profile.png",
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
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
                          activeColor: secondryColor,
                          checkColor: Colors.white,
                          value: widget._employeesList[index]["isSelected"] ??
                              false,
                          onChanged: (bool? value) {
                            setState(
                              () {
                                widget._employeesList[index]["isSelected"] =
                                    value;

                                if (widget._employeesList[index]
                                        ["isSelected"] ==
                                    true) {
                                  widget._checkedEmployees.add(int.parse(widget
                                      ._employeesList[index]["EmployeeNumber"]
                                      .toString()
                                      .split(".")[0]));
                                } else {
                                  widget._checkedEmployees.remove(int.parse(
                                      widget._employeesList[index]
                                              ["EmployeeNumber"]
                                          .toString()
                                          .split(".")[0]));
                                }
                                ;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              height: 48,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: secondryColor),
                          child: Icon(Icons.arrow_forward_ios),
                          onPressed: widget._checkedEmployees.length > 0
                              ? () {
                                  widget.nextPage();
                                }
                              : null,
                        )),
                  ),
                ],
              ))
        ]));
  }
}
