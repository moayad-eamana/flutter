import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:flutter/material.dart';

class listOfSupportTypes {
  static List list(BuildContext context) {
    return [
      {
        "service_name": "عبارات شكر للمتميزين",
        "icon": 'assets/SVGs/offers.svg',
        "messages": [
          "إن النجاح الذي تحققه هو شغفك اللامتناهي لعملك، وهذا ما يحفز الجميع في الشركة، نشكرك على اختيار هذا النهج المثمر، لقد ارتقيت بمستوى هذه المؤسسة إلى آفاق جديدة، نحن نقدر ما تفعله.",
          "على الرغم من أن جميع كلمات الشكر والثناء لا توفيك حقك والإشادة بك كموظف مجتهد ومميز لدينا، ما زلت أودّ أن أتمنى لك خالص الشكر وأؤكد دعمي لك على الدوام.",
        ]
      },
      {
        "service_name": "عبارات شكر وتقدير للموظفين",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      {
        "service_name": "كلمات شكر وزيادة الانتاجية",
        "icon": 'assets/SVGs/offers.svg',
        "messages": [
          "لقد تجاوزت كل التوقعات، أودّ أن أحيي إخلاصك والتزامك ومثابرتك، استمر هكذا وستحقق الكثير!",
          "إنني مدير محظوظ للغاية لكونك أحد موظفي الشركة، أنت سبب من أسباب نجاح المؤسسة ونحن فخورون بجهودك وبعملك معنا، نتمنى لك دوام التفوّق والنجاح.",
          "لقد أثبت نفسك خلال فترة قصيرة بين جميع الموظفين كواحد من أفضل خياراتنا، نتوقع لك مستقبلاً باهراً، ونعتزّ بوجودك في فريقنا، شكراً لك على جهدك وإخلاصك في العمل."
        ]
      },
      {
        "service_name": "استقبال موظف",
        "icon": 'assets/SVGs/offers.svg',
        "messages": ["شكرا", "كفو", "يعطيك العافية"]
      },
      // {
      //   "service_name": "عبارات شكر للموظفين المتقاعدين",
      //   "icon": 'assets/SVGs/offers.svg',
      //   "messages": ["شكرا جزيلا", "كفو", "يعطيك العافية"]
      // },
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
