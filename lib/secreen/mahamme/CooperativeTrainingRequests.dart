import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      setState(() {
        RequestsList = jsonDecode(RequestsList.body)["RequestsList"];
      });
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
                Image.asset(
                  imageBG,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
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
