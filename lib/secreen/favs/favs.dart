import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/Settings/settings%20copy.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class favoriot extends StatefulWidget {
  const favoriot({Key? key}) : super(key: key);

  @override
  State<favoriot> createState() => _favoriotState();
}

class _favoriotState extends State<favoriot> {
  List<String> favs = sharedPref.getStringList("favs") ?? [];
  List<dynamic> list = [];
  final services2 = [
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
    //   "service_name": "عروض",
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
  void initState() {
    // TODO: implement initState

    for (int i = 0; favs.length > i; i++) {
      for (int j = 0; services2.length > j; j++) {
        if (favs[i] == services2[j]["service_name"]) {
          list.insert(0, services2[j]);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("خدماتي المفضلة", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            list.isEmpty
                ? Center(
                    child: Text(
                      "لايوجد خدمات مفضلة",
                      style: titleTx(baseColorText),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                    margin: EdgeInsets.all(10),
                    child: StaggeredGrid.count(
                      crossAxisCount:
                          SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      children: [
                        ...list.map((e) {
                          return StaggeredGridTileW(
                            1,
                            100,
                            ElevatedButton(
                              style: cardServiece,
                              onPressed: () {
                                if (e["service_name"] == "رصيد إجازات") {
                                  rseed();
                                  return;
                                }
                                if (e["service_name"] == "سجل الرواتب" ||
                                    e["service_name"] == "تعريف بالراتب") {
                                  salary(e["service_name"]);
                                  return;
                                }

                                Navigator.pushNamed(context, e["Navigation"]);
                              },
                              child: widgetsUni.cardcontentService(
                                  e["icon"], e["service_name"]),
                            ),
                          );
                        }),
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  Future<void> rseed() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    String emNo = await EmployeeProfile.getEmployeeNumber();
    dynamic respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
    respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
    EasyLoading.dismiss();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: BackGWhiteColor,
          title: Builder(builder: (context) {
            return Center(
              child: Text(
                'رصيد الاجازات',
                style: titleTx(baseColor),
              ),
            );
          }),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                respose.toString(),
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: secondryColor),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetsUni.actionbutton(
                  'طلب إجازة',
                  Icons.send,
                  () {
                    Navigator.pushNamed(context, "/VacationRequest")
                        .then((value) => Navigator.pop(context));
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'إغلاق',
                    style: subtitleTx(baseColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).then((value) => null);
  }

  salary(servName) async {
    if (servName == "تعريف بالراتب") {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      String emNo = await EmployeeProfile.getEmployeeNumber();
      var respons = await getAction("HR/GetEmployeeSalaryReport/" + emNo);
      EasyLoading.dismiss();
      fingerprint == true
          ? Navigator.pushNamed(context, "/auth_secreen").then((value) {
              if (value == true) {
                ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
                    .then((value) {});
              }
            })
          : ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf")
              .then((value) {});
    } else if (servName == "سجل الرواتب") {
      if (fingerprint == true) {
        Navigator.pushNamed(context, "/auth_secreen").then((value) {
          if (value == true) {
            Navigator.pushNamed(this.context, "/SalaryHistory").then((value) {
              //   close(this.context, null);
            });
          }
        });
      } else {
        Navigator.pushNamed(context, "/SalaryHistory").then((value) {});
      }
    }
  }
}
