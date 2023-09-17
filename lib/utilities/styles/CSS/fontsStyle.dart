import 'package:flutter/material.dart';

class fontsStyle {
  static TextStyle px2(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 24, fontWeight: fontWeight, color: color);
  }

  static TextStyle px20(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 20, fontWeight: fontWeight, color: color);
  }

  static TextStyle px16(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 16, fontWeight: fontWeight, color: color);
  }

  static TextStyle px14(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 14, fontWeight: fontWeight, color: color);
  }

  static TextStyle px13(Color color, FontWeight fontWeight) {
    return TextStyle(
      fontSize: 13,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle px12Bold(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color);
  }

  static TextStyle px12normal(Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: color);
  }

  static baseColor() {
    return Color(0xff214187);
  }

  static SecondaryColor() {
    return Color(0xff131313);
  }

  static thirdColor() {
    return Color(0xff131313);
  }

  static FourthColor() {
    return Color(0xff8E8E8E);
  }

  // -- more colors:
  static HeaderColor() {
    return Color.fromRGBO(41, 179, 180, 1);
  }

  static LightGreyColor() {
    return Color.fromRGBO(247, 247, 247, 1);
  }

  static IconColor() {
    return Color.fromRGBO(102, 102, 102, 1);
  }
}
