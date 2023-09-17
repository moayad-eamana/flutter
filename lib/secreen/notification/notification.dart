import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({required this.notificationcont, Key? key})
      : super(key: key);
  final int? notificationcont;

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
    if (sharedPref.getString("dumyuser") != "10284928492") {
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
    } else {
      await Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      Isload = false;
      Notifications = [];
      setState(() {});
    }
  }

  String tag(String title) {
    if (title == "عرض جديد") {
      return "عروض";
    }
    if (title == "Eamana SMS") {
      return "رسائل";
    }
    if (title.contains("يساند")) {
      return "ساند";
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الإشعارات", context, null),
        body: Stack(
          children: [
            Isload == false && Notifications.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/SVGs/Notification-icon.svg',
                          width: 40,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "لايوجد لديك إشعارات",
                          style: fontsStyle.px20(
                              fontsStyle.thirdColor(), FontWeight.bold),
                        ),
                        Text(
                          "عند وجود إشعارات جديدة ستظهر هنا",
                          style: fontsStyle.px13(
                              fontsStyle.thirdColor(), FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      notificationcont != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              width: 100.w,
                              child: Text(
                                "$notificationcont إشعارات جديدة",
                                textAlign: TextAlign.right,
                                style: fontsStyle.px14(
                                    fontsStyle.thirdColor(), FontWeight.bold),
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListView.builder(
                              itemCount: Notifications.length,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/morning",
                                        arguments: ({
                                          "title": Notifications[index]
                                              ["Title"],
                                          "body": Notifications[index]["Body"],
                                          "url": {
                                            "image": Notifications[index]
                                                ["ImageURL"],
                                            "title": Notifications[index]
                                                ["Title"],
                                            "body": Notifications[index]["Body"]
                                          }
                                        }));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Notifications[index]["IsRead"] == 0
                                          ? Color(0xFFE4F2F2)
                                          : BackGWhiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff0E1F35)
                                              .withOpacity(0.06),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          Container(

                                              // margin: EdgeInsets.only(right: 10),
                                              height: 50,
                                              width: 10,
                                              // color: Colors.amber,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Notifications[index]
                                                            ["IsRead"] ==
                                                        0
                                                    ? Icon(
                                                        Icons.circle,
                                                        size: 10,
                                                        color:
                                                            Color(0xffDE6161),
                                                      )
                                                    : Container(),
                                              )),
                                          Expanded(
                                            child: ee(
                                                Notifications[index]["Title"],
                                                Notifications[index]["Body"]
                                                    .toString(),
                                                Notifications[index]
                                                        ["NotificationDate"]
                                                    .toString()
                                                    .split("T")[0]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget ee(String title, String Body, String Date) {
    return ListTile(
      title: Container(
        margin: EdgeInsets.only(bottom: 6.5),
        child: Text(
          title,
          style:
              fontsStyle.px12Bold(fontsStyle.SecondaryColor(), FontWeight.bold),
        ),
      ),
      subtitle: Container(
        // color: Colors.red,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  child: Text(
                    Body.replaceAll("\n", " ").substring(0,
                            Body.length <= 90 ? Body.toString().length : 90) +
                        (Body.toString().length > 90 ? "..." : ""),
                    maxLines: 2,
                    style: fontsStyle.px12normal(
                        fontsStyle.SecondaryColor(), FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                ),
                Text(
                  Date,
                  style: fontsStyle.px12normal(
                      fontsStyle.SecondaryColor(), FontWeight.bold),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: title == "عرض جديد"
                        ? Color(0xFF77AE22).withOpacity(0.33)
                        : Color(0xFFB8E6E6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    )),
                height: 25,
                width: 60,
                child: Center(
                  child: Text(
                    tag(title),
                    style: fontsStyle.px12Bold(
                        fontsStyle.thirdColor(), FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // trailing: Container(
      //   width: 30,
      // ),
    );
  }
}
