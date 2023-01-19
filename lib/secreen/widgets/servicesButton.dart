import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class ServicesButton extends StatefulWidget {
  ServicesButton({required this.index, Key? key}) : super(key: key);
  final int index;

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

    {
      "service_name": "مواعيدي",
      "Navigation": "/meettingsType",
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

  Future<void> rseed() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    String emNo = await EmployeeProfile.getEmployeeNumber();
    dynamic respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
    respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];

    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "VacationsController";
    logapiO.ClassName = "VacationsController";
    logapiO.ActionMethodName = "رصيد الاجازات";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: responsiveMT(60, 120),
      width: responsiveMT(140, 280),
      child: ElevatedButton(
        style: cardServiece,
        onPressed: () async {
          //final fingerprintSP = await SharedPreferences.getInstance();
          bool fingerprint = sharedPref.getBool('fingerprint')!;
          // if (fingerprint == true) {
          //   Navigator.pushNamed(context, "/auth_secreen").then((value) {
          //     if (value == true) {
          //       Navigator.pushNamed(context, "/SalaryHistory");
          //     }
          //   });
          // } else {
          //   Navigator.pushNamed(context, "/SalaryHistory");
          // }

          dynamic query = services1[widget.index]["service_name"];

          dynamic navi =
              services1[widget.index]["Navigation"].toString().isNotEmpty
                  ? services1[widget.index]["Navigation"]
                  : '/home';

          print(query == "تعريف بالراتب");

          if (query == "رصيد إجازات") {
            rseed();
          } else if (query == "تعريف بالراتب") {
            EasyLoading.show(
              status: '... جاري المعالجة',
              maskType: EasyLoadingMaskType.black,
            );
            String emNo = await EmployeeProfile.getEmployeeNumber();
            var respons = await getAction("HR/GetEmployeeSalaryReport/" + emNo);
            EasyLoading.dismiss();
            if (fingerprint == true) {
              Navigator.pushNamed(context, "/auth_secreen").then((value) {
                if (value == true) {
                  if (jsonDecode(respons.body)["salaryPdf"] != null) {
                    ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf");
                  } else {
                    Alerts.warningAlert(
                            context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
                        .show();
                  }
                }
              });
            } else {
              if (jsonDecode(respons.body)["salaryPdf"] != null) {
                ViewFile.open(jsonDecode(respons.body)["salaryPdf"], "pdf");
              } else {
                Alerts.warningAlert(
                        context, "خطأ", "لا توجد بيانات للتعريف بالراتب")
                    .show();
              }
            }
            logApiModel logapiO = logApiModel();
            logapiO.ControllerName = "SalaryController";
            logapiO.ClassName = "SalaryController";
            logapiO.ActionMethodName = "تعريف بالراتب";
            logapiO.ActionMethodType = 1;
            logapiO.StatusCode = 1;

            logApi(logapiO);
          } else if (query == "سجل الرواتب") {
            if (fingerprint == true) {
              Navigator.pushNamed(context, "/auth_secreen").then((value) {
                if (value == true) {
                  Navigator.pushNamed(this.context, "/SalaryHistory")
                      .then((value) {
                    //   close(this.context, null);
                  });
                }
              });
            } else {
              Navigator.pushNamed(context, "/SalaryHistory");
            }
          } else {
            navi.runtimeType == String
                ? Navigator.pushNamed(context, navi)
                : Navigator.push(context, navi);
          }

          // query == "رصيد إجازات"
          //     ? rseed()
          //     : query == "تعريف بالراتب"
          //         ? fingerprint == true
          //             ? Navigator.pushNamed(context, "/auth_secreen")
          //                 .then((value) {
          //                 if (value == true) {
          //                   ViewFile.open(testbase64Pfd, "pdf")
          //                       .then((value) {
          //                     close(this.context, null);
          //                   });
          //                 }
          //               })
          //             : ViewFile.open(testbase64Pfd, "pdf").then((value) {
          //                 close(this.context, null);
          //               })
          //         : query == "سجل الرواتب"
          //             ? fingerprint == true
          //                 ? Navigator.pushNamed(context, "/auth_secreen")
          //                     .then((value) {
          //                     if (value == true) {
          //                       Navigator.pushNamed(context, navi)
          //                           .then((value) {
          //                         close(this.context, null);
          //                       });
          //                     }
          //                   })
          //                 : Navigator.pushNamed(context, navi)
          //                     .then((value) {
          //                     close(this.context, null);
          //                   })
          //             : navi.runtimeType == String
          //                 ? Navigator.pushNamed(context, navi)
          //                     .then((value) {
          //                     close(this.context, null);
          //                   })
          //                 : Navigator.push(context, navi).then((value) {
          //                     close(this.context, null);
          //                   });
        },
        child: Row(
          children: [
            SvgPicture.asset(
              services1[widget.index]["icon"].toString(),
              //color: Colors.white,
              width: responsiveMT(42, 48),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                services1[widget.index]["service_name"].toString(),
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
