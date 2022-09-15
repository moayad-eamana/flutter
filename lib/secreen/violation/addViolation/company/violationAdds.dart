import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class violationAdds extends StatefulWidget {
  Function nextPage;
  violationAdds(this.nextPage);

  @override
  State<violationAdds> createState() => _violationAddsState();
}

class _violationAddsState extends State<violationAdds>
    with AutomaticKeepAliveClientMixin {
  get baseColorText => null;

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
            decoration: formlabel1("إسم البلدية"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'إسم البلدية';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            keyboardType: TextInputType.number,
            maxLines: 1,
            decoration: formlabel1("رخص لوحة إعلانية"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'رخص لوحة إعلانية';
              }
              return null;
            },
          ),
          sizeBox(),
          SizedBox(
              width: 120,
              child: widgetsUni.actionbutton("تحقق", Icons.send, () {})),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            keyboardType: TextInputType.number,
            maxLines: 1,
            decoration: formlabel1("رقم السجل أو الهوية"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'رقم السجل أو الهوية';
              }
              return null;
            },
          ),
          sizeBox(),
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
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("عنوان اللوحة"),
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("مساحة اللوحة"),
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("تاريخ إنتهاء الرخصة"),
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("البلدية التابعة"),
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("إسم الحي"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال إسم الحي';
              }
              return null;
            },
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 1,
            decoration: formlabel1("الوصف المختصر"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال الوصف المختصر';
              }
              return null;
            },
          ),
          sizeBox(),
          TextFormField(
            style: TextStyle(
              color: baseColorText,
            ),
            maxLines: 3,
            decoration: formlabel1("ملاحظات الموظف"),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 120,
            child: widgetsUni.actionbutton("التالي", Icons.next_plan, () {
              widget.nextPage();
            }),
          )
        ],
      ),
    );
  }

  sizeBox() {
    return SizedBox(
      height: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
