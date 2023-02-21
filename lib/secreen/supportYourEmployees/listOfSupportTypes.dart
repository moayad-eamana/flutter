import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:flutter/material.dart';

class listOfSupportTypes {
  static List list(BuildContext context) {
    return [
      {
        "service_name": "عبارات شكر للمتميزين",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      {
        "service_name": "عبارات شكر وتقدير للموظفين",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      {
        "service_name": "كلمات شكر وزيادة الانتاجية",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      {
        "service_name": "استقبال موظف",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      {
        "service_name": "عبارات شكر للموظفين المتقاعدين",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا جزيلا", "كفو", "يعطيك العافية"]
      },
    ];
  }

  static NavigatTo(BuildContext context, List messages) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SupportMessages(
                messages,
              )),
      // ignore: prefer_const_constructors
    );
  }
}
