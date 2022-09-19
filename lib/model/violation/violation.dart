import 'package:flutter/widgets.dart';

class IndividualUserInfoModel {
  //رقم الهوية
  TextEditingController NID = TextEditingController();
  //إسم الفرد
  TextEditingController Name = TextEditingController();
  //رقم الجوال
  TextEditingController mobile = TextEditingController();
  //البلدية التابعة
  TextEditingController baldea = TextEditingController();
  //إسم الحي
  TextEditingController Neighborhoodname = TextEditingController();
  //إسم الشارع
  TextEditingController Streetname = TextEditingController();
  //الوصف المختصر
  TextEditingController ShortDescription = TextEditingController();
  //ملاحظات الموظف
  TextEditingController EmployeeDescription = TextEditingController();
  // IndividualUserInfoModel(
  //     this.NID,
  //     this.Name,
  //     this.mobile,
  //     this.baldea,
  //     this.Neighborhoodname,
  //     this.Streetname,
  //     this.ShortDescription,
  //     this.EmployeeDescription);
}
