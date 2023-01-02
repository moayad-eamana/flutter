import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;
  TextEditingController otp = TextEditingController();

  increment(String dd) {
    count = count + int.parse(dd);
    otp.text = count.toString();
  }
}
