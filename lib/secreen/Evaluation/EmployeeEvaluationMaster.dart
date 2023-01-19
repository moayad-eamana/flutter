import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'EmployeeEvaluationDetailsByYear.dart';

class EmployeeEvaluationMaster extends StatefulWidget {
  @override
  State<EmployeeEvaluationMaster> createState() =>
      _EmployeeEvaluationMasterState();
}

class _EmployeeEvaluationMasterState extends State<EmployeeEvaluationMaster> {
  List EvaluationsMasterList = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response;
    if (sharedPref.getString("dumyuser") != "10284928492") {
      response = await getAction("HR/GetEmployeeEvaluationMaster/" +
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
      EvaluationsMasterList = jsonDecode(response.body)["EvaluationsMaster"];
      EvaluationsMasterList = EvaluationsMasterList.reversed.toList();
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "MethaqController";
      logapiO.ClassName = "MethaqController";
      logapiO.ActionMethodName = "تقييماتي";
      logapiO.ActionMethodType = 1;
      logapiO.StatusCode = 1;
      logApi(logapiO);
    } else {
      await Future.delayed(Duration(seconds: 1));
      EvaluationsMasterList = [];
    }

    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("تقييماتي", context, null),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  imageBG,
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: EvaluationsMasterList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeEvaluationDetailsByYear(
                                        EvaluationsMasterList[index]
                                                ["EvaluationYear"]
                                            .toString())),
                          );
                        },
                        child: Card(
                          color: BackGColor,
                          child: ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            leading: Text(
                              EvaluationsMasterList[index]["EvaluationYear"]
                                  .toString(),
                              style: subtitleTx(secondryColor),
                            ),
                            title: Text(
                              EvaluationsMasterList[index]
                                      ["AgreementStatusText"] +
                                  " - " +
                                  EvaluationsMasterList[index]
                                      ["FinalEvauationName"],
                              style: descTx1(baseColorText),
                            ),
                            subtitle: Text(
                              "المسؤول : " +
                                  EvaluationsMasterList[index]
                                      ["DirectManagerEmployeeName"],
                              style: descTx2(secondryColorText),
                            ),
                          ),
                        ),
                      );
                      // return Card(
                      //   elevation: 4,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       children: [
                      // Text(
                      //   EvaluationsMasterList[index]["EvaluationYear"]
                      //       .toString(),
                      //   style: subtitleTx(secondryColor),
                      // ),
                      //         Text(
                      //           "المسؤول المباشر",
                      //           style: subtitleTx(baseColor),
                      //         ),
                      //         Text(
                      //           EvaluationsMasterList[index]
                      //                   ["DirectManagerEmployeeName"]
                      //               .toString(),
                      //           style: subtitleTx(baseColorText),
                      //         ),
                      //         Row(
                      //           children: [
                      //             Text(
                      //               "حالة الميثاق : ",
                      //             ),
                      //             Text(EvaluationsMasterList[index]
                      //                     ["AgreementStatusText"]
                      //                 .toString())
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // );
                    }),
              ))
            ],
          )),
    );
  }
}
