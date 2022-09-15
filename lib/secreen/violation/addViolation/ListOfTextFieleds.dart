import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

List<Widget> TexTfields() {
  return [
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
  ];
}

sizeBox() {
  return SizedBox(
    height: 10,
  );
}
