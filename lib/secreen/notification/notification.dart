import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List Notifications = [];
  bool Isload = true;
  @override
  void initState() {
    super.initState();
    getdatat();
  }

  void getdatat() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await getAction("Hr/GetUserNotificationsHistory/" +
        EmployeeProfile.getEmployeeNumber() +
        "/10");
    print(respose.body);
    Isload = false;
    Notifications = jsonDecode(respose.body)["ReturnResult"] ?? [];

    setState(() {});

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الإشعارات", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Isload == false && Notifications.length == 0
                ? Center(
                    child: Text(
                    "لايوجد إشعارات",
                    style: titleTx(baseColor),
                  ))
                : Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: Notifications.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/morning",
                                  arguments: ({
                                    "title": Notifications[index]["Title"],
                                    "body": Notifications[index]["Body"],
                                    "url": Notifications[index]["ImageURL"]
                                  }));
                            },
                            child: Card(
                              color: BackGColor,
                              elevation: 5,
                              child: ListTile(
                                title: Text(
                                  Notifications[index]["Title"],
                                  style: subtitleTx(baseColor),
                                ),
                                subtitle: Text(
                                  Notifications[index]["Body"]
                                          .toString()
                                          .replaceAll("\n", " ")
                                          .substring(0, 50) +
                                      (Notifications[index]["Body"]
                                                  .toString()
                                                  .length >
                                              50
                                          ? "..."
                                          : ""),
                                  style: descTx2(baseColorText),
                                  textAlign: TextAlign.right,
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
