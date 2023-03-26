import 'package:eamanaapp/secreen/QrCode/qrcodeServrces.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';

class listOfQrcode extends StatefulWidget {
  @override
  State<listOfQrcode> createState() => _listOfQrcodeState();
}

class _listOfQrcodeState extends State<listOfQrcode> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("خدمات QRCode", context, null),
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
                    ...QrCodeServices.qrCodeWidget(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
