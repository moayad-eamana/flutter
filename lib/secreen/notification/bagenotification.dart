import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class badgenotification {
  static shownotfNub() async {
    var response = await getAction("Hr/GetNotReadNotificationsCount/" +
        EmployeeProfile.getEmployeeNumber());
    notificationcont = jsonDecode(response.body)["ReturnResult"] == null ||
            jsonDecode(response.body)["ReturnResult"] == 0
        ? null
        : jsonDecode(response.body)["ReturnResult"];
  }

  static Widget badgewidget() {
    return Column(
      children: [
        Badge(
          showBadge: notificationcont != null ? true : false,
          badgeContent: Text(
            notificationcont.toString(),
            style: descTx1(Colors.white),
          ),
          badgeColor: redColor,
          animationType: BadgeAnimationType.scale,
          child: Icon(
            Icons.notifications,
            color: baseColor,
            size: 40,
          ),
        ),
        Text(
          "إشعارات",
          style: TextStyle(color: baseColorText),
        ),
      ],
    );
  }
}
