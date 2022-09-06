import 'dart:io';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sizer/sizer.dart';

class scanQrcode extends StatefulWidget {
  const scanQrcode({Key? key}) : super(key: key);

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
      TextEditingController(text: "أمانة الشرقية");
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
              overlay: QrScannerOverlayShape(),
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
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
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
      });

      // await FlutterContacts.openExternalView(contact);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
