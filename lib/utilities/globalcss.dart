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

TextStyle titleTx =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: secondryColor);

TextStyle subtitleTx =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: baseColor);

TextStyle descTx1 =
    TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: baseColorText);
TextStyle descTx2 = TextStyle(fontSize: 12, color: secondryColorText);
