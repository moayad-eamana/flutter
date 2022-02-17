import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const Color baseColor = Color(0xff274690);
const Color secondryColor = Color(0xff2E8D9A);
const Color baseColorText = Color(0xff444444);
const Color secondryColorText = Color(0xff707070);
const Color bordercolor = Color(0xffDDDDDD);
const Color lableTextcolor = Color(0xffACC5FF);

ButtonStyle mainbtn = ElevatedButton.styleFrom(
  side: const BorderSide(
    width: 1,
    color: bordercolor,
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

InputDecoration formlabel1(String lableName) {
  return InputDecoration(
      // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      contentPadding: EdgeInsets.symmetric(
          vertical: responsiveMT(12, 30), horizontal: 10.0),
      labelText: lableName,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: bordercolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(4),
      ));
}

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

double responsiveMT(double mobile, double tablet) {
  return SizerUtil.deviceType == DeviceType.mobile ? mobile : tablet;
}

int responsiveGrid(int mobile, int tablet) {
  return SizerUtil.deviceType == DeviceType.mobile ? mobile : tablet;
}
