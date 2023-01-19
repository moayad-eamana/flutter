import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/mahamme/transfarevacationDetailes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class transfarevacation extends StatefulWidget {
  @override
  State<transfarevacation> createState() => _transfarevacationState();
}

class _transfarevacationState extends State<transfarevacation> {
  List transfarevacationList = [];
  bool load = true;
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
    var respnse = await getAction("Inbox/GetExtendVactionRequests/" +
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0] +
        '/1');
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "InboxHRController";
    logapiO.ClassName = "InboxHRController";
    logapiO.ActionMethodName = "ترحيل الإجازات-إعتمادات";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    EasyLoading.dismiss();
    load = false;
    transfarevacationList = jsonDecode(respnse.body)["RequestList"] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar:
              AppBarW.appBarW("ترحيل الإجازات (بند الكفاءات)", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              load == false && transfarevacationList.length == 0
                  ? Center(
                      child: Text(
                        "لايوجد طلبات",
                        style: titleTx(baseColor),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: transfarevacationList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          transfarevacationDetailes(
                                              transfarevacationList[index],
                                              index)),
                                ).then((value) {
                                  if (value is int) {
                                    transfarevacationList.removeAt(index);
                                    setState(() {});
                                  }
                                });
                              },
                              child: Card(
                                color: BackGColor,
                                child: ListTile(
                                  title: Text(
                                    transfarevacationList[index]
                                        ["EmployeeName"],
                                    style: subtitleTx(baseColorText),
                                  ),
                                  subtitle: Text(
                                      "تاريخ الطلب :- " +
                                          transfarevacationList[index]
                                                  ["RequestDate"]
                                              .toString()
                                              .split("T")[0],
                                      style: subtitleTx(secondryColorText)),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            );
                          }),
                    )
            ],
          )),
    );
  }
}
