import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/Mandates_history_detailes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class Mandates_history extends StatefulWidget {
  const Mandates_history({Key? key}) : super(key: key);

  @override
  State<Mandates_history> createState() => _Mandates_historyState();
}

class _Mandates_historyState extends State<Mandates_history> {
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
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    list = await getAction("HR/GetUserMandates/" + Empno);
    EasyLoading.dismiss();
    list = jsonDecode(list.body)["MandatesList"] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إنتداباتي", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            list.length > 0
                ? Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Mandates_history_detailes(list[index]);
                              }));
                            },
                            child: Card(
                              color: BackGWhiteColor,
                              elevation: 1,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text.rich(TextSpan(
                                        text: "إنتداب إلى : ",
                                        style: descTx1(baseColorText),
                                        children: [
                                          TextSpan(
                                              style: titleTx(secondryColor),
                                              text: list[index][
                                                              "MandateLocation"]
                                                          .toString() ==
                                                      ""
                                                  ? "النعيرية"
                                                  : list[index]
                                                          ["MandateLocation"]
                                                      .toString())
                                        ])),
                                    SizedBox(
                                      height: 10,
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
                                              Text(
                                                list[index]["MandateDays"]
                                                    .toString(),
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
                                                "تاريخ البداية",
                                                style:
                                                    subtitleTx(baseColorText),
                                              ),
                                              Text(
                                                list[index]["StartDateG"]
                                                    .toString()
                                                    .split("T")[0],
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
                                                "تاريخ النهاية",
                                                style:
                                                    subtitleTx(baseColorText),
                                              ),
                                              Text(
                                                list[index]["EndDateG"]
                                                    .toString()
                                                    .split("T")[0],
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
                                                            ["MandateStatus"],
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
                : Center(
                    child: Text(
                      "لايوجد إنتدابات",
                      style: titleTx(baseColor),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
