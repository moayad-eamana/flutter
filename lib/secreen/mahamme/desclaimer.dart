import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/mahamme/desclaimerDetailes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class desclaimer extends StatefulWidget {
  @override
  State<desclaimer> createState() => _desclaimerState();
}

class _desclaimerState extends State<desclaimer> {
  bool load = true;
  List EvacuationRequests = [];
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
    var response = await getAction("Inbox/GetEvacuationRequests/" +
        sharedPref.getDouble("EmployeeNumber").toString().split(".")[0] +
        "/1/21");
    EasyLoading.dismiss();
    load = false;
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "InboxHRController";
    logapiO.ClassName = "InboxHRController";
    logapiO.ActionMethodName = "عرض طلبات إخلاء الطرف-إعتمادات";
    logapiO.ActionMethodType = 1;
    if (jsonDecode(response.body)["ErrorMessage"] == null) {
      logapiO.StatusCode = 1;
      logApi(logapiO);
      EvacuationRequests = jsonDecode(response.body)["RequestList"];
    } else {
      logapiO.StatusCode = 0;
      logapiO.ErrorMessage = jsonDecode(response.body)["ErrorMessage"];
      logApi(logapiO);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إعتماد إخلاء طرف", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            load == false && EvacuationRequests.length == 0
                ? Center(
                    child: Text(
                    "لايوجد طلبات",
                    style: titleTx(baseColor),
                  ))
                : Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: EvacuationRequests.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => desclaimerDetailes(
                                        EvacuationRequests[index], index)),
                              ).then((value) {
                                if (value is int) {
                                  EvacuationRequests.removeAt(index);
                                  setState(() {});
                                }
                              });
                            },
                            child: Card(
                              color: BackGColor,
                              elevation: 5,
                              child: ListTile(
                                leading: Text(
                                  EvacuationRequests[index]["RequestNumber"]
                                      .toString(),
                                  style: subtitleTx(secondryColor),
                                ),
                                title: Text(
                                  EvacuationRequests[index]["EmployeeName"],
                                  style: subtitleTx(baseColorText),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "تاريخ الطلب: ",
                                      style: descTx2(baseColorText),
                                    ),
                                    Text(
                                      EvacuationRequests[index]["RequestDate"]
                                          .toString()
                                          .split("T")[0],
                                      style: descTx2(baseColorText),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: baseColor,
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
