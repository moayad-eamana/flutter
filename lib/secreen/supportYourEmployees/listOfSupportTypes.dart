import 'package:eamanaapp/secreen/EmpInfo/newEmpinfo.dart';
import 'package:flutter/material.dart';

class listOfSupportTypes {
  static list(BuildContext context) {
    return [
      {
        "service_name": "العروض",
        "icon": 'assets/SVGs/offers.svg',
        "Action": () {}
      },
    ];
  }

  NavigatTo(BuildContext context, List messages) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newEmpInfo(true)),
      // ignore: prefer_const_constructors
    );
  }
}
