import 'package:flutter/material.dart';

const Color baseColor = Color(0xff274690);
const Color secondryColor = Color(0xff2E8D9A);
const Color baseColorText = Color(0xff444444);
const Color secondryColorText = Color(0xff707070);

ButtonStyle mainbtn = ElevatedButton.styleFrom(
  side: const BorderSide(
    width: 1,
    color: Color(0xFFDDDDDD),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4.0),
  ),
  primary: Colors.white, // background
  onPrimary: Colors.blue, // foreground
);

ButtonStyle cardServiece = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),

  side: BorderSide(
    width: 0.5,
    color: Colors.black38,
  ),
  elevation: 0,
  primary: Colors.white,
  onPrimary: Colors.grey, // foregroundjjjkl
);

BoxDecoration containerdecoration(Color color) {
  return BoxDecoration(
      color: color,
      border: Border.all(color: Color(0xFFDDDDDD)),
      borderRadius: BorderRadius.all(Radius.circular(4)));
}

TextStyle titleTx(Color color) {
  return TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color);
}

TextStyle subtitleTx(Color color) {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color);
}

TextStyle descTx1(Color color) {
  return TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color);
}

TextStyle descTx2(Color color) {
  return TextStyle(fontSize: 12, color: color);
}
