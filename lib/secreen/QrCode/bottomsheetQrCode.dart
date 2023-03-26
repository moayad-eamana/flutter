import 'package:barcode_widget/barcode_widget.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

BottomSheetQrCode(String date, BuildContext context) async {
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 50.h,
          color: BackGColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'مشاركة بياناتي',
                  style: titleTx(baseColor),
                ),
                SizedBox(
                  height: 10,
                ),
                BarcodeWidget(
                  barcode: Barcode.qrCode(), // Barcode type and settings
                  data: date,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widgetsUni.actionbutton(
                        'إغلاق', Icons.close, () => Navigator.pop(context)),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
