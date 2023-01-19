import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
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
    postAction(
        "HR/UpdateIsReadStatus/" + EmployeeProfile.getEmployeeNumber() + "/1",
        null);
    notificationcont = null;
    setState(() {});
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "NotificationsController";
    logapiO.ClassName = "NotificationsController";
    logapiO.ActionMethodName = "الإشعارات";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
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
                                    "url": {
                                      "image": Notifications[index]["ImageURL"],
                                      "title": Notifications[index]["Title"],
                                      "body": Notifications[index]["Body"]
                                    }
                                  }));
                            },
                            child: Card(
                              color: BackGColor,
                              elevation: 5,
                              child: ClipRRect(
                                child: Notifications[index]["IsRead"] == 0
                                    ? Banner(
                                        location: BannerLocation.topEnd,
                                        message: 'جديد',
                                        color: baseColor,
                                        child: ee(
                                            Notifications[index]["Title"],
                                            Notifications[index]["Body"]
                                                .toString(),
                                            Notifications[index]["IsRead"]))
                                    : ee(
                                        Notifications[index]["Title"],
                                        Notifications[index]["Body"].toString(),
                                        Notifications[index]["IsRead"]),
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

  Widget ee(String title, String Body, int IsRead) {
    return ListTile(
      title: Text(
        title,
        style: subtitleTx(IsRead == 1 ? secondryColorText : baseColor),
      ),
      subtitle: Text(
        Body.replaceAll("\n", " ").substring(0, 50) +
            (Body.toString().length > 50 ? "..." : ""),
        style: descTx2(baseColorText),
        textAlign: TextAlign.right,
      ),
      trailing: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.arrow_forward_ios,
          // color: baseColor,
        ),
      ),
    );
  }
}
