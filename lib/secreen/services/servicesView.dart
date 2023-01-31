import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/EmpInfo/newEmpinfo.dart';
import 'package:eamanaapp/secreen/Evaluation/EmployeeEvaluationMaster.dart';
import 'package:eamanaapp/secreen/Meetings/mettingsType.dart';
import 'package:eamanaapp/secreen/RequestsHrHistory.dart/desclaimer.dart';
import 'package:eamanaapp/secreen/customerService/customerEntrance.dart';
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/customerService/statistics.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/SLL_pin.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/determinePosition.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// print(udid);
class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int id = 0;
  String empNo = "";
  List<int> insertExtensionRequestValid = [0, 6, 7];

  @override
  void initState() {
    // TODO: implement initState
    shownotfNub();
    embId();
    hasPermission2();
    print("object");
    // notificationcont = 3;
    super.initState();
  }

  shownotfNub() async {
    var response = await getAction("Hr/GetNotReadNotificationsCount/" +
        EmployeeProfile.getEmployeeNumber());
    notificationcont = jsonDecode(response.body)["ReturnResult"] == null ||
            jsonDecode(response.body)["ReturnResult"] == 0
        ? null
        : jsonDecode(response.body)["ReturnResult"];
    setState(() {});
  }

  Future<void> hasPermission2() async {
    EmployeeProfile empinfo = await EmployeeProfile();

    empinfo = await empinfo.getEmployeeProfile();
    if (await checkSSL(
        "https://crm.eamana.gov.sa/agenda/api/api-mobile/getAppointmentsPermission.php")) {
      try {
        var respose = await http.post(
            Uri.parse(CRMURL + "api-mobile/getAppointmentsPermission.php"),
            body: jsonEncode({
              "token": sharedPref.getString("AccessToken"),
              "username": empinfo.Email
            }));
        hasePerm = jsonDecode(respose.body)["message"];
        sharedPref.setBool(
            "permissionforCRM", jsonDecode(respose.body)["permissionforCRM"]);
        sharedPref.setString(
            "deptid", jsonDecode(respose.body)["deptid"] ?? "");
        sharedPref.setString(
            "leadid", jsonDecode(respose.body)["leadid"] ?? "");
        sharedPref.setBool("permissionforAppManege3",
            jsonDecode(respose.body)["permissionforAppManege"]);
        sharedPref.setBool("permissionforAppReq",
            jsonDecode(respose.body)["permissionforAppReq"]);
        setState(() {});
      } catch (e) {}
    } else {
      return;
    }

    //hasePerm = hasePerm;
    print("rr == " + hasePerm.toString());
    //SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("hasePerm", hasePerm.toString());
    hasePerm = hasePerm.toString();
    setState(() {});
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
        appBar:
            AppBarHome.appBarW("جميع الخدمات", context, true, notificationcont),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
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
                    if (sharedPref.getInt("empTypeID") != 8) hrServices(),
                    if (sharedPref.getInt("empTypeID") == 8)
                      Text(
                        "الحضور والإنصراف",
                        style: subtitleTx(baseColor),
                      ),
                    if (sharedPref.getInt("empTypeID") == 8)
                      widgetsUni.divider(),
                    if (sharedPref.getInt("empTypeID") == 8)
                      SizedBox(
                        height: 10,
                      ),
                    if (sharedPref.getInt("empTypeID") == 8) checkinAndOut(),
                    if (sharedPref.getInt("empTypeID") == 8)
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

                    Text(
                      "مهامي",
                      style: subtitleTx(baseColor),
                    ),

                    widgetsUni.divider(),

                    SizedBox(
                      height: 10,
                    ),
                    mahamme(),

                    // SizedBox(
                    //   height: 10,
                    // ),

                    // Text(
                    //   "المخالفات الإلكترونية",
                    //   style: subtitleTx(baseColor),
                    // ),

                    // widgetsUni.divider(),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // violation(),

                    SizedBox(
                      height: 10,
                    ),
                    if (sharedPref.getBool("permissionforCRM") == true)
                      Text("خدمة العملاء", style: subtitleTx(baseColor)),
                    if (sharedPref.getBool("permissionforCRM") == true)
                      widgetsUni.divider(),
                    if (sharedPref.getBool("permissionforCRM") == true)
                      SizedBox(
                        height: 5,
                      ),
                    if (sharedPref.getBool("permissionforCRM") == true)
                      customerService(),
                    SizedBox(
                      height: 5,
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

  Widget checkinAndOut() {
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
                  onPressed: () async {
                    InsertAttendance(1);
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/check_in.svg', "تسجيل الحضور"))),
          if (sharedPref.getString("dumyuser") != "10284928492")
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: hi,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () async {
                      InsertAttendance(2);
                    },
                    child: widgetsUni.cardcontentService(
                        'assets/SVGs/check_out.svg', "تسجيل الإنصراف")))
        ],
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
                    dynamic respose;
                    if (sharedPref.getString("dumyuser") != "10284928492") {
                      String emNo = await EmployeeProfile.getEmployeeNumber();
                      respose =
                          await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
                      respose = jsonDecode(respose.body)["EmpInfo"]
                          ["VacationBalance"];
                    } else {
                      await Future.delayed(Duration(seconds: 1));
                      respose = "22";
                    }
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
          StaggeredGridTileW(
            1,
            hi,
            ElevatedButton(
              style: cardServiece,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // ignore: prefer_const_constructors
                    builder: (BuildContext context) {
                      return EmployeeEvaluationMaster();
                    },
                  ),
                );
              },
              child: widgetsUni.cardcontentService(
                  'assets/SVGs/rate.svg', "تقييماتي"),
            ),
          ),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => desclaimer()),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/desclaimer.svg', "إستعلام إخلاء طرف"))),
          if (insertExtensionRequestValid
              .contains(sharedPref.getInt("empTypeID")))
            StaggeredGridTileW(
              1,
              hi,
              ElevatedButton(
                style: cardServiece,
                onPressed: () {
                  insertExtensionRequest();
                },
                child: widgetsUni.cardcontentService(
                    'assets/SVGs/Insertvacation.svg', "ترحيل الاجازة"),
              ),
            ),
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
          if (sharedPref.getString("dumyuser") != "10284928492")
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: hi,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // ignore: prefer_const_constructors
                          builder: (BuildContext context) {
                            return meettingsType();
                          },
                        ),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangeNotifierProvider(
                      //       create: (context) => MettingsProvider(),
                      //       // ignore: prefer_const_constructors
                      //       child: MeetingView(),
                      //     ),
                      //   ),
                      // );
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ChangeNotifierProvider(
                  //         create: (context) => EmpInfoProvider(),
                  //         // ignore: prefer_const_constructors
                  //         child: EmpProfile(null),
                  //       ),
                  //     ));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => newEmpInfo(true)),
                    // ignore: prefer_const_constructors
                  );
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
          if (sharedPref.getString("dumyuser") != "10284928492")
            StaggeredGridTileW(
                1,
                hi,
                widgetsUni.servicebutton2(
                  "QR Code",
                  "assets/SVGs/qr_code_scanner.svg",
                  () {
                    Navigator.pushNamed(context, "/scannQrcode");
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
                    if (sharedPref.getString("dumyuser") != "10284928492") {
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
                    } else {
                      await Future.delayed(Duration(seconds: 1));
                      EasyLoading.dismiss();
                      Alerts.errorAlert(context, "", "لايوجد تعريف بالراتب")
                          .show();
                    }
                    logApiModel logapiO = logApiModel();
                    logapiO.ControllerName = "SalaryController";
                    logapiO.ClassName = "SalaryController";
                    logapiO.ActionMethodName = "تعريف بالراتب";
                    logapiO.ActionMethodType = 1;
                    logapiO.StatusCode = 1;

                    logApi(logapiO);
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/ta3refalratb.svg', "تعريف بالراتب"))),
        ],
      ),
    );
  }

  violation() {
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
                    Navigator.pushNamed(context, "/ViolationHome");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/violation.svg', "إنشاء مخالفة"))),
        ],
      ),
    );
  }

  customerService() {
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
                          builder: (context) => customerServiceRrequests("")),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/violation.svg', "عرض الطلبات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/reserveForcustomer");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/set_appoinment.svg', "حجز موعد"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => statistics()),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/assessment.svg', "الإحصائيات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => customerEnterance()),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/login.svg', "تسجيل حضور"))),
        ],
      ),
    );
  }

  void insertExtensionRequest() {
    Alerts.confirmAlrt(context, "ترحيل الاجازة",
            "سيتم ترحيل الاجازة, هل انت موافق ؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );

        var respose = await postAction(
            "HR/InsertExtensionRequest",
            jsonEncode({
              "EmployeeNumber": int.parse(sharedPref
                  .getDouble("EmployeeNumber")
                  .toString()
                  .split(".")[0])
            }));

        print(respose.body);

        respose = jsonDecode(respose.body);

        EasyLoading.dismiss();

        if (respose["StatusMessage"] == "Succeeded") {
          Alerts.successAlert(context, "ترحيل الاجازة", "تم الطلب الترحيل")
              .show();
        } else {
          Alerts.errorAlert(
                  context, "ترحيل الاجازة", respose["ErrorMessage"] ?? "")
              .show();
        }

        // setState(() {});
      }
    });
    ;
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  bool? _authenticated;

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

    await _checkBiometrics();

    if (_canCheckBiometrics == true) {
      await _authenticate();
    } else {
      setState(() {
        _authenticated = false;
      });
      Alerts.warningAlert(
              context, "تنبيه", "لا يمكن تفعيل البصمة, لعدم توفره بالجهاز")
          .show();
    }
    EasyLoading.dismiss();
    if (_authenticated == true) {
      // show popup massage then push api
      Alerts.confirmAlrt(context, "تسجيل حضور", "هل تريد تسجيل الحضور", "نعم")
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
            Alerts.successAlert(
                    context,
                    respose["ReturnResult"]["ActionDate"] +
                        " " +
                        "تسجيل الحضور بنجاح",
                    "تم تسجيل الحضور")
                .show();
          } else {
            Alerts.errorAlert(
                    context, "تسجيل الحضور", respose["ErrorMessage"] ?? "")
                .show();
          }
        }
      });
    } else {
      //if canceleds
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _authenticated = authenticated;
      });
    } on PlatformException catch (e) {
      setState(() {
        _authenticated = authenticated;
      });
      print(e);
      return;
    }
    if (!mounted) {
      return;
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
}
