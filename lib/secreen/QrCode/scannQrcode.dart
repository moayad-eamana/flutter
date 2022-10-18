import 'dart:convert';
import 'dart:io';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class scanQrcode extends StatefulWidget {
  String? titlePage;
  scanQrcode([this.titlePage]);

  @override
  State<scanQrcode> createState() => _scanQrcodeState();
}

class _scanQrcodeState extends State<scanQrcode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  int i = 0;
  TextEditingController _fn = TextEditingController();
  TextEditingController _ln = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _workLocation =
      TextEditingController(text: "أمانة المنطقة الشرقية");
  TextEditingController _jobTitle = TextEditingController();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              // formatsAllowed: [BarcodeFormat.qrcode],
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderWidth: 5,
                borderColor: Colors.white,
              ),

              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: BackGColor,
              child: Center(
                child: Text(
                  'فحص رمز الاستجابة السريعة',
                  style: TextStyle(color: baseColorText),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("رجوع")),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        if (widget.titlePage == "حجز موعد") {
          result = scanData;
        } else if (widget.titlePage == "تسجيل دخول") {
          result = scanData;
        } else {
          result = scanData;
          // print(scanData.code);
          var contact = Contact.fromVCard(scanData.code.toString());
          _fn.text = contact.name.first;
          _ln.text = contact.name.last;
          _phone.text = contact.phones.first.number;
          _email.text = contact.emails.first.address;
          _workLocation.text = contact.organizations.first.company;
          _jobTitle.text = contact.organizations.first.title;

          // print("fn = " + contact.name.first);
          if (i == 0) {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: BackGColor,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Container(
                        height: 80.h,
                        padding: EdgeInsets.all(20),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: _fn,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("الاسم الاول"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _ln,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("الاسم الاخير"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _phone,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("رقم الجوال"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _email,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("الايميل"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _workLocation,
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("جهة العمل"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  enabled: false,
                                  controller: _jobTitle,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  style: TextStyle(color: baseColorText),
                                  decoration: formlabel1("جهة العمل"),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  child: const Text('حفظ للجهات الاتصال'),
                                  onPressed: () async {
                                    if (await FlutterContacts
                                        .requestPermission()) {
                                      final newContact = Contact()
                                        ..name.first = _fn.text
                                        ..name.last = _ln.text
                                        ..phones = [Phone(_phone.text)]
                                        ..organizations = [
                                          Organization(
                                              company: _workLocation.text,
                                              title: _jobTitle.text)
                                        ]
                                        ..emails = [Email(_email.text)];

                                      await newContact.insert();
                                    }

                                    Alerts.successAlert(context, "", "تم الحفظ")
                                        .show()
                                        .then((value) async {
                                      i = 0;
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).then((value) {
              i = 0;
            });

            i++;
          }
        }
        if (i == 0) {
          if (widget.titlePage == "حجز موعد") {
            print("eeeeeeeeeee");
            result = scanData;
            i++;
            Navigator.pop(context, scanData.code.toString());
          }
        }
      });
      if (i == 0) {
        if (widget.titlePage == "تسجيل دخول") {
          i++;
          result = scanData;
          String? id;
          String? typeId;
          final uri = Uri.parse(scanData.code.toString());
          id = uri.queryParameters["id"];
          typeId = uri.queryParameters["typeid"];
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );
          var respose = await http.post(
              Uri.parse(
                  "https://crm.eamana.gov.sa/agenda_dev/api/Agenda_dashboard/updateAppointmentsLogByID.php"),
              body: jsonEncode({
                "token": sharedPref.getString("AccessToken"),
                "email": sharedPref.getString("Email"),
                "reqid": id,
                "type": typeId
              }));
          EasyLoading.dismiss();
          if (jsonDecode(respose.body)["status"] == true) {
            i++;
            setState(() {});
            Alerts.successAlert(context, "", "تم تسجيل دخول المستفيد")
                .show()
                .then((value) {
              Navigator.pop(context);
            });
          } else {
            i++;
            setState(() {});
            Alerts.errorAlert(
                    context, "خطأ", jsonDecode(respose.body)["message"])
                .show()
                .then((value) {
              i = 0;
            });
          }
          setState(() {});
        }
      }

      // await FlutterContacts.openExternalView(contact);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
