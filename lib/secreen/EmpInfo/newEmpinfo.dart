import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class newEmpInfo extends StatefulWidget {
  bool? showArrow;
  newEmpInfo(this.showArrow);
  @override
  State<newEmpInfo> createState() => _newEmpInfoState();
}

class _newEmpInfoState extends State<newEmpInfo> {
  var empInfo;
  String datedesc = "";
  @override
  void initState() {
    // TODO: implement initState
    getData();
    ;
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var g_date = HijriCalendar();
    List date = sharedPref.getString("HireDate").toString().split("/");
    if (date[0] != "") {
      DateTime date2 = g_date.hijriToGregorian(
          int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
      int aa = date2.subtract(Duration(days: DateTime.now().year * 365)).year;
      print(aa.abs());
      aa = aa.abs();
      if (aa == 1 || aa == 2) {
        if (aa == 1) {
          datedesc = "منضم منذ " + " سنة";
        } else {
          datedesc = "منضم منذ " + " سنتين";
        }
      } else if (aa > 2 && aa < 11) {
        datedesc = "منضم منذ " + aa.toString() + " سنوات";
      } else {
        datedesc = "منضم منذ " + aa.toString() + " سنة";
      }
      setState(() {});
    }

    var response = await getAction(
        "HR/GetEmployees/" + EmployeeProfile.getEmployeeNumber());
    empInfo = jsonDecode(response.body)["EmpInfo"];
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "profile";
    logapiO.ClassName = "profile";
    logapiO.ActionMethodName = "معلوماتي";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: BackGWhiteColor,
            height: 100.h,
            child: Stack(
              children: [
                //widgetsUni.bacgroundimage(),
                Positioned(
                  bottom: (sharedPref.getInt("empTypeID") != 8) ? 140 : 150,
                  child: SafeArea(
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: bordercolor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: baseColor, // background
                                  onPrimary: Colors.white, // foreground

                                  elevation: 2),
                              onPressed: () async {
                                getPdfasync();
                              },
                              child: Text('مشاركة بطاقة العمل'),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: bordercolor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: baseColor, // background
                                  onPrimary: Colors.white, // foreground

                                  elevation: 2),
                              onPressed: () {
                                addtoAplewalletasync();
                              },
                              child: Text('إضافة إلي المحفظة'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          sharedPref.getBool("darkmode") == false
                              ? baseColor
                              : BackGColor,
                          secondryColor,
                        ],
                      )),
                      height: (sharedPref.getInt("empTypeID") != 8) ? 230 : 200,
                      child: Stack(
                        overflow: Overflow.visible,
                        fit: StackFit.loose,
                        children: [
                          SafeArea(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: widget.showArrow == true
                                                ? true
                                                : false,
                                            child: Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                          Text(
                                            sharedPref
                                                    .getString("FirstName")
                                                    .toString() +
                                                " " +
                                                sharedPref
                                                    .getString("LastName")
                                                    .toString(),
                                            style: titleTx(Colors.white),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          Text(
                                            (sharedPref
                                                        .getString("Title")
                                                        .toString() ==
                                                    ""
                                                ? sharedPref
                                                    .getString("JobName")
                                                    .toString()
                                                : sharedPref
                                                    .getString("Title")
                                                    .toString()),
                                            style: subtitleTx(Colors.white),
                                          ),
                                          Text(
                                            datedesc,
                                            style: subtitleTx(Colors.white),
                                          ),
                                        ],
                                      ),
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                  sharedPref
                                                      .getString("ImageURL")
                                                      .toString(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "assets/image/blank-profile.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (sharedPref.getInt("empTypeID") != 8)
                            Positioned(
                              bottom: -60,
                              child: Row(
                                children: [
                                  Cards(
                                      empInfo == null
                                          ? ""
                                          : empInfo[0]["VacationBalance"]
                                              .toString(),
                                      "الإجازات"),
                                  Cards(sharedPref.getInt("ClassID").toString(),
                                      "المرتبة"),
                                  Cards(sharedPref.getInt("GradeID").toString(),
                                      "الدرجة"),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (sharedPref.getInt("empTypeID") != 8) ? 80 : 40,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "معلوماتي",
                              style: titleTx(baseColorText),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Rows(
                                "الرقم الوضيفي",
                                EmployeeProfile.getEmployeeNumber(),
                                Icons.dialpad_sharp,
                                secondryColor),
                            // Rows("الراتب", "20000", Icons.attach_money_outlined,
                            //     secondryColor),
                            if (sharedPref.getInt("empTypeID") != 8)
                              Rows(
                                  "المرتبة",
                                  sharedPref.getInt("ClassID").toString(),
                                  Icons.grade,
                                  baseColor),
                            if (sharedPref.getInt("empTypeID") != 8)
                              Rows(
                                  "الدرجة",
                                  sharedPref.getInt("GradeID").toString(),
                                  Icons.stairs,
                                  secondryColor),
                            Rows(
                                "الإيميل",
                                sharedPref.getString("Email").toString() +
                                    "@eamana.gov.sa",
                                Icons.email,
                                baseColor),
                            Rows(
                                "الجوال",
                                sharedPref.getString("MobileNumber") ?? "",
                                Icons.phone,
                                secondryColor),
                            Rows("جهة العمل", "أمانة الشرقية",
                                Icons.location_on, baseColor),
                            if (sharedPref.getInt("empTypeID") != 8)
                              Rows(
                                  "تاريخ الإنضمام",
                                  sharedPref.getString("HireDate") ?? "",
                                  Icons.date_range,
                                  secondryColor),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Cards(String title, String desc) {
    return Container(
      height: 120,
      width: 100,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5,
              offset: Offset(8, 8), // Shadow position
            ),
          ],
          color: BackGWhiteColor,
          border: Border.all(color: bordercolor),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: subtitleTx(secondryColor),
            textAlign: TextAlign.right,
          ),
          Text(
            desc,
            style: titleTx(secondryColorText),
          ),
        ],
      ),
    );
  }

  Widget Rows(String tiltle, String desc, dynamic icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                tiltle,
                style: subtitleTx(baseColorText),
              ),
            ],
          ),
          Text(desc, style: subtitleTx(baseColorText)),
        ],
      ),
    );
  }

  Future getPdfasync() async {
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "DaleelController";
    logapiO.ClassName = "DaleelController";
    logapiO.ActionMethodName = "مشاركة معلوماتي";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    final pdf = pw.Document();
    var imag = pw.MemoryImage(
        (await rootBundle.load('assets/SVGs/amanah-v.png'))
            .buffer
            .asUint8List());
    final fontData = await rootBundle.load("assets/Cairo-Regular.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Container(
                  child: pw.Center(
                      child: pw.Container(
                height: 250,
                width: 500,
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.only(
                      topLeft: pw.Radius.circular(10),
                      topRight: pw.Radius.circular(10),
                      bottomLeft: pw.Radius.circular(10),
                      bottomRight: pw.Radius.circular(10)),
                  boxShadow: [
                    pw.BoxShadow(
                        color: PdfColorGrey(0.1),
                        spreadRadius: 18,
                        blurRadius: 18,
                        offset: PdfPoint(0, 3)
                        // changes position of shadow
                        ),
                  ],
                ),
                margin: pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Container(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        sharedPref.getString("EmployeeName") ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            color: PdfColor.fromHex('#1F9EB9'),
                            fontSize: 18,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        sharedPref.getString("Title") ?? "",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(font: ttf),
                      ),
                      pw.SizedBox(
                        height: 10,
                      ),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Container(
                              width: 150,
                              height: 130,
                              child: pw.Image(
                                imag,
                                alignment: pw.Alignment.center,
                                //width:
                                //    pw. MediaQuery.of(context).size.width,
                                //height: MediaQuery.of(context).size.height,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          sharedPref
                                                  .getString("MobileNumber") ??
                                              "",
                                          style: pw.TextStyle(font: ttf)),
                                      pw.Text("رقم الجوال : ",
                                          style: pw.TextStyle(font: ttf)),
                                    ]),
                                pw.Container(
                                  child: pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.end,
                                      children: [
                                        pw.Text(
                                            sharedPref
                                                    .getInt("Extension")
                                                    .toString() ??
                                                "",
                                            style: pw.TextStyle(font: ttf)),
                                        pw.Text("رقم التحويلة : ",
                                            style: pw.TextStyle(font: ttf)),
                                      ]),
                                ),
                                pw.Row(children: [
                                  pw.Text(
                                      sharedPref.getString("Email") ??
                                          "" + "@eamana.gov.sa",
                                      style: pw.TextStyle(font: ttf)),
                                  pw.Text("البريد الالكتروني : ",
                                      style: pw.TextStyle(font: ttf)),
                                ]),
                                pw.Row(children: [
                                  pw.Text(EmployeeProfile.getEmployeeNumber(),
                                      style: pw.TextStyle(font: ttf)),
                                  pw.Text("الرقم الوظيفي : ",
                                      style: pw.TextStyle(font: ttf)),
                                ]),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
                      // Center
                      )));
        }));

    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
        '${dir.path}/${(sharedPref.getString("FirstName") ?? "") + " " + (sharedPref.getString("LastName") ?? "")}.pdf');

    await file.writeAsBytes(bytes);
    final url = file.path;

    await OpenFilex.open(url);
  }

  addtoAplewalletasync() async {
    try {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 200,
            child: Column(
              children: [
                Text(
                  "اللغة المفضلة",
                  style: subtitleTx(baseColor),
                ),
                SizedBox(
                  height: 5,
                ),
                // widgetsUni.divider(),

                widgetsUni.divider(),

                TextButton(
                    onPressed: () async {
                      logApiModel logapiO = logApiModel();
                      logapiO.ControllerName = "DaleelController";
                      logapiO.ClassName = "DaleelController";
                      logapiO.ActionMethodName = "apple_wallet";
                      logapiO.ActionMethodType = 1;
                      logapiO.StatusCode = 1;
                      logApi(logapiO);
                      try {
                        // await launchUrl(
                        //     await Uri.parse(
                        //         "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_Pkpass2.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}"));

                        await launchUrl(await Uri.parse(
                            "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${sharedPref.getString("Email") ?? ""}&token=${sharedPref.getString('AccessToken')}&lang=ar"));
                      } catch (e) {}
                    },
                    child: Text("اللغة االعربية")),
                TextButton(
                    onPressed: () async {
                      try {
                        // EasyLoading.show(
                        //   status:
                        //       '... جاري المعالجة',
                        //   maskType:
                        //       EasyLoadingMaskType
                        //           .black,
                        // );

                        // Response response;
                        // Dio dio = new Dio();

                        // final appStorage =
                        //     await getApplicationDocumentsDirectory();
                        // var file = File(
                        //     '${appStorage.path}/wallet.pkpass');
                        // final raf = file.openSync(
                        //   mode: FileMode.append,
                        // );

                        // response = await dio.post(
                        //   "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=ar",
                        //   options: Options(
                        //       responseType:
                        //           ResponseType
                        //               .bytes,
                        //       followRedirects:
                        //           false,
                        //       receiveTimeout: 0),
                        // );
                        // if (response.data !=
                        //     null) {
                        //   try {
                        //     raf.writeFromSync(
                        //         response.data);
                        //     await raf.close();
                        //     print("path = " +
                        //         file.path);
                        //   } catch (e) {
                        //     print(e);
                        //   }
                        // } else {
                        //   print("Data error");
                        // }
                        // // PassFile passFile =
                        // //     await Pass()
                        // //         .fetchPreviewFromUrl(
                        // //             url: response
                        // //                 .data);
                        // // passFile.save();
                        // EasyLoading.dismiss();
                        // OpenFilex.open(file.path);
                        logApiModel logapiO = logApiModel();
                        logapiO.ControllerName = "DaleelController";
                        logapiO.ClassName = "DaleelController";
                        logapiO.ActionMethodName = "apple_wallet";
                        logapiO.ActionMethodType = 1;
                        logapiO.StatusCode = 1;
                        logApi(logapiO);
                        await launchUrl(await Uri.parse(
                            "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${(sharedPref.getString("Email") ?? "")}&token=${sharedPref.getString('AccessToken')}&lang=en"));
                      } catch (e) {
                        print("error");
                      }
                    },
                    child: Text("اللغة الانجليزية")),
              ],
            ),
          );
        },
      );
    } catch (e) {
      return;
    }
  }
}
