import 'dart:convert';

import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class GetCardRequest extends StatefulWidget {
  @override
  State<GetCardRequest> createState() => _GetCardRequestState();
}

class _GetCardRequestState extends State<GetCardRequest> {
  dynamic CardsList = [];
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      CardsList = await getAction("inbox/GetWorkCards/" +
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
      EasyLoading.dismiss();
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "InboxHRController";
      logapiO.ClassName = "InboxHRController";
      logapiO.ActionMethodName = "عرض طلبات بطاقة موظف-إعتمادات";
      logapiO.ActionMethodType = 1;
      if (jsonDecode(CardsList.body)["ErrorMessage"] == null) {
        logapiO.StatusCode = 1;
        logApi(logapiO);
        setState(() {
          CardsList = jsonDecode(CardsList.body)["CardsList"] ?? [];
        });
      } else {
        logapiO.StatusCode = 0;
        logapiO.ErrorMessage = jsonDecode(CardsList.body)["ErrorMessage"];
        logApi(logapiO);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الطلبات", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            CardsList.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      itemCount: CardsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => {
                                Navigator.pushNamed(
                                    context, "/GetCardRequestInfo", arguments: {
                                  "data": CardsList[index],
                                  "index": index
                                }).then((value) {
                                  if (value != null) {
                                    CardsList.removeAt(index);

                                    setState(() {});
                                  }
                                })
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration:
                                      containerdecoration(BackGWhiteColor),
                                  width: 90.w,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "الإسم",
                                        style: subtitleTx(baseColor),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        CardsList[index]["FullArName"],
                                        style: descTx1(secondryColorText),
                                      ),
                                      widgetsUni.divider(),
                                      Text(
                                        "نوع الطلب",
                                        style: subtitleTx(baseColor),
                                      ),
                                      Text(
                                        CardsList[index]["Reason"],
                                        style: descTx1(secondryColorText),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: Container(
                    child: Text(
                      "لايوجد طلبات",
                      style: titleTx(secondryColor),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
