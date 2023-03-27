import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewQrData extends StatefulWidget {
  ViewQrData({required this.data, Key? key}) : super(key: key);
  dynamic data;
  @override
  State<ViewQrData> createState() => _ViewQrDataState();
}

class _ViewQrDataState extends State<ViewQrData> {
  @override
  dynamic dataj;
  void initState() {
    // TODO: implement initState
    super.initState();
    dataj = jsonDecode(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("عرض بيانات الموظف", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: BackGWhiteColor,
                elevation: 5,
                child: Container(
                  height: 300,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          dataj["Name"].toString(),
                          style: TextStyle(
                              color: baseColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Center(
                        child: Text(
                          dataj["Title"],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: baseColor,
                          thickness: 0.5,
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              backgroundColor: baseColor,
                              radius: responsiveMT(24, 26),
                              child: ClipOval(
                                child: dataj["GenderID"] == 2
                                    ? Image.asset(
                                        "assets/image/blank-profile.png",
                                      )
                                    : ClipOval(
                                        child: FadeInImage.assetNetwork(
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                          image: dataj["imageUrl"],
                                          placeholder:
                                              "assets/image/blank-profile.png",
                                          imageErrorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            "assets/image/blank-profile.png",
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SelectableText(
                                      dataj["GenderID"] == 2
                                          ? "0"
                                          : "رقم الجوال : " + dataj["PhoneNum"],
                                      style: TextStyle(color: baseColorText),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Text("البريد الالكتروني : " + dataj["Email"]),
                                  IconButton(
                                      onPressed: () {
                                        launch("mailto:" +
                                            dataj["Email"] +
                                            "@eamana.gov.sa");
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        size: 20,
                                        color: baseColor,
                                      ))
                                ]),
                                Text("رقم التحويلة : " + dataj["Extension"]),
                                Row(
                                  children: [
                                    Text("الرقم الوظيفي : " +
                                        dataj["EmpID"].toString()),
                                    IconButton(
                                        onPressed: () {
                                          FlutterClipboard.copy(
                                                  dataj["EmpID"].toString())
                                              .then((value) => print('copied'));
                                          Fluttertoast.showToast(
                                            msg: "تم النسخ", // message
                                            toastLength:
                                                Toast.LENGTH_SHORT, // length
                                            gravity:
                                                ToastGravity.BOTTOM, // location
                                            timeInSecForIosWeb: 1, // duration
                                            backgroundColor: BackGColor,
                                            textColor: baseColorText,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.copy,
                                          size: 20,
                                          color: baseColor,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(indent: 20, endIndent: 20, thickness: 0.5),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              label: Text('واتساب'),
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: baseColor,
                                size: 24.0,
                              ),
                              style: mainbtn,
                              onPressed: dataj["GenderID"] == 2
                                  ? null
                                  : () {
                                      if (dataj["GenderID"] == 1) {
                                        launch(
                                            "https://wa.me/+966${dataj["PhoneNum"]}/?text=${Uri.parse("السلام عليكم ورحمة الله وبركاته")}");
                                      }
                                    },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                              label: Text('إتصال'),
                              icon: Icon(
                                Icons.call,
                                color: baseColor,
                                size: 24.0,
                              ),
                              style: mainbtn,
                              onPressed: dataj["GenderID"] == 2
                                  ? null
                                  : () {
                                      launch("tel://" + dataj["PhoneNum"]);
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
