import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class EmployeeEvaluationDetailsByYear extends StatefulWidget {
  String year;
  EmployeeEvaluationDetailsByYear(this.year);

  @override
  State<EmployeeEvaluationDetailsByYear> createState() =>
      _EmployeeEvaluationDetailsByYearState();
}

class _EmployeeEvaluationDetailsByYearState
    extends State<EmployeeEvaluationDetailsByYear> {
  List EvaluationDetailsByYear = [];
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respons = await getAction("HR/GetEmployeeEvaluationDetailsByYear/" +
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0] +
        "/" +
        widget.year);
    EvaluationDetailsByYear = jsonDecode(respons.body)["EvaluationsDetails"];
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("التفاصيل", context, null),
          body: Container(
            height: 100.h,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  widgetsUni.bacgroundimage(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: EvaluationDetailsByYear.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Card(
                            elevation: 5,
                            child: ConstrainedBox(
                              constraints: new BoxConstraints(
                                minHeight: 210.0,
                              ),
                              child: new DecoratedBox(
                                decoration:
                                    new BoxDecoration(color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Table(
                                          border: TableBorder.all(),
                                          columnWidths: {
                                            0: FlexColumnWidth(1.5),
                                            1: FlexColumnWidth(4),
                                          },
                                          children: <TableRow>[
                                            TableRowW(
                                                "الهدف",
                                                EvaluationDetailsByYear[index]
                                                    ["TargetDecription"]),
                                            TableRowW(
                                                "معيار المقياس",
                                                EvaluationDetailsByYear[index]
                                                    ["TargetTool"]),
                                            TableRowW(
                                                "الوزن النسبي",
                                                EvaluationDetailsByYear[index]
                                                        ["TargetWieght"]
                                                    .toString()),
                                            TableRowW(
                                                "الناتج المستهدف",
                                                EvaluationDetailsByYear[index]
                                                        ["Target"]
                                                    .toString()),
                                          ]),
                                      // CardW(
                                      //     "الهدف",
                                      //     EvaluationDetailsByYear[index]
                                      //         ["TargetDecription"]),
                                      // widgetsUni.divider(),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      // CardW(
                                      //     "معيار المقياس",
                                      //     EvaluationDetailsByYear[index]
                                      //         ["TargetTool"]),
                                      // widgetsUni.divider(),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     Column(
                                      //       children: [
                                      //         CardW(
                                      //             "الوزن النسبي",
                                      //             EvaluationDetailsByYear[index]
                                      //                     ["TargetWieght"]
                                      //                 .toString()),
                                      //       ],
                                      //     ),
                                      //     Column(
                                      //       children: [
                                      //         CardW(
                                      //             "الناتج المستهدف",
                                      //             EvaluationDetailsByYear[index]
                                      //                     ["Target"]
                                      //                 .toString()),
                                      //       ],
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          )),
    );
  }

  Widget CardW(String Tiltle, String desc) {
    return Column(
      children: [
        Text(
          Tiltle,
          style: subtitleTx(baseColorText),
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: descTx1(secondryColorText),
        ),
      ],
    );
  }

  TableRowW(String Title, String desc) {
    return TableRow(
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  Title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                //  color: Colors.red,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: descTx1(secondryColorText),
            ),
          ),
        )
      ],
    );
  }
}
