import 'package:barcode_widget/barcode_widget.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/CSS.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String vcarddate = "";
  String? title = sharedPref.getString("Title") == "" ||
          sharedPref.getString("Title") == null
      ? sharedPref.getString("JobName")
      : sharedPref.getString("Title");
  var vCard = VCard();
  void setvcard() {
    vCard.firstName = sharedPref.getString("FirstName").toString();
    vCard.lastName = sharedPref.getString("LastName").toString();
    vCard.cellPhone = sharedPref.getString("MobileNumber").toString();
    vCard.email = sharedPref.getString("Email").toString() + "@eamana.gov.sa";
    vCard.organization = "أمانة المنطقة الشرقية";
    vCard.jobTitle = title;

    setState(() {
      vcarddate = vCard.getFormattedString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setvcard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: BackGColor,
        body: SingleChildScrollView(
          child: Container(
            height: 100.h,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              //   overflow: Overflow.visible,
              children: [
                Container(
                  height: 200,
                  width: 100.w,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.fromLTRB(108, 64, 24, 18),
                  decoration: BoxDecoration(
                    color: fontsStyle.HeaderColor(),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      Text(
                        "بطاقتي",
                        style: fontsStyle.px20(Colors.white, FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 140,
                  // right: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000).withOpacity(0.17),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                            color: BackGWhiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(17.2),
                            )),
                        width: 85.w,
                        // height: 220,
                        // color: Colors.amber,
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/SVGs/amana-icon.svg',
                              height: 60,
                              // width: 50,
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sharedPref.getString("EmployeeName") ??
                                          "",
                                      style: fontsStyle.px14(
                                          fontsStyle.baseColor(),
                                          FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      title ?? "",
                                      style: fontsStyle.px14(
                                          fontsStyle.baseColor(),
                                          FontWeight.bold),
                                    ),
                                  ],
                                ),
                                BarcodeWidget(
                                  barcode: Barcode
                                      .qrCode(), // Barcode type and settings
                                  data: vcarddate,
                                  width: 80,
                                  height: 80,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   "الإدارة : " +
                                //       sharedPref
                                //           .getString("DepartmentName")
                                //           .toString(),
                                //   style: fontsStyle.px13(
                                //     fontsStyle.thirdColor(),
                                //     FontWeight.normal,
                                //   ),
                                // ),
                                Text(
                                  "الجنسية : " +
                                      sharedPref
                                          .getString("Country")
                                          .toString(),
                                  style: fontsStyle.px13(
                                    fontsStyle.thirdColor(),
                                    FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  "الرقم الوظيفي : " +
                                      EmployeeProfile.getEmployeeNumber(),
                                  style: fontsStyle.px13(
                                    fontsStyle.thirdColor(),
                                    FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   "الجنسية : " +
                                //       sharedPref.getString("Country").toString(),
                                //   style: fontsStyle.px13(
                                //     fontsStyle.thirdColor(),
                                //     FontWeight.normal,
                                //   ),
                                // ),
                                // Text("صالحة للغاية : 1/1/2050"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 42,
                      ),
                      Container(
                        width: 200,
                        child:
                            CSS.baseElevatedButton("إضافة إلى المحفظة", 0, () {
                          addtoAplewalletasync();
                        }),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   padding: EdgeInsets.only(top: 500),
                //   margin: EdgeInsets.only(top: 500),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       SizedBox(
                //         height: 70,
                //       ),
                //       Container(
                //         child: Text(
                //           sharedPref.getString("EmployeeName") ?? "",
                //           style: fontsStyle.px14(
                //               fontsStyle.thirdColor(), FontWeight.bold),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       //if it's govm emp, render title
                //       if (sharedPref.getInt("empTypeID") != 8)
                //         Text(
                //           sharedPref.getString("Title") ?? "",
                //           style: fontsStyle.px14(
                //               fontsStyle.thirdColor(), FontWeight.bold),
                //         ),
                //       if (sharedPref.getString("JobName") == "")
                //         SizedBox(
                //           height: sharedPref.getInt("empTypeID") != 8 ? 30 : 0,
                //         ),
                //       //if it's govm emp, render this row
                //       if (sharedPref.getInt("empTypeID") != 8)
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Container(
                //               decoration: BoxDecoration(
                //                 color: Color.fromRGBO(228, 242, 242, 1),
                //                 borderRadius: BorderRadius.circular(31),
                //               ),
                //               child: Padding(
                //                   padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
                //                   child: Row(
                //                     children: [
                //                       Text(
                //                         'المرتبة: ',
                //                         style: fontsStyle.px12normal(
                //                             fontsStyle.thirdColor(),
                //                             FontWeight.normal),
                //                       ),
                //                       Text(
                //                         sharedPref.getInt("ClassID").toString() ??
                //                             "",
                //                         style: fontsStyle.px12normal(
                //                             fontsStyle.thirdColor(),
                //                             FontWeight.normal),
                //                       ),
                //                     ],
                //                   )),
                //             ),
                //             Container(
                //               decoration: BoxDecoration(
                //                 color: Color.fromRGBO(228, 242, 242, 1),
                //                 borderRadius: BorderRadius.circular(31),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
                //                 child: Row(
                //                   children: [
                //                     Text('الدرجة: '),
                //                     Text(
                //                       sharedPref.getInt("GradeID").toString() ?? "",
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               decoration: BoxDecoration(
                //                 color: Color.fromRGBO(228, 242, 242, 1),
                //                 borderRadius: BorderRadius.circular(31),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
                //                 child: Row(
                //                   children: [
                //                     Text('سنوات الخدمة: '),
                //                     // Text(getYearOfService() ?? ""),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )
                //     ],
                //   ),
                // ),
                // -- emp info --
                // Container(
                //   padding: EdgeInsets.symmetric(vertical: 20),
                //   width: 350,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(7),
                //         topRight: Radius.circular(7),
                //         bottomLeft: Radius.circular(7),
                //         bottomRight: Radius.circular(7)),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Color(0xff0E1F35).withOpacity(0.06),
                //         spreadRadius: 0,
                //         blurRadius: 4,
                //         offset: Offset(0, 0), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(23, 20, 23, 20),
                //     child: Column(
                //       children: [
                //         Row(
                //           children: [
                //             Text(
                //               'الرقم الوظيفي: ',
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.bold,
                //               ),
                //             ),
                //             Text(
                //               EmployeeProfile.getEmployeeNumber(),
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.normal,
                //               ),
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //         Row(
                //           children: [
                //             Text(
                //               'البريد الإلكتروني: ',
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.bold,
                //               ),
                //             ),
                //             Text(
                //               sharedPref.getString("Email") ?? "",
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.normal,
                //               ),
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //         Row(
                //           children: [
                //             Text(
                //               'رقم الجوال: ',
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.bold,
                //               ),
                //             ),
                //             Text(sharedPref.getString("MobileNumber") ?? ""),
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //         Row(
                //           children: [
                //             Text(
                //               'رقم التحويلة: ',
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.bold,
                //               ),
                //             ),
                //             Text(
                //               sharedPref.getInt("Extension").toString() ?? "",
                //               style: fontsStyle.px13(
                //                 fontsStyle.thirdColor(),
                //                 FontWeight.normal,
                //               ),
                //             ),
                //           ],
                //         ),
                //         SizedBox(height: 10),
                //         Container(
                //           child: Text.rich(
                //             TextSpan(
                //               style: TextStyle(fontSize: 16),
                //               children: <TextSpan>[
                //                 TextSpan(
                //                   text: 'الإدارة: ',
                //                   style: fontsStyle.px13(
                //                     fontsStyle.thirdColor(),
                //                     FontWeight.bold,
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: sharedPref.getString("DepartmentName"),
                //                   style: fontsStyle.px13(
                //                     fontsStyle.thirdColor(),
                //                     FontWeight.normal,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             maxLines: 4,
                //             softWrap: true,
                //             overflow: TextOverflow.visible,
                //           ),
                //         ),
                //         if (sharedPref.getInt("empTypeID") != 8)
                //           Row(
                //             children: [
                //               Text(
                //                 'تاريخ التعيين في الأمانة: ',
                //                 style: fontsStyle.px13(
                //                   fontsStyle.thirdColor(),
                //                   FontWeight.bold,
                //                 ),
                //               ),
                //               Text(
                //                 sharedPref.getString("HireDate") ?? "",
                //                 style: fontsStyle.px13(
                //                   fontsStyle.thirdColor(),
                //                   FontWeight.normal,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         SizedBox(height: 10),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
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
                            "https://crm.eamana.gov.sa/agenda/api/apple_wallet/pkpass_API/Eamana_Pkpass_byID.php?id=${EmployeeProfile.getEmployeeNumber() ?? ""}&token=${sharedPref.getString('AccessToken')}&lang=ar"));
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
                            "https://crm.eamana.gov.sa/agenda/api/apple_wallet/pkpass_API/Eamana_Pkpass_byID.php?id=${EmployeeProfile.getEmployeeNumber() ?? ""}&token=${sharedPref.getString('AccessToken')}&lang=en"));
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
