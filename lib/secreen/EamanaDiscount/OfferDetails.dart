import 'dart:io';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/functions/getattachment.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';

class OfferDetails extends StatefulWidget {
  dynamic offer;
  OfferDetails(this.offer);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late String path;

  // getFilePath() async {
  //   EasyLoading.show(
  //     status: '... جاري المعالجة',
  //     maskType: EasyLoadingMaskType.black,
  //   );
  //   var headers = {
  //     'Content-Type': 'text/xml',
  //     'Cookie': 'cookiesession1=678B28B36718B06CD19AAAD934ACDF5C'
  //   };
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           'https://archive.eamana.gov.sa/UploadService/UploadService.asmx?op=GetDocuments'));
  //   request.body =
  //       '''<?xml version="1.0" encoding="utf-8"?>\r\n<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">\r\n  <soap:Body>\r\n    <GetDocuments xmlns="http://tempuri.org/">\r\n      <arcSerial>${widget.offer["ArcSerial"]}</arcSerial>\r\n    </GetDocuments>\r\n  </soap:Body>\r\n</soap:Envelope>''';
  //   request.headers.addAll(headers);

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());

  //     dynamic xml = await response.stream.bytesToString();

  //     // print(xml);

  //     final myTransformer = Xml2Json();

  //     myTransformer.parse(xml);

  //     dynamic jsondata = myTransformer.toGData();

  //     jsondata = jsonDecode(jsondata);

  //     // print(jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
  //     //     ["GetDocumentsResult"]["Attachments"][0]["FilePath"]["\$t"]);
  //     setState(() {
  //       path = jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
  //           ["GetDocumentsResult"]["Attachments"][0]["FilePath"]["\$t"];

  //       path = "https://archive.eamana.gov.sa/TransactFileUpload/" + path;
  //     });

  //     // print(jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
  //     //     ["GetDocumentsResult"]["Attachments"]);

  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   EasyLoading.dismiss();
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.offer);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("تفاصيل العرض", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        // CompanyName(),
                        // StartAndEndDAte(),
                        // OfferName(),
                        // CompanyNotes(),
                        // Respresentiveinfo(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // ViewPF(),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          // height: 400,
                          margin: EdgeInsets.symmetric(horizontal: 20),

                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(14, 31, 53, 0.06),
                                offset: Offset(0, 4),
                                blurRadius: 1,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.offer["CompanyName"],
                                        style: fontsStyle.px20(
                                            fontsStyle.baseColor(),
                                            FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(228, 242, 242, 1),
                                        borderRadius: BorderRadius.circular(31),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              11, 3, 11, 3),
                                          child: Row(
                                            children: [
                                              Text(
                                                "خصم " +
                                                    widget.offer["DiscoutRatio"]
                                                        .toString()
                                                        .split(".")[0] +
                                                    " % ",
                                                style: fontsStyle.px16(
                                                    fontsStyle.HeaderColor(),
                                                    FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ينتهي بتاريخ " +
                                          widget.offer["OfferExpiryDate"]
                                              .toString()
                                              .split("T")[0],
                                      style: fontsStyle.px13(
                                        fontsStyle.thirdColor(),
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "نبذة عن العرض",
                                      style: fontsStyle.px16(
                                        fontsStyle.thirdColor(),
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                                  child: Text(
                                    widget.offer["OfferName"],
                                    style: fontsStyle.px13(
                                      fontsStyle.thirdColor(),
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: ViewPF(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ملاحظات",
                                      style: fontsStyle.px16(
                                        fontsStyle.thirdColor(),
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.offer["CompanyNotes"],
                                          style: fontsStyle.px13(
                                            fontsStyle.thirdColor(),
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ممثل الشركة",
                                      style: fontsStyle.px16(
                                        fontsStyle.thirdColor(),
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 13),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.offer["CreatedBy"],
                                        style: fontsStyle.px13(
                                          fontsStyle.thirdColor(),
                                          FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //--email
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                  child: GestureDetector(
                                    onTap: () {
                                      launch("mailto:" +
                                          widget.offer["CompanyEmail"]);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email_outlined,
                                          color: fontsStyle.FourthColor(),
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.offer["CompanyEmail"],
                                          style: fontsStyle.px13(
                                              fontsStyle.HeaderColor(),
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //-- phone
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                  child: GestureDetector(
                                    onTap: () {
                                      launch("tel://" +
                                          widget
                                              .offer["RespresentiveMobileNo"]);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone_outlined,
                                          color: fontsStyle.FourthColor(),
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.offer["RespresentiveMobileNo"],
                                          style: fontsStyle.px13(
                                              fontsStyle.HeaderColor(),
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //--whatsapp
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                  child: GestureDetector(
                                    onTap: () {
                                      launch("https://wa.me/" +
                                          widget
                                              .offer["RespresentiveMobileNo"] +
                                          "/");
                                    },
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: fontsStyle.FourthColor(),
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.offer["RespresentiveMobileNo"],
                                          style: fontsStyle.px13(
                                              fontsStyle.HeaderColor(),
                                              FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (widget.offer["URL"] != "" &&
                                    widget.offer["URL"] != "sample string 6")
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 13),
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          // widget.offer["URL"] = "https://www.google.com/";
                                          // launch(widget.offer["URL"]);
                                          if (await canLaunch(
                                              widget.offer["URL"])) {
                                            await launch(widget.offer["URL"]);
                                          } else {
                                            Alerts.errorAlert(context, "خطأ",
                                                    "يوجد خطأ بالرابط")
                                                .show();
                                            throw 'Could not launch ' +
                                                widget.offer["URL"];
                                          }
                                        } catch (e) {}
                                      },
                                      child: Container(
                                        width: 100.w,
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.link,
                                              color: fontsStyle.FourthColor(),
                                              size: 20.0,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  widget.offer["URL"] +
                                                      "dedede",
                                                  style: fontsStyle.px13(
                                                      fontsStyle.HeaderColor(),
                                                      FontWeight.bold),
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CompanyName() {
    return Card(
        child: Container(
      color: BackGWhiteColor,
      width: 100.w,
      padding: EdgeInsets.all(10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: -5,
            child: Container(
              height: 40,
              width: 110,
              decoration: containerdecoration(baseColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "خصم",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.offer["DiscoutRatio"].toString() + "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "إسم الشركة",
                  style: titleTx(baseColorText),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.offer["CompanyName"],
                  style: subtitleTx(secondryColorText),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget StartAndEndDAte() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Container(
              color: BackGWhiteColor,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "بداية العرض",
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.offer["OfferStartDate"].toString().split("T")[0],
                    style: subtitleTx(secondryColorText),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              color: BackGWhiteColor,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "نهاية العرض",
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.offer["OfferExpiryDate"].toString().split("T")[0],
                    style: subtitleTx(secondryColorText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Respresentiveinfo() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "ممثل الشركة",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.offer["RepresentiveName"],
              style: titleTx(secondryColorText),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: widget.offer["RespresentiveMobileNo"]
                              .toString()
                              .startsWith("05", 0) ||
                          widget.offer["RespresentiveMobileNo"]
                              .toString()
                              .startsWith("966", 0)
                      ? true
                      : false,
                  child: GestureDetector(
                    onTap: () {
                      launch("https://wa.me/" +
                          widget.offer["RespresentiveMobileNo"] +
                          "/");
                    },
                    child: FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: secondryColor,
                      size: 24.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("tel://" + widget.offer["RespresentiveMobileNo"]);
                  },
                  child: Icon(
                    Icons.phone_outlined,
                    color: secondryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("mailto:" + widget.offer["CompanyEmail"]);
                  },
                  child: Icon(
                    Icons.email_outlined,
                    color: secondryColor,
                  ),
                ),
                if (widget.offer["URL"] != "" &&
                    widget.offer["URL"] != "sample string 6")
                  GestureDetector(
                    onTap: () async {
                      try {
                        // widget.offer["URL"] = "https://www.google.com/";
                        // launch(widget.offer["URL"]);
                        if (await canLaunch(widget.offer["URL"])) {
                          await launch(widget.offer["URL"]);
                        } else {
                          Alerts.errorAlert(context, "خطأ", "يوجد خطأ بالرابط")
                              .show();
                          throw 'Could not launch ' + widget.offer["URL"];
                        }
                      } catch (e) {}
                    },
                    child: Icon(
                      Icons.link,
                      color: secondryColor,
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget OfferName() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "نبذة عن العرض",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.offer["OfferName"],
                style: subtitleTx(secondryColorText),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CompanyNotes() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "ملاحظات",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.offer["CompanyNotes"],
                  style: subtitleTx(secondryColorText),
                  textAlign: TextAlign.justify),
            )
          ],
        ),
      ),
    );
  }

  Widget ViewPF() {
    return Container(
      // width: 150,
      // height: 50,
      child: InkWell(
          onTap: () async {
            path = await getAttachment(widget.offer["ArcSerial"]);
            // await getFilePath();
            if (Platform.isIOS) {
              if (!await launchUrl(Uri.parse(path))) {
                throw 'Could not launch $path';
              }
            } else {
              if (!await launchUrl(Uri.parse(path),
                  mode: LaunchMode.externalApplication)) {
                throw 'Could not launch $path';
              }
            }
            //launchUrl(path);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.link_rounded,
                color: fontsStyle.HeaderColor(),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "عرض المرفق",
                style: fontsStyle.px13(
                    fontsStyle.HeaderColor(), FontWeight.normal),
              ),
              SizedBox(
                width: 5,
              ),
              // Icon(Icons.open_in_browser)
            ],
          )),
    );
  }
}
