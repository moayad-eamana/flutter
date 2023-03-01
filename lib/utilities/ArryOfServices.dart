import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/services/hrServicesFunctions.dart';
import 'package:eamanaapp/provider/services/salaryFunctions.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/newEmpinfo.dart';
import 'package:eamanaapp/secreen/Meetings/mettingsType.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/desclaimer.dart';
import 'package:eamanaapp/secreen/attendance/GetAttendanceView.dart';
import 'package:eamanaapp/secreen/customerService/customerEntrance.dart';
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/customerService/statistics.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/momten/momten.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportYourEmployees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/provider/services/attendance.dart';

class listOfServices {
  BuildContext context;

  listOfServices(this.context);
  List<int> _insertExtensionRequestValid = [0, 6, 7];

  final services2 = [
    if (sharedPref.getInt("empTypeID") != 8)
      ////شؤون الموظفين
      {
        "catg": "hrServices",
        "service_name": "طلب إجازة",
        "Navigation": "/VacationRequest",
        "icon": 'assets/SVGs/ejaza.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "catg": "hrServices",
        "service_name": "طلب خارج دوام",
        "Navigation": "/OutdutyRequest",
        "icon": 'assets/SVGs/work_out.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "catg": "hrServices",
        "service_name": "رصيد إجازات",
        "Navigation": "",
        "icon": 'assets/SVGs/balance.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "catg": "hrServices",
        "service_name": "طلب إنتداب",
        "Navigation": "/entedab",
        "icon": 'assets/SVGs/entdab.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "catg": "hrServices",
        "service_name": "العهد", /////////
        "Navigation": "/auhad",
        "icon": 'assets/SVGs/3ohad.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      //الرواتب
      {
        "service_name": "سجل الرواتب",
        "Navigation": "/SalaryHistory",
        "icon": 'assets/SVGs/sejelalrawatb.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "service_name": "تعريف بالراتب",
        "Navigation": "/auth_secreen",
        "icon": 'assets/SVGs/ta3refalratb.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      //مهامي
      {
        "service_name": "إعتماداتي",
        "Navigation": MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => EatemadatProvider(),
            // ignore: prefer_const_constructors
            child: InboxHedersView(),
          ),
        ),
        "icon": 'assets/SVGs/e3tmadaty.svg',
      },
    if (hasePerm == "true")
      {
        "service_name": "مواعيدي",
        "Navigation": "/meettingsType",
        "icon": 'assets/SVGs/mawa3idi.svg',
      },
    {
      "service_name": "عروض",
      "Navigation": "/EamanaDiscount",
      "icon": 'assets/SVGs/offers.svg',
    },
    {
      "service_name": "دليل الموظفين",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpInfoView(null),
        ),
      ),
      "icon": 'assets/SVGs/dalelalmowzafen.svg',
    },
    {
      "service_name": "معلوماتي",
      "Navigation": "/newEmpInfo",
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

  List hrservices() {
    List services2 = [
      if (sharedPref.getInt("empTypeID") != 8)
        ////شؤون الموظفين
        {
          "service_name": "طلب إجازة",
          "Navigation": "/VacationRequest",
          "icon": 'assets/SVGs/ejaza.svg',
          "Action": () async {
            Navigator.pushNamed(context, "/VacationRequest");
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "طلب خارج دوام",
          "Navigation": "/OutdutyRequest",
          "icon": 'assets/SVGs/work_out.svg',
          "Action": () async {
            Navigator.pushNamed(context, "/OutdutyRequest");
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "رصيد إجازات",
          "Navigation": "",
          "icon": 'assets/SVGs/balance.svg',
          "Action": () async {
            hrServicesFunctions.rased(context);
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "طلب إنتداب",
          "Navigation": "/entedab",
          "icon": 'assets/SVGs/entdab.svg',
          "Action": () async {
            Navigator.pushNamed(context, "/entedab");
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "العهد", /////////
          "Navigation": "/auhad",
          "icon": 'assets/SVGs/3ohad.svg',
          "Action": () async {
            Navigator.pushNamed(context, "/auhad");
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "catg": "hrServices",
          "service_name": "تقييماتي", /////////
          "Navigation": "/auhad",
          "icon": 'assets/SVGs/rate.svg',
          "Action": () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => desclaimer()),
            );
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "إستعلام إخلاء طرف", /////////
          "Navigation": "/auhad",
          "icon": 'assets/SVGs/desclaimer.svg',
          "Action": () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => desclaimer()),
            );
          }
        },
      if (_insertExtensionRequestValid.contains(sharedPref.getInt("empTypeID")))
        {
          "service_name": "إستعلام إخلاء طرف", /////////
          "Navigation": "/auhad",
          "icon": 'assets/SVGs/Insertvacation.svg',
          "Action": () async {
            hrServicesFunctions.insertExtensionRequest(context);
          }
        },
    ];
    return services2;
  }

  List Salarservices() {
    List services2 = [
      if (sharedPref.getInt("empTypeID") != 8)
        ////شؤون الموظفين
        {
          "service_name": "سجل الرواتب",
          "Navigation": "/SalaryHistory",
          "icon": 'assets/SVGs/sejelalrawatb.svg',
          "Action": () async {
            salaryFunction.salaryHistory(context);
          }
        },
      if (sharedPref.getInt("empTypeID") != 8)
        {
          "service_name": "تعريف بالراتب",
          "Navigation": "/auth_secreen",
          "icon": 'assets/SVGs/ta3refalratb.svg',
          "Action": () async {
            salaryFunction.SalaryReport(context);
          }
        },
    ];
    return services2;
  }

  List customerService() {
    return sharedPref.getBool("permissionforCRM") == true
        ? [
            {
              "service_name": "عرض الطلبات",
              "Navigation": "/newEmpInfo",
              "icon": 'assets/SVGs/violation.svg',
              "Action": () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => customerServiceRrequests("")),
                );
              }
            },
            {
              "service_name": "حجز موعد",
              "Navigation": "/reserveForcustomer",
              "icon": 'assets/SVGs/set_appoinment.svg',
              "Action": () {
                Navigator.pushNamed(context, "/reserveForcustomer");
              }
            },
            {
              "service_name": "الإحصائيات",
              "Navigation": "",
              "icon": 'assets/SVGs/assessment.svg',
              "Action": () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => statistics()),
                );
              }
            },
            {
              "service_name": "تسجيل حضور",
              "Navigation": "",
              "icon": 'assets/SVGs/login.svg',
              "Action": () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => customerEnterance()),
                );
              }
            },
          ]
        : [];
  }

  List questService() {
    return [
      {
        "service_name": "إعتماداتي",
        "Navigation": "",
        "icon": 'assets/SVGs/e3tmadaty.svg',
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => EatemadatProvider(),
                // ignore: prefer_const_constructors
                child: InboxHedersView(),
              ),
            ),
          );
        }
      },
      {
        "service_name": "مواعيدي",
        "Navigation": "",
        "icon": 'assets/SVGs/mawa3idi.svg',
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // ignore: prefer_const_constructors
              builder: (BuildContext context) {
                return meettingsType();
              },
            ),
          );
        }
      }
    ];
  }

  List otherService() {
    return [
      {
        "service_name": "العروض",
        "Navigation": "/EamanaDiscount",
        "icon": 'assets/SVGs/offers.svg',
        "Action": () {
          Navigator.pushNamed(context, "/EamanaDiscount");
        }
      },
      {
        "service_name": "دليل الموظفين",
        "Navigation": "",
        "icon": "assets/SVGs/dalelalmowzafen.svg",
        "Action": () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => EmpInfoProvider(),
                  // ignore: prefer_const_constructors
                  child: EmpInfoView(null),
                ),
              ));
        }
      },
      {
        "service_name": "معلوماتي",
        "Navigation": "",
        "icon": "assets/SVGs/baynaty.svg",
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newEmpInfo(true)),
            // ignore: prefer_const_constructors
          );
        }
      },
      {
        "service_name": "المفضلة",
        "Navigation": "/favs",
        "icon": "assets/SVGs/bookmarks.svg",
        "Action": () {
          Navigator.pushNamed(context, "/favs");
        }
      },
      if (sharedPref.getString("dumyuser") != "10284928492")
        {
          "service_name": "QR Code",
          "Navigation": "",
          "icon": "assets/SVGs/qr_code_scanner.svg",
          "Action": () {
            Navigator.pushNamed(context, "/scannQrcode");
          }
        },
      {
        "service_name": "ساند موضفينك",
        "Navigation": "",
        "icon": "assets/SVGs/baynaty.svg",
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => supportYourEmployees()),
            // ignore: prefer_const_constructors
          );
        }
      },
      {
        "service_name": "مُمْتَنّ",
        "Navigation": "",
        "icon": "assets/SVGs/thanks.svg",
        "Action": () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Momten()),
            // ignore: prefer_const_constructors
          );
        }
      },
    ];
  }

  List attendanceService() {
    return [
      {
        "service_name": "تسجيل الحضور",
        "Navigation": "",
        "icon": 'assets/SVGs/check_in1.svg',
        "Action": () async {
          attendanceServiceFunction(context).InsertAttendance(1);
        },
      },
      {
        "service_name": "تسجيل الإنصراف",
        "Navigation": "",
        "icon": 'assets/SVGs/check_in1.svg',
        "Action": () async {
          attendanceServiceFunction(context).InsertAttendance(2);
        },
      },
      {
        "service_name": "الحضور ولإنصراف",
        "Navigation": "",
        "icon": 'assets/SVGs/AttendanceView.svg',
        "Action": () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GetAttendanceView()),
          );
        },
      }
    ];
  }

  List fastservices() {
    List ww = [];
    ww.addAll([
      if (hasePerm == "true") questService()[1],
      otherService()[1],
      otherService()[2]
    ]);

    return ww;
  }

  List sliderService1() {
    List ww = [];
    if (sharedPref.getInt("empTypeID") == 8) {
      ww.addAll([
        otherService()[0],
        otherService()[1],
        otherService()[2],
        otherService()[3]
      ]);
    } else {
      ww.addAll([
        questService()[0],
        hrservices()[1],
        hrservices()[2],
        hrservices()[4],
      ]);
    }

    return ww;
  }

  List sliderService2() {
    List ww = [];
    if (sharedPref.getInt("empTypeID") == 8) {
      ww.addAll([]);
    } else {
      ww.addAll([
        hrservices()[0],
        hrservices()[3],
        otherService()[2]
        //   otherService()[3]
      ]);
    }

    return ww;
  }
}
