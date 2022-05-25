import 'dart:convert';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/vacation_history_request_datiels.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../main.dart';

class vacation_old_request extends StatefulWidget {
  @override
  State<vacation_old_request> createState() => _vacation_old_requestState();
}

class _vacation_old_requestState extends State<vacation_old_request> {
  dynamic list = [];
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  getInfo() async {
    String Empno =
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0];
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    list = await getAction("HR/GetUserVacations/" + Empno);
    EasyLoading.dismiss();
    list = jsonDecode(list.body)["VacationsList"] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إجازاتي", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: list.length == 0
                  ? Center(
                      child: Text(
                        "لا يوجد طلبات",
                        style: subtitleTx(baseColorText),
                      ),
                    )
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return (vacation_history_request_datiels(
                                  list[index]));
                            }));
                          },
                          child: Card(
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: BackGWhiteColor,
                              child: Column(
                                children: [
                                  Text(list[index]["VacationType"].toString(),
                                      style: titleTx(baseColor)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "عدد الأيام",
                                              style: subtitleTx(baseColorText),
                                            ),
                                            Text(
                                              list[index]["VacationDays"]
                                                  .toString(),
                                              style: descTx1(secondryColorText),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "تاريخ البداية",
                                              style: subtitleTx(baseColorText),
                                            ),
                                            Text(
                                              list[index]["StartDateG"]
                                                  .toString()
                                                  .split("T")[0],
                                              style: descTx1(secondryColorText),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "تاريخ النهاية",
                                              style: subtitleTx(baseColorText),
                                            ),
                                            Text(
                                              list[index]["EndDateG"]
                                                  .toString()
                                                  .split("T")[0],
                                              style: descTx1(secondryColorText),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  widgetsUni.divider(),
                                  Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "حالة الطلب",
                                                    style:
                                                        titleTx(baseColorText),
                                                  ),
                                                  Text(list[index]["Status"],
                                                      style: descTx1(
                                                          secondryColorText))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        left: 0,
                                        child: Container(
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
