import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int id = 0;
  String empNo = "";
  @override
  void initState() {
    // TODO: implement initState
    embId();
    super.initState();
  }

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    empNo = await EmployeeProfile.getEmployeeNumber();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarHome.appBarW("جميع الخدمات", context),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(left: 18, right: 18, bottom: 15.h, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شؤون الموظفين
                    //hr
                    if (sharedPref.getInt("empTypeID") != 8)
                      Text(
                        "خدمات الموظفين",
                        style: subtitleTx(baseColor),
                      ),
                    if (sharedPref.getInt("empTypeID") != 8)
                      widgetsUni.divider(),
                    if (sharedPref.getInt("empTypeID") != 8)
                      SizedBox(
                        height: 5,
                      ),
                    hrServices(),
                    SizedBox(
                      height: 10,
                    ),
                    if (sharedPref.getInt("empTypeID") != 8)
                      Text(
                        "الرواتب",
                        style: subtitleTx(baseColor),
                      ),
                    if (sharedPref.getInt("empTypeID") != 8)
                      widgetsUni.divider(),
                    if (sharedPref.getInt("empTypeID") != 8) salary(),
                    if (sharedPref.getInt("empTypeID") != 8)
                      SizedBox(
                        height: 10,
                      ),
                    if (sharedPref.getInt("empTypeID") != 8)
                      Text(
                        "مهامي",
                        style: subtitleTx(baseColor),
                      ),
                    if (sharedPref.getInt("empTypeID") != 8)
                      widgetsUni.divider(),
                    if (sharedPref.getInt("empTypeID") != 8)
                      SizedBox(
                        height: 10,
                      ),
                    if (sharedPref.getInt("empTypeID") != 8) mahamme(),

                    SizedBox(
                      height: 10,
                    ),

                    Text("خدمات أخرى", style: subtitleTx(baseColor)),
                    widgetsUni.divider(),
                    SizedBox(
                      height: 5,
                    ),
                    otherServices(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hrServices() {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          StaggeredGridTileW(
            1,
            hi,
            ElevatedButton(
              style: cardServiece,
              onPressed: () {
                Navigator.pushNamed(context, "/VacationRequest");
              },
              child: widgetsUni.cardcontentService(
                  'assets/SVGs/ejaza.svg', "طلب إجازة"),
            ),
          ),
          // widgetsUni.cardcontentService(
          //   "طلب إجازة",
          //   'assets/SVGs/khareg-dawam.svg',
          //   () {
          //     Navigator.pushNamed(context, "/VacationRequest");
          //   },
          // ),),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/OutdutyRequest");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/work_out.svg', "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () async {
                    EasyLoading.show(
                      status: '... جاري المعالجة',
                      maskType: EasyLoadingMaskType.black,
                    );
                    String emNo = await EmployeeProfile.getEmployeeNumber();
                    dynamic respose =
                        await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
                    respose =
                        jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
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
                                    Navigator.pushNamed(
                                            context, "/VacationRequest")
                                        .then(
                                            (value) => Navigator.pop(context));
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
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/balance.svg', "رصيد إجازات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/entedab");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/entdab.svg', "طلب إنتداب"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/auhad");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/3ohad.svg', "العهد"))),
        ],
      ),
    );
  }

  Widget mahamme() {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 6,
        crossAxisSpacing: 10,
        children: [
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
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
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/e3tmadaty.svg', "إعتماداتي"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => MettingsProvider(),
                          // ignore: prefer_const_constructors
                          child: MeetingView(),
                        ),
                      ),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/mawa3idi.svg', "مواعيدي")))
        ],
      ),
    );
  }

  Widget otherServices() {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return Container(
      //    margin: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 6,
        crossAxisSpacing: 8,
        children: [
          // if (empNo != "1111")
          //   StaggeredGridTile.extent(
          //       crossAxisCellCount: 1,
          //       mainAxisExtent: hi,
          //       child: ElevatedButton(
          //           style: cardServiece,
          //           onPressed: () {
          //             Navigator.pushNamed(context, "/events");
          //           },
          //           child: widgetsUni.cardcontentService(
          //               'assets/SVGs/events.svg', "الفعاليات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    //  Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CategoriesFilter()),
                    // );

                    Navigator.pushNamed(context, "/EamanaDiscount");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/offers.svg', "عروض"))),
          // StaggeredGridTile.extent(
          //   crossAxisCellCount: 1,
          //   mainAxisExtent: hi,
          //   child: ElevatedButton(
          //       style: cardServiece,
          //       onPressed: () {
          //         print("object");
          //       },
          //       child: widgetsUni.cardcontentService(
          //           'assets/SVGs/dalel-emp.svg', "طلب استيكر")),
          // ),

          StaggeredGridTileW(
              1,
              hi,
              widgetsUni.servicebutton2(
                "دليل الموظفين",
                "assets/SVGs/dalelalmowzafen.svg",
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => EmpInfoProvider(),
                          // ignore: prefer_const_constructors
                          child: EmpInfoView(null),
                        ),
                      ));
                },
              )),
          StaggeredGridTileW(
              1,
              hi,
              widgetsUni.servicebutton2(
                "معلوماتي",
                "assets/SVGs/baynaty.svg",
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => EmpInfoProvider(),
                          // ignore: prefer_const_constructors
                          child: EmpProfile(null),
                        ),
                      ));
                },
              )),
          StaggeredGridTileW(
              1,
              hi,
              widgetsUni.servicebutton2(
                "المفضلة",
                "assets/SVGs/bookmarks.svg",
                () {
                  Navigator.pushNamed(context, "/favs");
                },
              )),
        ],
      ),
    );
  }

  Widget salary() {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;

    return Container(
      //    margin: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 6,
        crossAxisSpacing: 8,
        children: [
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () async {
                    //final fingerprintSP = await SharedPreferences.getInstance();
                    bool fingerprint = sharedPref.getBool('fingerprint')!;
                    if (fingerprint == true) {
                      Navigator.pushNamed(context, "/auth_secreen")
                          .then((value) {
                        if (value == true) {
                          Navigator.pushNamed(context, "/SalaryHistory");
                        }
                      });
                    } else {
                      Navigator.pushNamed(context, "/SalaryHistory");
                    }
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/sejelalrawatb.svg', "سجل الرواتب"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () async {
                    //final fingerprintSP = await SharedPreferences.getInstance();
                    bool fingerprint = sharedPref.getBool('fingerprint')!;
                    EasyLoading.show(
                      status: '... جاري المعالجة',
                      maskType: EasyLoadingMaskType.black,
                    );
                    String emNo = await EmployeeProfile.getEmployeeNumber();
                    var respons =
                        await getAction("HR/GetEmployeeSalaryReport/" + emNo);
                    EasyLoading.dismiss();
                    if (fingerprint == true) {
                      Navigator.pushNamed(context, "/auth_secreen")
                          .then((value) async {
                        if (value == true) {
                          //      print(jsonDecode(respons.body)["salaryPdf"]);

                          if (jsonDecode(respons.body)["salaryPdf"] != null) {
                            ViewFile.open(
                                jsonDecode(respons.body)["salaryPdf"], "pdf");
                          } else {
                            Alerts.warningAlert(context, "خطأ",
                                    "لا توجد بيانات للتعريف بالراتب")
                                .show();
                          }
                        }
                      });
                    } else {
                      if (jsonDecode(respons.body)["salaryPdf"] != null) {
                        ViewFile.open(
                            jsonDecode(respons.body)["salaryPdf"], "pdf");
                      } else {
                        Alerts.warningAlert(context, "خطأ",
                                "لا توجد بيانات للتعريف بالراتب")
                            .show();
                      }
                    }
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/ta3refalratb.svg', "تعريف بالراتب"))),
        ],
      ),
    );
  }
}
