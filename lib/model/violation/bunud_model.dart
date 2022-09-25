import 'package:flutter/widgets.dart';

class Bunud_model {
  //بنود
  //تاريخ المخالفة
  TextEditingController violationDate = TextEditingController();
  //الوحدة
  TextEditingController unit = TextEditingController();
  //التكرار
  TextEditingController repetition = TextEditingController();
  //القيمة المطبقة
  TextEditingController bunudvalue = TextEditingController();

  List bunudTable = [];

  int generaltotal = 0;
}
