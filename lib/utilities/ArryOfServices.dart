import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class listOfServices {
  BuildContext context;
  listOfServices(this.context);

  final services2 = [
    if (sharedPref.getInt("empTypeID") != 8)
      ////شؤون الموظفين
      {
        "service_name": "طلب إجازة",
        "Navigation": "/VacationRequest",
        "icon": 'assets/SVGs/ejaza.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "service_name": "طلب خارج دوام",
        "Navigation": "/OutdutyRequest",
        "icon": 'assets/SVGs/work_out.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "service_name": "رصيد إجازات",
        "Navigation": "",
        "icon": 'assets/SVGs/balance.svg'
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
        "service_name": "طلب إنتداب",
        "Navigation": "/entedab",
        "icon": 'assets/SVGs/entdab.svg',
      },
    if (sharedPref.getInt("empTypeID") != 8)
      {
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

  final fastservices = [
    if (hasePerm == "true")
      {
        "service_name": "مواعيدي",
        "Navigation": "/meettingsType",
        "icon": 'assets/SVGs/mawa3idi.svg',
      },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
    {
      "service_name": "معلوماتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
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
  ];
}
