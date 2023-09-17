import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

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
      alignLabelWithHint: true,
      prefixIcon: icon,

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

  static baseElevatedButton(String text, double width, VoidCallback? fun) {
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
}
