import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class CooperativeTrainingRequests extends StatefulWidget {
  @override
  State<CooperativeTrainingRequests> createState() =>
      _CooperativeTrainingRequestsState();
}

class _CooperativeTrainingRequestsState
    extends State<CooperativeTrainingRequests> {
  @override
  dynamic RequestsList = [];
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      RequestsList = await getAction("Inbox/GetCooperativeTrainingRequests/" +
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
      EasyLoading.dismiss();
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "InboxHRController";
      logapiO.ClassName = "InboxHRController";
      logapiO.ActionMethodName = "عرض طلبات التدريب التعاوني-إعتمادات";
      logapiO.ActionMethodType = 1;
      if (jsonDecode(RequestsList.body)["ErrorMessage"] == null) {
        logapiO.StatusCode = 1;
        logApi(logapiO);
        setState(() {
          RequestsList = jsonDecode(RequestsList.body)["RequestsList"] ?? [];
        });
      } else {
        logapiO.StatusCode = 1;
        logapiO.ErrorMessage = jsonDecode(RequestsList.body)["ErrorMessage"];
        logApi(logapiO);
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBarW.appBarW("طلبات التدريب التعاوني", context, null),
            body: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: RequestsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/CooperativeTrainingRequestsInfo",
                                arguments: {
                                  "data": RequestsList[index],
                                  "index": index
                                }).then((value) {
                              if (value != null) {
                                RequestsList.removeAt(index);

                                setState(() {});
                              }
                            });
                          },
                          child: Card(
                            child: Container(
                              decoration: containerdecoration(BackGWhiteColor),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  ListTile(
                                    //leading: FlutterLogo(size: 72.0),
                                    title: Text(
                                      RequestsList[index]["StudentNameAr"],
                                      style: subtitleTx(secondryColor),
                                    ),
                                    subtitle: Text(
                                      RequestsList[index]["Major"],
                                      style: descTx2(baseColorText),
                                    ),

                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          RequestsList[index]["GPAScore"]
                                                  .toString() +
                                              " من " +
                                              RequestsList[index]["GPAType"]
                                                  .toString(),
                                          style: descTx2(baseColorText),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: baseColorText,
                                        )
                                      ],
                                    ),
                                    isThreeLine: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )));
  }
}
