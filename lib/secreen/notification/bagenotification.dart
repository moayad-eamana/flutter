import 'dart:convert';

import 'package:badges/badges.dart' as badges;
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/notification/notification.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class badgenotification {
  static shownotfNub() async {
    if (sharedPref.getString("dumyuser") != "10284928492") {
      var response = await getAction("Hr/GetNotReadNotificationsCount/" +
          EmployeeProfile.getEmployeeNumber());
      notificationcont = jsonDecode(response.body)["ReturnResult"] == null ||
              jsonDecode(response.body)["ReturnResult"] == 0
          ? null
          : jsonDecode(response.body)["ReturnResult"];
    }
  }

  static Widget badgewidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationPage(notificationcont: notificationcont)));
        },
        child: Column(
          children: [
            badges.Badge(
              showBadge: notificationcont != null ? true : false,
              badgeContent: Text(
                notificationcont.toString(),
                style: descTx1(Colors.white),
              ),
              badgeColor: redColor,
              animationType: badges.BadgeAnimationType.scale,
              position: badges.BadgePosition.topStart(start: 0),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
