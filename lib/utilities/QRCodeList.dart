import 'package:flutter/material.dart';

class QrcodeList {
  static qrcodelist(BuildContext context) {
    return [
      {
        "service_name": "بيانتي",
        "Navigation": "",
        "icon": "assets/SVGs/qr_code_scanner.svg",
        "Action": () {
          // Navigator.pushNamed(context, "/scannQrcode");
        }
      },
      {
        "service_name": "جهة الاتصال",
        "Navigation": "",
        "icon": "assets/SVGs/qr_code_scanner.svg",
        "Action": () {
          // Navigator.pushNamed(context, "/scannQrcode");
        }
      },
    ];
  }
}
