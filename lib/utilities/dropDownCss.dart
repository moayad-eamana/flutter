import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class dropDownCss {
  static inputdecoration(String lableText) {
    return InputDecoration(
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
      ),
      // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      labelText: lableText,
    );
  }

  static popupTitle(String text) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: secondryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static popupShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    );
  }

  static noData() {
    return Center(
      child: Text(
        "لا يوجد بيانات",
        style: TextStyle(
          color: baseColorText,
        ),
      ),
    );
  }

  static searchFieldProps() {
    return TextFieldProps(
      textAlign: TextAlign.right,
      decoration: formlabel1(""),
      style: TextStyle(
        color: baseColorText,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  static clearButton() {
    return Icon(
      Icons.clear,
      color: baseColor,
    );
  }

  static dropDownButton() {
    return Icon(
      Icons.arrow_drop_down,
      color: baseColor,
    );
  }

  static popupItemBuilder(String name) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [Text(name, style: subtitleTx(baseColorText))],
      ),
    );
  }

  static dropdownBuilder(String? selectedItem2, String? selectedItem) {
    return Container(
      child: selectedItem2 == null
          ? null
          : Text(
              selectedItem2 == null ? "" : selectedItem ?? "",
              style: TextStyle(fontSize: 12, color: baseColorText),
            ),
    );
  }
}
