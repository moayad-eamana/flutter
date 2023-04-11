import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class violationInfo extends StatefulWidget {
  dynamic vehicle;
  violationInfo(this.vehicle);

  @override
  State<violationInfo> createState() => _violationInfoState();
}

class _violationInfoState extends State<violationInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 2,
                  decoration: formlabel1("بند المخالفة"),
                  readOnly: true,
                  controller: TextEditingController(
                      text: "ترك المركبة التالفة إلخ. ........"),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              TextF("المبلغ", "5000"),
              SizedBox(
                width: 5,
              ),
              // TextF("رقم السداد", "4434334"),
              // SizedBox(
              //   width: 5,
              // ),
              // TextF("حالة المخالفة", "غير مسددة"),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }

  TextF(String lable, String text) {
    return Expanded(
      child: TextField(
        maxLines: 1,
        decoration: formlabel1(lable),
        readOnly: true,
        style: descTx1(secondryColorText),
        controller: TextEditingController(text: text),
      ),
    );
  }
}
