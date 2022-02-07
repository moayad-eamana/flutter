import 'package:flutter/material.dart';

const Color baseColor = Color(0xff1F9EB9);
const Color secondryColor = Color(0xffE2F3FF);

ButtonStyle mainbtn = ElevatedButton.styleFrom(
  side: const BorderSide(
    width: 1,
    color: Color(0xFFDDDDDD),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
  primary: Colors.white, // background
  onPrimary: Colors.blue, // foreground
);

ButtonStyle cardServiece = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),

  side: BorderSide(
    width: 0.5,
    color: Colors.black38,
  ),
  elevation: 0,
  primary: Colors.white,
  onPrimary: Colors.grey, // foreground
);
