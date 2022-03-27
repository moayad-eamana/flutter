import 'package:eamanaapp/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

bool blindness = false;
bool darkmode = false;

String imageBG = "assets/image/Union_1.png";

late Color BackGWhiteColor;

Color BackGColor = Color(0xfffcfcfc);

Color baseColor = Color(0xff274690);

Color secondryColor = Color(0xff2E8D9A);

Color baseColorText = Color(0xff444444);

Color secondryColorText = Color(0xff707070);

Color bordercolor = Color(0xffDDDDDD);

Color lableTextcolor = Color(0xffACC5FF);

Color redColor = Colors.red;

Color pinkColor = Colors.pink;

Color chatColor = Color(0xffF8F8F8);

void getColorSettings() {
  imageBG = "assets/image/Union_1.png";

  BackGWhiteColor = Colors.white;

  BackGColor = Color(0xfffcfcfc);

  baseColor = Color(0xff274690);

  secondryColor = Color(0xff2E8D9A);

  baseColorText = Color(0xff444444);

  secondryColorText = Color(0xff707070);

  bordercolor = Color(0xffDDDDDD);

  lableTextcolor = Color(0xffACC5FF);

  redColor = Colors.red;

  pinkColor = Colors.pink;

  chatColor = Color(0xffF8F8F8);

  //final settingSP = await SharedPreferences.getInstance();

  blindness = sharedPref.getBool("blindness") ?? false;

  darkmode = sharedPref.getBool("darkmode") ?? false;

  if (blindness == true) {
    baseColor = Color(0xff004D85);

    secondryColor = Color(0xff7D7D9E);

    baseColorText = Color(0xff4C4446);

    secondryColorText = Color(0xff7A6C71);

    bordercolor = Color(0xffF1D5DE);

    lableTextcolor = Color(0xffB6C1FF);

    redColor = Color(0xffA17800);

    pinkColor = Color(0xff907356);

    chatColor = Color(0xffF8F8F8);
  }
  if (darkmode == true) {
    imageBG = "assets/image/Union_2.png"; //

    BackGColor = Colors.grey.shade800;

    BackGWhiteColor = Colors.grey.shade700;

    baseColor = Colors.blueGrey.shade200;

    secondryColor = Color(0xff2E8D9A);

    baseColorText = Colors.white;

    secondryColorText = Color(0xffd2d2d2);

    bordercolor = Color(0xffDDDDDD);

    lableTextcolor = Color(0xffACC5FF);

    redColor = Colors.red.shade300;

    pinkColor = Colors.pink;

    chatColor = Colors.blueGrey.shade800;
  }

  cardServiece = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),

    side: BorderSide(
      width: 0.5,
      color: bordercolor,
    ),
    elevation: 0,
    primary: BackGWhiteColor,
    onPrimary: Colors.grey, // foregroundjjjkl
  );
}

ButtonStyle mainbtn = ElevatedButton.styleFrom(
  side: BorderSide(
    width: 1,
    color: bordercolor,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4.0),
  ),
  primary: BackGWhiteColor, // background
  onPrimary: baseColor, // foreground
);

ButtonStyle cardServiece = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),

  side: BorderSide(
    width: 0.5,
    color: bordercolor,
  ),
  elevation: 0,
  primary: BackGWhiteColor,
  onPrimary: Colors.grey, // foregroundjjjkl
);

InputDecoration formlabel1(String lableName) {
  return InputDecoration(
      // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      labelText: lableName,
      labelStyle: TextStyle(color: secondryColorText),
      errorStyle: TextStyle(color: redColor),
      contentPadding:
          EdgeInsets.symmetric(vertical: responsiveMT(8, 30), horizontal: 10.0),
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
      border: Border.all(color: bordercolor),
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
