import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int id = 0;
  @override
  void initState() {
    // TODO: implement initState
    embId();
    super.initState();
  }

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
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
                    Text(
                      "شؤون الموظفين",
                      style: subtitleTx(baseColor),
                    ),
                    widgetsUni.divider(),
                    SizedBox(
                      height: 5,
                    ),
                    hrServices(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "الرواتب",
                      style: subtitleTx(baseColor),
                    ),
                    widgetsUni.divider(),
                    salary(),
                    SizedBox(
                      height: 10,
                    ),
                    if (id == 1)
                      Text(
                        "مهامي",
                        style: subtitleTx(baseColor),
                      ),
                    if (id == 1) widgetsUni.divider(),
                    if (id == 1)
                      SizedBox(
                        height: 10,
                      ),
                    if (id == 1) mahamme(),
                    if (id == 1)
                      SizedBox(
                        height: 10,
                      ),
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
                      'assets/SVGs/khareg-dawam.svg', "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () async {
                    EasyLoading.show(
                      status: 'جاري المعالجة...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    String emNo = await EmployeeProfile.getEmployeeNumber();
                    var respose =
                        await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
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
                                jsonDecode(respose.body)["EmpInfo"]
                                        ["VacationBalance"]
                                    .toString(),
                                style: subtitleTx(secondryColor),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: Text(
                                'حسنا',
                                style: subtitleTx(baseColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/rased-ajaza.svg', "رصيد إجازات"))),
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
                      'assets/SVGs/entdab.svg', "العهد"))),
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
                      'assets/SVGs/dalel-emp.svg', "إعتماداتي"))),
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
                      'assets/SVGs/dalel-emp.svg', "مواعيدي")))
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
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    print("object");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/event.svg', "الفعاليات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/EamanaDiscount");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/offers.svg', "عروض الموظفين"))),
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
                Icons.request_page,
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
                "بياناتي",
                Icons.request_page,
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
                  onPressed: () {
                    Navigator.pushNamed(context, "/auth_secreen").then((value) {
                      if (value == true) {
                        Navigator.pushNamed(context, "/SalaryHistory");
                      }
                    });
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/event.svg', "سجل الرواتب"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () async {
                    final fingerprintSP = await SharedPreferences.getInstance();
                    bool fingerprint = fingerprintSP.getBool('fingerprint')!;
                    EasyLoading.show(
                      status: 'جاري المعالجة...',
                      maskType: EasyLoadingMaskType.black,
                    );
                    String emNo = await EmployeeProfile.getEmployeeNumber();
                    var respons =
                        await getAction("HR/GetEmployeeSalaryReport/" + emNo);
                    EasyLoading.dismiss();
                    if (fingerprint) {
                      Navigator.pushNamed(context, "/auth_secreen")
                          .then((value) async {
                        if (value == true) {
                          //      print(jsonDecode(respons.body)["salaryPdf"]);

                          ViewFile.open(
                              jsonDecode(respons.body)["salaryPdf"], "pdf");
                        }
                      });
                    } else {
                      ViewFile.open(
                          jsonDecode(respons.body)["salaryPdf"], "pdf");
                    }
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/dalel-emp.svg', "تعريف بالراتب"))),
        ],
      ),
    );
  }
}
