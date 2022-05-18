import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/main.dart';
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
    var respose = await http.post(
        Uri.parse(
            "https://srv.eamana.gov.sa/NewAmanaAPIs_Test/API/Authentication/CheckUserForMobile"),
        body: jsonEncode({"EmployeeNumber": userName, "Password": password}),
        headers: {"Content-Type": "application/json"});

    if (jsonDecode(respose.body)["IsAuthenticated"] == true) {
      PrivateToken = jsonDecode(respose.body)["PrivateToken"];
      sharedPref.setString(
          "PrivateToken", jsonDecode(respose.body)["PrivateToken"]);
      username = userName;
      pass = password;

      //_pref.setString("username", userName);
      if (username == "1111") {
        return true;
      }

      return true;
    }
    return false;
  }

  Future<dynamic> checkUserOTP(String otp) async {
    //  SharedPreferences _pref = await SharedPreferences.getInstance();
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
      sharedPref.setDouble("EmployeeNumber", empinfo["EmployeeNumber"]);
      sharedPref.setString("EmployeeName", empinfo["EmployeeName"].toString());
      sharedPref.setString("FirstName", empinfo["FirstName"].toString());
      sharedPref.setString("SecondName", empinfo["SecondName"].toString());
      sharedPref.setString("ThirdName", empinfo["ThirdName"].toString());
      sharedPref.setString("LastName", empinfo["LastName"].toString());
      sharedPref.setInt("DepartmentID", empinfo["DepartmentID"]);
      sharedPref.setString(
          "DepartmentName", empinfo["DepartmentName"].toString());
      sharedPref.setString("Email", empinfo["Email"].toString());

      sharedPref.setInt("empTypeID", empinfo["empTypeID"]);
      sharedPref.setString("empTypeName", empinfo["empTypeName"].toString());
      sharedPref.setString("StatusName", empinfo["StatusName"].toString());
      sharedPref.setString(
          "UserIdentityNumber", empinfo["UserIdentityNumber"].toString());
      sharedPref.setString("MobileNumber", empinfo["MobileNumber"].toString());
      sharedPref.setInt("UserTypeID", empinfo["UserTypeID"]);
      sharedPref.setInt("VacationBalance", empinfo["VacationBalance"]);

      sharedPref.setString("JobName", empinfo["JobName"]);
      sharedPref.setString("ImageURL", empinfo["ImageURL"]);
      sharedPref.setString("Title", empinfo["Title"]);
      sharedPref.setString("DirectManagerName", empinfo["DirectManagerName"]);

      sharedPref.setInt("DirectManagerEmployeeNumber",
          empinfo["DirectManagerEmployeeNumber"]);
      sharedPref.setInt("GeneralManagerEmployeeNumber",
          empinfo["GeneralManagerEmployeeNumber"]);
      sharedPref.setInt("MainDepartmentID", empinfo["MainDepartmentID"]);
      sharedPref.setString("MainDepartmentName", empinfo["MainDepartmentName"]);
      sharedPref.setInt("Extension", empinfo["Extension"]);
      sharedPref.setInt("GenderID", empinfo["GenderID"]);
      sharedPref.setString(
          "AccessToken", jsonDecode(respose.body)["AccessToken"] ?? "");
      sharedPref.setString(
          "tokenTime", (DateTime.now().add(Duration(days: 3))).toString());
      await hasPermission();
      return true;
    }
    return jsonDecode(respose.body)["ErrorMessage"];
  }

  Future<void> hasPermission() async {
    EmployeeProfile empinfo = await EmployeeProfile();
    if (hasePerm == null || hasePerm == "") {
      empinfo = await empinfo.getEmployeeProfile();
      try {
        var respose = await http.post(
            Uri.parse(
                "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/getAppointmentsPermission.php"),
            body: jsonEncode({
              "token": sharedPref.getString("AccessToken"),
              "username": empinfo.Email
            }));
        hasePerm = jsonDecode(respose.body)["message"];
      } catch (e) {}

      //hasePerm = hasePerm;
      print("rr == " + hasePerm.toString());
      //SharedPreferences? sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString("hasePerm", hasePerm.toString());
      hasePerm = hasePerm.toString();
    }
  }
}
