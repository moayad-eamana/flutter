import 'package:eamanaapp/model/violation/violation.dart';

import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

// bool withstreetname = true;
// CompanyInfoModel companyInfoModel = CompanyInfoModel();
List<Widget> TexTfields(
    bool withstreetname, IndividualUserInfoModel IndividualUserInfo) {
  return [
    sizeBox(),
    TextFormField(
      controller: IndividualUserInfo.baldea,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: baseColorText,
      ),
      maxLines: 1,
      enabled: false,
      decoration: formlabel1("البلدية التابعة"),
    ),
    sizeBox(),
    TextFormField(
      controller: IndividualUserInfo.neighborhoodname,
      keyboardType: TextInputType.text,
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
    if (withstreetname == true)
      TextFormField(
        controller: IndividualUserInfo.streetname,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 1,
        decoration: formlabel1("إسم الشارع"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال إسم الشارع';
          }
          return null;
        },
      ),
    if (withstreetname == true) sizeBox(),
    TextFormField(
      controller: IndividualUserInfo.ShortDescription,
      keyboardType: TextInputType.text,
      style: TextStyle(
        color: baseColorText,
      ),
      maxLines: 1,
      decoration: formlabel1("الوصف المختصر"),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'الرجاء إدخال الوصف المختصر';
      //   }
      //   return null;
      // },
    ),
    sizeBox(),
    TextFormField(
      controller: IndividualUserInfo.employeeDescription,
      keyboardType: TextInputType.text,
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
