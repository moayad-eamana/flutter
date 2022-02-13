import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class DropdownSearchW {
  String value = "";
  DropdownSearch drop(List<String> item, String LableName) {
    //dynamic values = "";

    return DropdownSearch<String>(
      items: item,
      mode: Mode.BOTTOM_SHEET,
      showSelectedItems: true,
      showClearButton: true,
      maxHeight: 400,
      showAsSuffixIcons: true,
      dropdownSearchDecoration: InputDecoration(
        hintText: LableName,
        helperStyle: TextStyle(color: Colors.amber),
        contentPadding: EdgeInsets.symmetric(
            vertical: responsiveMT(10, 30), horizontal: responsiveMT(10, 20)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: bordercolor),
        ),
      ),
      validator: (String? value) {
        if (value == "" || value == null) {
          return "hgfef";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (String? v) {
        print('object');
        value = v ?? "";
      },
      popupTitle: Container(
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
            LableName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      popupShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    );
  }
}
