import 'package:flutter/widgets.dart';

class Comment {
  //رقم الجوال
  TextEditingController mobile = TextEditingController();
  //البلدية التابعة
  TextEditingController baldea = TextEditingController();
  //إسم الحي
  TextEditingController neighborhoodname = TextEditingController();
  //إسم الشارع
  TextEditingController streetname = TextEditingController();
  //الوصف المختصر
  TextEditingController shortDescription = TextEditingController();
  //ملاحظات الموظف
  TextEditingController employeeDescription = TextEditingController();

  String ViolationSelected = "";

  //رقم السجل أو الهوية
  TextEditingController identityOrCommericalNumber = TextEditingController();
  //عنوان اللوحة
  TextEditingController individualNameOrCompanyName = TextEditingController();
}
