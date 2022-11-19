import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

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
    var response = await getAction("HR/GetEmployeeEvaluationMaster/" +
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
    EvaluationsMasterList = jsonDecode(response.body)["EvaluationsMaster"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("تقيماتي", context, null),
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
                      return Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                EvaluationsMasterList[index]["EvaluationYear"]
                                    .toString(),
                                style: subtitleTx(baseColor),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ))
            ],
          )),
    );
  }
}
