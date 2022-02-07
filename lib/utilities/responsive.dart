import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait == true ? 100.w < 768.0 : 100.h < 768.0;
  }

  static bool isTablet(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return isPortrait == true ? 100.w > 768.0 : 100.h > 768.0;
  }
}
