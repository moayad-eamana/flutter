import 'package:flutter/material.dart';

class EmpInfo {
  double EmployeeNumber;
  String EmployeeName;
  String FirstName;
  String SecondName;
  String ThirdName;
  String LastName;
  int DepartmentID;
  String DepartmentName;
  String Email;
  String empTypeName;
  String UserIdentityNumber;
  String MobileNumber;
  int VacationBalance;
  String JobName;
  String ImageURL;
  String Title;
  String DirectManagerName;
  int DirectManagerEmployeeNumber;
  String GeneralManagerName;
  int Extension;
  EmpInfo(
      this.EmployeeNumber,
      this.EmployeeName,
      this.FirstName,
      this.SecondName,
      this.ThirdName,
      this.LastName,
      this.DepartmentID,
      this.DepartmentName,
      this.Email,
      this.empTypeName,
      this.UserIdentityNumber,
      this.MobileNumber,
      this.VacationBalance,
      this.JobName,
      this.ImageURL,
      this.Title,
      this.DirectManagerName,
      this.DirectManagerEmployeeNumber,
      this.GeneralManagerName,
      this.Extension);
  factory EmpInfo.fromJson(dynamic json) {
    return EmpInfo(
        json["EmployeeNumber"],
        json["EmployeeName"],
        json["FirstName"],
        json["SecondName"],
        json["ThirdName"],
        json["LastName"],
        json["DepartmentID"],
        json["DepartmentName"],
        json["Email"],
        json["empTypeName"],
        json["UserIdentityNumber"],
        json["MobileNumber"],
        json["VacationBalance"],
        json["JobName"],
        json["ImageURL"],
        json["Title"],
        json["DirectManagerName"],
        json["DirectManagerEmployeeNumber"],
        json["GeneralManagerName"],
        json["Extension"]);
  }
}
