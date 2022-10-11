import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpProfile extends StatefulWidget {
  bool? showBack;
  EmpProfile(this.showBack);

  @override
  _EmpProfileState createState() => _EmpProfileState();
}

class _EmpProfileState extends State<EmpProfile> {
  final _formKey = GlobalKey();

  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await Provider.of<EmpInfoProvider>(context, listen: false).fetchEmpInfo(
          _pref.getDouble("EmployeeNumber").toString().split(".")[0]);

      EasyLoading.dismiss();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageHgit = 0;
    double imagemargin = 0;
    print(width);
    if (width >= 1024.0) {
      imageHgit = 350;
      imagemargin = 45;
    } else if (width >= 768) {
      imageHgit = 280;
      imagemargin = 30;
    } else {
      imageHgit = 150;
      imagemargin = 10;
    }
    var _provider = Provider.of<EmpInfoProvider>(context).empinfoList;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(
            "معلوماتي", context, widget.showBack == null ? null : true),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            _provider.length == 0
                ? Container()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: width,
                                  child: Image.asset(
                                    "assets/SVGs/profileBackground.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: imagemargin),
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: imageHgit,
                                      width: imageHgit,
                                      child: _provider[0].ImageURL == ""
                                          ? Image.asset(
                                              "assets/image/blank-profile.png",
                                              fit: BoxFit.fill,
                                            )
                                          : ClipOval(
                                              child: CachedNetworkImage(
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                        _provider[0]
                                                            .ImageURL
                                                            .toString(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  "assets/image/blank-profile.png",
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextW_size(
                            _provider[0].EmployeeName,
                          ),
                          TextW(_provider[0].Title),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              key: _formKey,
                              style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1,
                                    color: bordercolor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  primary: BackGWhiteColor, // background
                                  onPrimary: Colors.black, // foreground

                                  elevation: 2),
                              onPressed: () async {
                                getPdfasync(_provider);
                              },
                              child: Container(
                                height: 250,
                                width: 500,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _provider[0].EmployeeName,
                                      style: TextStyle(
                                          color: baseColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextW(
                                      _provider[0].Title,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextW("رقم الجوال : " +
                                                _provider[0].MobileNumber),
                                            TextW("رقم التحويلة : " +
                                                _provider[0]
                                                    .Extension
                                                    .toString()),
                                            TextW("البريد الالكتروني : " +
                                                _provider[0].Email),
                                            TextW("الرقم الوظيفي : " +
                                                _provider[0]
                                                    .EmployeeNumber
                                                    .toString()
                                                    .split(".")[0]),
                                          ],
                                        ),
                                        Container(
                                          width: 120,
                                          height: 120,
                                          child: Image.asset(
                                            'assets/SVGs/amanah-v.png',
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            //height: MediaQuery.of(context).size.height,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widgetsUni.actionbutton(
                                "مشاركة معلوماتي",
                                Icons.share,
                                () async {
                                  getPdfasync(_provider);
                                },
                              ),
                              // if (Platform.isIOS)
                              GestureDetector(
                                onTap: () async {
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
                                                    try {
                                                      // await launchUrl(
                                                      //     await Uri.parse(
                                                      //         "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_Pkpass2.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}"));

                                                      await launchUrl(
                                                          await Uri.parse(
                                                              "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=ar"));
                                                    } catch (e) {}
                                                  },
                                                  child:
                                                      Text("اللغة االعربية")),
                                              TextButton(
                                                  onPressed: () async {
                                                    try {
                                                      EasyLoading.show(
                                                        status:
                                                            '... جاري المعالجة',
                                                        maskType:
                                                            EasyLoadingMaskType
                                                                .black,
                                                      );

                                                      Response response;
                                                      Dio dio = new Dio();

                                                      final appStorage =
                                                          await getApplicationDocumentsDirectory();
                                                      var file = File(
                                                          '${appStorage.path}/wallet.pkpass');
                                                      final raf = file.openSync(
                                                        mode: FileMode.append,
                                                      );

                                                      response = await dio.post(
                                                        "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=ar",
                                                        options: Options(
                                                            responseType:
                                                                ResponseType
                                                                    .bytes,
                                                            followRedirects:
                                                                false,
                                                            receiveTimeout: 0),
                                                      );
                                                      if (response.data !=
                                                          null) {
                                                        try {
                                                          raf.writeFromSync(
                                                              response.data);
                                                          await raf.close();
                                                          print("path = " +
                                                              file.path);
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      } else {
                                                        print("Data error");
                                                      }
                                                      // PassFile passFile =
                                                      //     await Pass()
                                                      //         .fetchPreviewFromUrl(
                                                      //             url: response
                                                      //                 .data);
                                                      // passFile.save();
                                                      EasyLoading.dismiss();
                                                      OpenFilex.open(file.path);

                                                      // await launchUrl(
                                                      //     await Uri.parse(
                                                      //         "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=en"));
                                                    } catch (e) {
                                                      print("error");
                                                    }
                                                  },
                                                  child:
                                                      Text("اللغة الانجليزية")),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    return;
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/SVGs/AR_Add_to_Apple_Wallet.svg',
                                  height: 37,
                                ),
                              ),
                              // widgetsUni.actionbutton(
                              //   "إضافة إلي لمحفضة",
                              //   Icons.wallet_giftcard,
                              //   () async {
                              //     try {
                              //       showModalBottomSheet<void>(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return Container(
                              //             padding: EdgeInsets.all(10),
                              //             height: 200,
                              //             child: Column(
                              //               children: [
                              //                 Text(
                              //                   "اللغة المفضلة",
                              //                   style: subtitleTx(baseColor),
                              //                 ),
                              //                 SizedBox(
                              //                   height: 5,
                              //                 ),
                              //                 // widgetsUni.divider(),

                              //                 widgetsUni.divider(),

                              //                 TextButton(
                              //                     onPressed: () async {
                              //                       try {
                              //                         // await launchUrl(
                              //                         //     await Uri.parse(
                              //                         //         "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_Pkpass2.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}"));

                              //                         await launchUrl(
                              //                             await Uri.parse(
                              //                                 "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=ar"));
                              //                       } catch (e) {}
                              //                     },
                              //                     child:
                              //                         Text("اللغة االعربية")),
                              //                 TextButton(
                              //                     onPressed: () async {
                              //                       try {
                              //                         await launchUrl(
                              //                             await Uri.parse(
                              //                                 "https://crm.eamana.gov.sa/agenda_dev/api/apple_wallet/pkpass_API/Eamana_PkpassArOrEn.php?email=${_provider[0].Email}&token=${sharedPref.getString('AccessToken')}&lang=en"));
                              //                       } catch (e) {}
                              //                     },
                              //                     child:
                              //                         Text("اللغة الانجليزية")),
                              //               ],
                              //             ),
                              //           );
                              //         },
                              //       );
                              //     } catch (e) {
                              //       return;
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget TextW(String val) {
    return Text(
      val,
      style: TextStyle(fontFamily: "Cairo", color: baseColorText),
    );
  }

  Widget TextW_size(String val) {
    return Text(
      val,
      style: TextStyle(
          fontFamily: "Cairo",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: baseColor),
    );
  }

  Future getPdfasync(_provider) async {
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
                        _provider[0].EmployeeName,
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            color: PdfColor.fromHex('#1F9EB9'),
                            fontSize: 18,
                            font: ttf,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        _provider[0].Title,
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
                                      pw.Text(_provider[0].MobileNumber,
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
                                            _provider[0].Extension.toString(),
                                            style: pw.TextStyle(font: ttf)),
                                        pw.Text("رقم التحويلة : ",
                                            style: pw.TextStyle(font: ttf)),
                                      ]),
                                ),
                                pw.Row(children: [
                                  pw.Text(
                                      _provider[0].Email.toString() +
                                          "@eamana.gov.sa",
                                      style: pw.TextStyle(font: ttf)),
                                  pw.Text("البريد الالكتروني : ",
                                      style: pw.TextStyle(font: ttf)),
                                ]),
                                pw.Row(children: [
                                  pw.Text(
                                      _provider[0]
                                          .EmployeeNumber
                                          .toString()
                                          .split(".")[0],
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
        '${dir.path}/${_provider[0].FirstName + " " + _provider[0].LastName}.pdf');

    await file.writeAsBytes(bytes);
    final url = file.path;

    await OpenFilex.open(url);
  }
}
