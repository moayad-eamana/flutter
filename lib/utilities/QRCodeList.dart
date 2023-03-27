import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/QrCode/bottomsheetQrCode.dart';
import 'package:eamanaapp/secreen/QrCode/qrCodeScan.dart';
import 'package:flutter/material.dart';

class QrcodeList {
  static List qrcodelist(BuildContext context) {
    return [
      {
        "service_name": "بيانتي",
        "Navigation": "",
        "icon": "assets/SVGs/qr_code_scanner.svg",
        "Action": () {
          // Navigator.pushNamed(context, "/scannQrcode");
          dynamic MyData = {
            "id": 1,
            "Name": sharedPref.getString("FirstName").toString() +
                " " +
                sharedPref.getString("LastName").toString(),
            "Title": sharedPref.getString("Title").toString() == ""
                ? sharedPref.getString("JobName").toString()
                : sharedPref.getString("Title").toString(),
            "imageUrl": "https://archive.eamana.gov.sa/TransactFileUpload" +
                sharedPref.getString("ImageURL").toString(),
            "PhoneNum": sharedPref.getString("MobileNumber") ?? "",
            "Email": sharedPref.getString("Email").toString(),
            "Extension": sharedPref.getInt("Extension").toString() ?? "",
            "ID": EmployeeProfile.getEmployeeNumber(),
            "GenderID": sharedPref.getInt("GenderID"),
          };

          BottomSheetQrCode("بيانتي", jsonEncode(MyData), context);
        }
      },
      {
        "service_name": "جهة الاتصال",
        "Navigation": "",
        "icon": "assets/SVGs/qr_code_scanner.svg",
        "Action": () {
          // Navigator.pushNamed(context, "/scannQrcode");
          BottomSheetQrCode("جهة الاتصال", "", context);
        }
      },
      {
        "service_name": "مسح QRCode",
        "Navigation": "",
        "icon": "assets/SVGs/qr_code_scanner.svg",
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrCodeScan()),
            // ignore: prefer_const_constructors
          );
        }
      },
    ];
  }
}
