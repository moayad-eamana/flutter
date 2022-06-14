import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/OutDuties_history_detailes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OutDuties_hostiry extends StatefulWidget {
  @override
  State<OutDuties_hostiry> createState() => _OutDuties_hostiryState();
}

class _OutDuties_hostiryState extends State<OutDuties_hostiry> {
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
    list = await getAction("HR/GetEmployeeOutDuties/" + Empno);
    EasyLoading.dismiss();
    list = jsonDecode(list.body)["OutDutyList"] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("طلبات خارج دوام", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            list.length == 0
                ? Center(
                    child: Text(
                      "لا يوجد طلبات",
                      style: subtitleTx(baseColorText),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return OutDuties_history_detailes(list[index]);
                              }));
                            },
                            child: Card(
                              elevation: 1,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: BackGWhiteColor,
                                child: Column(
                                  children: [
                                    Text(
                                      "رقم الطلب",
                                      style: titleTx(baseColor),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      list[index]["RequestNumber"]
                                          .toString()
                                          .split(".")[0],
                                      style: subtitleTx(secondryColor),
                                    ),
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
                                                style:
                                                    subtitleTx(baseColorText),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                list[index]["OutDutyDays"]
                                                    .toString()
                                                    .split(".")[0],
                                                style:
                                                    descTx1(secondryColorText),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "عدد الساعات",
                                                style:
                                                    subtitleTx(baseColorText),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                list[index]["OutDutyHours"]
                                                    .toString(),
                                                style:
                                                    descTx1(secondryColorText),
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
                                    SizedBox(
                                      height: 5,
                                    ),
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
                                                      style: titleTx(
                                                          baseColorText),
                                                    ),
                                                    Text(
                                                        list[index]
                                                            ["RequestStatus"],
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
                                                  Icons
                                                      .arrow_forward_ios_rounded,
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
                  )
          ],
        ),
      ),
    );
  }
}
