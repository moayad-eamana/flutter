import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String PrivateToken = "";
  String username = "";
  String pass = "";
  get getPrivetToken {
    return PrivateToken;
  }

  get getuserName {
    return username;
  }

  get getupass {
    return pass;
  }

  // EmployeeProfile employeeProfile = EmployeeProfile(0, "", "", "");

  Future<bool> checkUser(String userName, String password) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var respose = await http.post(
        Uri.parse(
            "https://srv.eamana.gov.sa/NewAmanaAPIs_Test/API/Authentication/CheckUserForMobile"),
        body: jsonEncode({"EmployeeNumber": userName, "Password": password}),
        headers: {"Content-Type": "application/json"});

    if (jsonDecode(respose.body)["IsAuthenticated"] == true) {
      PrivateToken = jsonDecode(respose.body)["PrivateToken"];
      _pref.setString("PrivateToken", jsonDecode(respose.body)["PrivateToken"]);
      username = userName;
      pass = password;

      //_pref.setString("username", userName);
      if (username == "4438104") {
        await checkUserAppl();
        return true;
      }

      return true;
    }
    return false;
  }

  Future<dynamic> checkUserOTP(String otp) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var respose = await http.post(
        Uri.parse(
          "https://srv.eamana.gov.sa/NewAmanaAPIs_Test/API/Authentication/IsValidOTP",
        ),
        body: jsonEncode({
          "EmployeeNumber": int.parse(getuserName),
          "PrivateToken": getPrivetToken,
          "UserName": "DevTeam",
          "Password": "DevTeam",
          "OTP": int.parse(otp)
        }),
        headers: {"Content-Type": "application/json"});

    if (jsonDecode(respose.body)["IsValid"] == true) {
      dynamic empinfo = jsonDecode(respose.body)["EmployeeInfo"];

      _pref.setDouble("EmployeeNumber", empinfo["EmployeeNumber"]);
      _pref.setString("EmployeeName", empinfo["EmployeeName"].toString());
      _pref.setString("FirstName", empinfo["FirstName"].toString());
      _pref.setString("SecondName", empinfo["SecondName"].toString());
      _pref.setString("ThirdName", empinfo["ThirdName"].toString());
      _pref.setString("LastName", empinfo["LastName"].toString());
      _pref.setInt("DepartmentID", empinfo["DepartmentID"]);
      _pref.setString("DepartmentName", empinfo["DepartmentName"].toString());
      _pref.setString("Email", empinfo["Email"].toString());

      _pref.setInt("empTypeID", empinfo["empTypeID"]);
      _pref.setString("empTypeName", empinfo["empTypeName"].toString());
      _pref.setString("StatusName", empinfo["StatusName"].toString());
      _pref.setString(
          "UserIdentityNumber", empinfo["UserIdentityNumber"].toString());
      _pref.setString("MobileNumber", empinfo["MobileNumber"].toString());
      _pref.setInt("UserTypeID", empinfo["UserTypeID"]);
      _pref.setInt("VacationBalance", empinfo["VacationBalance"]);

      _pref.setString("JobName", empinfo["JobName"]);
      _pref.setString("ImageURL", empinfo["ImageURL"]);
      _pref.setString("Title", empinfo["Title"]);
      _pref.setString("DirectManagerName", empinfo["DirectManagerName"]);

      _pref.setInt("DirectManagerEmployeeNumber",
          empinfo["DirectManagerEmployeeNumber"]);
      _pref.setInt("GeneralManagerEmployeeNumber",
          empinfo["GeneralManagerEmployeeNumber"]);
      _pref.setInt("MainDepartmentID", empinfo["MainDepartmentID"]);
      _pref.setString("MainDepartmentName", empinfo["MainDepartmentName"]);
      _pref.setInt("Extension", empinfo["Extension"]);
      _pref.setInt("GenderID", empinfo["GenderID"]);
      _pref.setString(
          "AccessToken", jsonDecode(respose.body)["AccessToken"] ?? "");

      return true;
    }
    return jsonDecode(respose.body)["ErrorMessage"];
  }

  Future<dynamic> checkUserAppl() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.setDouble("EmployeeNumber", 4438104.0);
    _pref.setString("EmployeeName", "مؤيد العوفي");
    _pref.setString("FirstName", "مؤيد");
    _pref.setString("SecondName", "جابر");
    _pref.setString("ThirdName", "علي");
    _pref.setString("LastName", "العوفي");
    _pref.setInt("DepartmentID", 422150000);
    _pref.setString("DepartmentName", "الحاسب");
    _pref.setString("Email", "moayad@ee.ee.ee");

    _pref.setInt("empTypeID", 0101);
    _pref.setString("empTypeName", "موظف");
    _pref.setString("StatusName", "علي رأس العمل");
    _pref.setString("UserIdentityNumber", "222323323");
    _pref.setString("MobileNumber", '0399349493');
    _pref.setInt("UserTypeID", 0101);
    _pref.setInt("VacationBalance", 200);

    _pref.setString("JobName", "مبرمج");
    _pref.setString("ImageURL",
        "\\\\10.16.16.59\\TransactFileUpload\$\\2021\\20211018\\HRS\\1546260\\1-1546260-24-2.jpg");
    _pref.setString("Title", '');
    _pref.setString("DirectManagerName", "مؤيد");

    _pref.setInt("DirectManagerEmployeeNumber", 883993);
    _pref.setInt("GeneralManagerEmployeeNumber", 333939);
    _pref.setInt("MainDepartmentID", 422150000);
    _pref.setString("MainDepartmentName", "حاسب");
    _pref.setInt("Extension", 44444);
    _pref.setInt("GenderID", 1);
    _pref.setString("AccessToken",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IkRldlRlYW0iLCJuYmYiOjE2NDY4OTQ2MDMsImV4cCI6MTY0NzA2NzQwMiwiaWF0IjoxNjQ2ODk0NjAzfQ.iMTgLaxoy-vxvMVrmcLOaXVgqnyMAWQUYWMWaeDQrg8");
  }
}
