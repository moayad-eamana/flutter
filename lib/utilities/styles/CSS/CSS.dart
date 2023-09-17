import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CSS {
  static InputDecoration TextFieldDecoration(String labelText, {Icon? icon}) {
    return InputDecoration(
        labelStyle: TextStyle(color: secondryColorText),
        errorStyle: TextStyle(color: redColor),
        contentPadding: EdgeInsets.symmetric(
          vertical: responsiveMT(6, 30),
          horizontal: 6.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: BorderSide(color: bordercolor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(7),
        ),
        filled: true,
        fillColor: Colors.white,
        //  errorText: _usernameError ? "الرجاء إدخال الرقم الوظيفي" : null,
        labelText: labelText,
        // labelStyle: TextStyle(color: lableTextcolor),
        //alignLabelWithHint: true,
        suffixIcon: icon == null
            ? SizedBox(
                height: 0,
              )
            : icon

        ///
        );
  }

  static InputDecoration TextFieldDecorationPass(
      String labelText, bool IsVisible, VoidCallback fun) {
    return InputDecoration(
      labelStyle: TextStyle(color: secondryColorText),
      errorStyle: TextStyle(color: redColor),
      contentPadding: EdgeInsets.symmetric(
        vertical: responsiveMT(6, 30),
        horizontal: 6.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.0),
        borderSide: BorderSide(color: bordercolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(7),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(7),
      ),
      filled: true,
      fillColor: Colors.white,
      //  errorText: _usernameError ? "الرجاء إدخال الرقم الوظيفي" : null,
      labelText: labelText,
      // labelStyle: TextStyle(color: lableTextcolor),
      alignLabelWithHint: true,
      suffixIcon: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        color: secondryColor,
        icon: Icon(IsVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined),
        onPressed: fun,
      ),

      ///
    );
  }

  static baseElevatedButton(String text, double width, VoidCallback fun) {
    return Container(
      height: 40,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          primary: secondryColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: fun,
        child: Text(text),
      ),
    );
  }

  static customElevatedButton(String text, double width, VoidCallback fun,
      Color primary, Color onPrimary, Color borderColor) {
    return Container(
      height: 40,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(
                width: 1,
                color: borderColor,
              )),
          primary: primary, // background
          onPrimary: onPrimary, // foreground
        ),
        onPressed: fun,
        child: Text(text),
      ),
    );
  }

  static Widget servicebutton(
      String title, String icon, VoidCallback onClicked) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
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
        ),
        onPressed: onClicked,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              //color: Colors.white,
              width: responsiveMT(50, 48),
            ),
            // Icon(
            //   icon,
            //   size: SizerUtil.deviceType == DeviceType.mobile ? 30 : 35,
            //   color: baseColor,
            // ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                title,
                //maxLines: 1,
                textAlign: TextAlign.center,
                style: descTx1(baseColorText),
              ),
            )
          ],
        ));
  }
}
