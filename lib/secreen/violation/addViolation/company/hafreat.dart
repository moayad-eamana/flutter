import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import '../ListOfTextFieleds.dart';

class hafreat extends StatefulWidget {
  Function nextPage;
  hafreat(this.nextPage);

  @override
  State<hafreat> createState() => _hafreatState();
}

class _hafreatState extends State<hafreat> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            keyboardType: TextInputType.number,
            maxLines: 1,
            decoration: formlabel1("رقم الطلب"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال رقم الطلب';
              }
              return null;
            },
          ),
          SizedBox(
              width: 120,
              child: widgetsUni.actionbutton("تحقق", Icons.send, () {})),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("إسم المنشأة"),
          ),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("رقم السجل"),
          ),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("الجهة المستفيدة"),
          ),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            keyboardType: TextInputType.number,
            maxLines: 1,
            decoration: formlabel1("رقم الجوال"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال رقم الجوال';
              }
              return null;
            },
          ),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("مساحة الحفرة"),
          ),
          siedBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("وصف الموقع"),
          ),
          ...TexTfields(),
          SizedBox(
              width: 120,
              child: widgetsUni.actionbutton("التالي", Icons.next_plan, () {
                widget.nextPage();
              })),
        ],
      ),
    );
  }

  SizedBox siedBox() {
    return SizedBox(
      height: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
