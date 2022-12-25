import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class Desclaimerdatiels extends StatefulWidget {
  String RequestNumber;
  Desclaimerdatiels(this.RequestNumber);

  @override
  State<Desclaimerdatiels> createState() => _DesclaimerdatielsState();
}

class _DesclaimerdatielsState extends State<Desclaimerdatiels> {
  List GetEvacuationDetails = [];
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
    var respons;
    if (sharedPref.getString("dumyuser") != "10284928492") {
      respons =
          await getAction("HR/GetEvacuationDetails/" + widget.RequestNumber);
      GetEvacuationDetails = jsonDecode(respons.body)["ApprovalsList"];
    } else {
      GetEvacuationDetails = [];
    }

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
            child: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                SingleChildScrollView(
                  child: GetEvacuationDetails.length != 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: GetEvacuationDetails.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              child: Card(
                                color: BackGColor,
                                elevation: 5,
                                child: ListTile(
                                  // leading: Text(GetEvacuationDetails[index]
                                  //         ["TransactionDate"]
                                  //     .toString()
                                  //     .split("T")[0]),
                                  leading: Text(
                                    GetEvacuationDetails[index]["Status"]
                                                    .toString() ==
                                                "جارى الإعتماد" ||
                                            GetEvacuationDetails[index]
                                                        ["Status"]
                                                    .toString() ==
                                                ""
                                        ? "لم يتم تحديد"
                                        : GetEvacuationDetails[index]
                                                ["TransactionDate"]
                                            .toString()
                                            .split("T")[0],
                                    style: descTx1(baseColorText),
                                  ),
                                  title: Text(
                                    GetEvacuationDetails[index]
                                            ["DepartmentName"]
                                        .toString(),
                                    style: descTx1(baseColor),
                                  ),
                                  subtitle: Text(
                                    GetEvacuationDetails[index]["Status"]
                                            .toString() +
                                        " - " +
                                        GetEvacuationDetails[index]
                                                ["Description"]
                                            .toString(),
                                    style: descTx2(secondryColorText),
                                  ),
                                  // isThreeLine: true,
                                  // leading: Text(
                                  //   naif[index]["RequestNumber"].toString(),
                                  //   style: titleTx(baseColor),
                                  // ),
                                ),
                                // ConstrainedBox(
                                //   constraints: new BoxConstraints(
                                //     minHeight: 210.0,
                                //   ),
                                //   child: new DecoratedBox(
                                //     decoration: new BoxDecoration(
                                //       color: BackGColor,
                                //     ),
                                //     child: Padding(
                                //       padding: EdgeInsets.all(10),
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         children: [
                                //           Table(
                                //               border: TableBorder.all(),
                                //               columnWidths: {
                                //                 0: FlexColumnWidth(1.5),
                                //                 1: FlexColumnWidth(4),
                                //               },
                                //               children: <TableRow>[
                                //                 TableRowW(
                                //                     "رقم الحركة",
                                //                     GetEvacuationDetails[index]
                                //                             ["TransactionID"]
                                //                         .toString()),
                                //                 TableRowW(
                                //                     "الإدارة",
                                //                     GetEvacuationDetails[index]
                                //                             ["DepartmentName"]
                                //                         .toString()),
                                //                 TableRowW(
                                //                     "تاريخ الإجراء",
                                //                     GetEvacuationDetails[index][
                                //                                         "Status"]
                                //                                     .toString() ==
                                //                                 "جارى الإعتماد" ||
                                //                             GetEvacuationDetails[
                                //                                             index]
                                //                                         [
                                //                                         "Status"]
                                //                                     .toString() ==
                                //                                 ""
                                //                         ? "لم يتم تحديد"
                                //                         : GetEvacuationDetails[
                                //                                     index][
                                //                                 "TransactionDate"]
                                //                             .toString()
                                //                             .split("T")[0]),
                                //                 TableRowW(
                                //                     "الحالة",
                                //                     GetEvacuationDetails[index]
                                //                             ["Status"]
                                //                         .toString()),
                                //                 TableRowW(
                                //                     "الوصف",
                                //                     GetEvacuationDetails[index]
                                //                             ["Description"]
                                //                         .toString()),
                                //               ]),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ),
                            );
                          })
                      : SizedBox(
                          height: 90.h,
                          child: Center(
                            child: Text("لا يوجد بيانات",
                                style: subtitleTx(baseColorText)),
                          ),
                        ),
                ),
              ],
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
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: baseColorText),
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
