import 'package:flutter/widgets.dart';

class IndividualUserInfoModel {
  //بينات رئيسية
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

  //مخالفة رخصة البناء
  //رقم الرخصة
  TextEditingController licensenumber = TextEditingController();
  //اسم المالك
  TextEditingController ownername = TextEditingController();
  //رقم الهوية / سجل
  TextEditingController ownerid = TextEditingController();
  //اسم المكتب الهندسي
  TextEditingController officename = TextEditingController();
  //مساحة
  TextEditingController space = TextEditingController();
  //نوع الرخصة
  TextEditingController licensetype = TextEditingController();

  //for set
  void settestdata() {
    this.licensenumber.text = "1516151";
    this.ownername.text = "mohammed";
    this.ownerid.text = "123";
  }

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
