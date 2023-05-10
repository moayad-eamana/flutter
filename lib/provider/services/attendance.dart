import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/functions/determinePosition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';

class attendanceServiceFunction {
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;

  bool? _authenticated;
  BuildContext context;
  attendanceServiceFunction(this.context);
  void InsertAttendance(int type) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    dynamic loaction = await checkloaction();
    print(loaction);
    if (loaction == false) {
      return;
    }

    // _canCheckBiometrics = await _checkBiometrics();

    // if (_canCheckBiometrics == true) {
    //   _authenticated = await _authenticate();
    // } else {
    //   _authenticated = false;

    //   Alerts.warningAlert(
    //           context, "تنبيه", "لا يمكن تفعيل البصمة, لعدم توفره بالجهاز")
    //       .show();
    // }
    // EasyLoading.dismiss();
    await Pickattachments.pickImage(ImageSource.camera);
    _authenticated = true;
    if (_authenticated == true) {
      // show popup massage then push api
      String title = type == 1 ? "تسجيل الحضور" : "تسجيل الإنصراف";
      String subtitle =
          type == 1 ? "هل تريد تسجيل الحضور" : "هل تريد تسجيل الإنصراف";
      Alerts.confirmAlrt(context, title, subtitle, "نعم")
          .show()
          .then((value) async {
        if (value == true) {
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );

          String udid = await FlutterUdid.consistentUdid;
          var respose = await postAction(
              "HR/InsertAttendance",
              jsonEncode({
                "EmployeeNumber":
                    int.parse(EmployeeProfile.getEmployeeNumber()),
                "LocationX": loaction.latitude.toString(),
                "LocationY": loaction.longitude.toString(),
                "AttendanceTypeID": type,
                "DeviceID": udid
              }));

          print(respose.body);

          respose = jsonDecode(respose.body);

          EasyLoading.dismiss();

          if (respose["StatusCode"] == 400) {
            String subtitle2 =
                type == 1 ? "تم تسجيل الحضور في" : "تم تسجيل الإنصراف في";
            Alerts.successAlert(context, "تم تسجيل",
                    subtitle2 + " " + respose["ReturnResult"]["ActionDate"])
                .show();
          } else {
            Alerts.errorAlert(context, title, respose["ErrorMessage"] ?? "")
                .show();
          }
        }
      });
    } else {
      //if canceleds
      if (_authenticated == null)
        Alerts.warningAlert(
                context, "تنبيه", "لا يمكن تفعيل البصمة, لعدم توفره بالجهاز")
            .show();
    }
  }

  checkloaction() async {
    dynamic loaction = await DeterminePosition.determinePosition();

    if (loaction == false) {
      EasyLoading.dismiss();
      Alerts.confirmAlrt(context, "تنبيه", "يرجى تشغيل موقع", "إعدادات")
          .show()
          .then((value) async {
        if (value == true) {
          Geolocator.openLocationSettings();
        }
      });

      return loaction;
    } else {
      return loaction;
    }
  }

  Future<dynamic> _checkBiometrics() async {
    late bool canCheckBiometrics;

    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    // if (!mounted) {
    //   return;
    // }

    _canCheckBiometrics = canCheckBiometrics;
    return _canCheckBiometrics;
  }

  Future<dynamic> _authenticate() async {
    bool? authenticated;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true);

      _authenticated = authenticated;
    } on PlatformException catch (e) {
      _authenticated = authenticated;

      print(e);
      return _authenticated;
    }
    // if (!mounted) {
    //   return;
    // }
    return _authenticated;
  }
}
