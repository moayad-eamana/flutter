import 'dart:io';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';

class logApiModel {
  int ModuleID = 1;
  int EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
  String Email = sharedPref.getString("Email") ?? "";
  String? ControllerName;
  String? ClassName;
  String? ActionMethodName;
  int? ActionMethodType;
  String? Notes;
  String? ErrorMessage;
  int? StatusCode; // 1 succeeded ,0 failed
  int? ErrorTypeID; // 0 no error ,   Exception=1,BussinessError=2
  String? JsonRequest;
  String latform = Platform.isAndroid ? "Android" : "IOS";
  int ApplicationID = 2;

  Map<String, dynamic> toJson() => {
        "ModuleID": 1,
        "EmployeeNumber": EmployeeNumber,
        "Email": Email,
        "ControllerName": ControllerName,
        "ClassName": ClassName,
        "ActionMethodName": ActionMethodName,
        "ActionMethodType": ActionMethodType, // 1 get ,2 post

        "Notes": Notes,
        "ErrorMessage": ErrorMessage,
        "StatusCode": StatusCode, // 1 succeeded ,0 failed
        "ErrorTypeID":
            ErrorTypeID, // 0 no error ,   Exception=1,BussinessError=2
        "JsonRequest": JsonRequest,
        "Platform": Platform,
        "ApplicationID": 2
      };
}
