import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ServicesButton extends StatefulWidget {
  ServicesButton({required List button, Key? key}) : super(key: key);

  @override
  State<ServicesButton> createState() => _ServicesButtonState();
}

class _ServicesButtonState extends State<ServicesButton> {
  final services1 = [
    ////شؤون الموظفين
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/ejaza.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/work_out.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "",
      "icon": 'assets/SVGs/balance.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/entdab.svg',
    },
    {
      "service_name": "العهد", /////////
      "Navigation": "/auhad",
      "icon": 'assets/SVGs/3ohad.svg',
    },
    //الرواتب
    {
      "service_name": "سجل الرواتب",
      "Navigation": "/SalaryHistory",
      "icon": 'assets/SVGs/sejelalrawatb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
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
        "Navigation": MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MettingsProvider(),
            // ignore: prefer_const_constructors
            child: MeetingView(),
          ),
        ),
        "icon": 'assets/SVGs/mawa3idi.svg',
      },
    //خدمات أخرى
    // {
    //   "service_name": "الفعاليات",
    //   "Navigation": "",
    //   "icon": 'assets/SVGs/events.svg',
    // },
    // {
    //   "service_name": "عروض الموظفين",
    //   "Navigation": "/EamanaDiscount",
    //   "icon": 'assets/SVGs/offers.svg',
    // },
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
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: responsiveMT(60, 120),
      width: responsiveMT(140, 280),
      child: ElevatedButton(
        style: cardServiece,
        onPressed: () {
          // onClicked();
        },
        child: Row(
          children: [
            SvgPicture.asset(
              "icon",
              //color: Colors.white,
              width: responsiveMT(42, 48),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "text",
                style: descTx1(baseColorText),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
