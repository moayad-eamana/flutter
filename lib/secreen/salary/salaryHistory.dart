import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
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

class _SalaryHistoryState extends State<SalaryHistory> {
  dynamic listOfSalary = [];
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    String emNo = await EmployeeProfile.getEmployeeNumber();
    listOfSalary = await getAction("HR/GetEmployeeLastSalariesInfo/${emNo}/6");

    setState(() {
      isLoading = false;
      listOfSalary = jsonDecode(listOfSalary.body)["LastSalaries"] == null
          ? []
          : jsonDecode(listOfSalary.body)["LastSalaries"];
    });
    EasyLoading.dismiss();
    print(listOfSalary);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("سجل الرواتب", context, null),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
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
                        Icon(Icons.filter)
                      ],
                    ),
                  ],
                ),
                widgetsUni.divider(),
                if (listOfSalary.length == 0 && isLoading == false)
                  Center(
                    child: Text(
                      "لايوجد رواتب",
                      style: titleTx(baseColor),
                    ),
                  ),
                if (listOfSalary.length > 0)
                  ...listOfSalary.map((value) {
                    return Card(
                      margin: EdgeInsets.only(top: 20),
                      elevation: 2,
                      child: Container(
                        height: 109,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "التاريخ : " +
                                  value["SalaryDate"].toString().split("T")[0],
                              style: subtitleTx(baseColor),
                            ),
                            SizedBox(height: 5),
                            Expanded(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                        child: buildStack("إجمالي",
                                            value["TotalDues"], baseColor)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: buildStack("صافي",
                                            value["NetValue"], secondryColor)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: buildStack("حسميات",
                                            value["Deductions"], Colors.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStack(String lable, dynamic salary, Color color) {
    return Stack(
      fit: StackFit.loose,
      overflow: Overflow.visible,
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          height: 50,
          //   width: 120,
          decoration: containerdecoration(Colors.white),
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
