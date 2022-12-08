import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/QrCode/scannQrcode.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class customerEnterance extends StatefulWidget {
  @override
  State<customerEnterance> createState() => _customerEnteranceState();
}

class _customerEnteranceState extends State<customerEnterance> {
  TextEditingController ID = TextEditingController();
  List requestInfo = [];
  String typeId = "0";
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
          appBar: AppBarW.appBarW("تسجيل حضور", context, null),
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                SingleChildScrollView(
                  child: Container(
                    // height: 90.h,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(30),
                    decoration: containerdecoration(Colors.white),
                    child: Column(
                      children: [
                        TextField(
                          controller: ID,
                          style: TextStyle(
                            color: baseColorText,
                          ),
                          keyboardType: TextInputType.number,
                          decoration:
                              formlabel1("رقم الطلب", Icons.qr_code, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      scanQrcode("تسجيل حضور")),
                            ).then((value) {
                              ID.text = value["id"];
                              typeId = value["typeId"];
                              setState(() {});
                              searchForRequest();
                            });
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: 120,
                            child: widgetsUni.actionbutton("بحث", Icons.search,
                                () async {
                              searchForRequest();
                            })),
                        SizedBox(
                          height: 10,
                        ),
                        if (requestInfo.length != 0) ...ListOfWi()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  rowW(String Title, String desc, String Title2, String desc2) {
    return Row(
      children: [
        Expanded(
            child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  Title,
                  style: subtitleTx(baseColorText),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  desc,
                  style: descTx1(secondryColorText),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(Title2, style: subtitleTx(baseColorText)),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(desc2, style: descTx1(secondryColorText)),
              ),
            ],
          ),
        ))
      ],
    );
  }

  onlyCard(
    String Title,
    String desc,
  ) {
    return Container(
      width: 100.w,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                Title,
                style: subtitleTx(baseColorText),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                desc,
                style: descTx1(secondryColorText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListOfWi() {
    return [
      onlyCard("الإسم", requestInfo[0]["Appwith"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("رقم الهوية", requestInfo[0]["requester_idn"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("الموقع", requestInfo[0]["location_name"]),
      SizedBox(
        height: 10,
      ),
      rowW("يوم", requestInfo[0]["Day"].toString(), "الوقت",
          requestInfo[0]["Time"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("التاريخ", requestInfo[0]["Date"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("الإدارة", requestInfo[0]["dept_name"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("مسؤول الإدارة", requestInfo[0]["leader_name"]),
      SizedBox(
        height: 10,
      ),

      // onlyCard("الموضوع", requestInfo[0]["Subject"]),
      // SizedBox(
      //   height: 10,
      // ),
      onlyCard("التفاصيل", requestInfo[0]["MeetingDetails"]),
      SizedBox(
        height: 10,
      ),
      onlyCard("الملاحظات", requestInfo[0]["Notes"]),
      SizedBox(
        height: 10,
      ),
      requestInfo[0]["available"] == false
          ? Container(
              child: Text(
                "الموعد ليس متاح",
                style: subtitleTx(baseColorText),
              ),
            )
          : SizedBox(
              width: 130,
              child:
                  widgetsUni.actionbutton("تسجيل حضور", Icons.send, () async {
                EasyLoading.show(
                  status: '... جاري المعالجة',
                  maskType: EasyLoadingMaskType.black,
                );
                var respose = await http.post(
                    Uri.parse(CRMURL +
                        "Agenda_dashboard/updateAppointmentsLogByID.php"),
                    body: jsonEncode({
                      "token": sharedPref.getString("AccessToken"),
                      "email": sharedPref.getString("Email"),
                      "reqid": ID.text,
                      "type": typeId
                    }));
                EasyLoading.dismiss();
                if (jsonDecode(respose.body)["status"] == true) {
                  setState(() {});
                  Alerts.successAlert(context, "", "تم تسجيل حضور المستفيد")
                      .show()
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  setState(() {});
                  Alerts.errorAlert(
                          context, "خطأ", jsonDecode(respose.body)["message"])
                      .show()
                      .then((value) {});
                }
              }))
    ];
  }

  searchForRequest() async {
    FocusManager.instance.primaryFocus?.unfocus();
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(CRMURL + "Agenda_dashboard/getAppointmentsByID.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": sharedPref.getString("Email"),
          "reqid": ID.text,
          "type": typeId
        }));
    print(respose);
    try {
      requestInfo = jsonDecode(respose.body);
    } catch (e) {
      typeId = "0";
      requestInfo = [];
    }
    EasyLoading.dismiss();
    setState(() {});
  }
}
