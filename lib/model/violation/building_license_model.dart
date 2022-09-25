import 'package:flutter/widgets.dart';

class Building_license_model {
  //مخالفة رخصة البناء
  //رقم الرخصة
  TextEditingController buildingLicense = TextEditingController();
  //اسم المالك
  TextEditingController individualNameOrCompanyName = TextEditingController();
  //رقم الهوية / سجل
  TextEditingController identityOrCommericalNumber = TextEditingController();
  //اسم المكتب الهندسي
  TextEditingController companyEngName = TextEditingController();
  //مساحة
  TextEditingController areaBuildingLic = TextEditingController();
  //نوع الرخصة locOrPurposeDesc ?
  TextEditingController licensetype = TextEditingController();
}
