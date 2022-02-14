import 'package:flutter/material.dart';

class Banner {
  static List<Widget> sliderw(BuildContext context) {
    return [
      Image(
          //width: responsiveMT(60, 120),
          //height: responsiveMT(30, 100),
          image: AssetImage("assets/image/banner.png")),
      Image(
          //width: responsiveMT(60, 120),
          //height: responsiveMT(30, 100),
          image: AssetImage("assets/image/banner.png")),
    ];
  }
}
