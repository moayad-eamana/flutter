import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class ViolatedVehichleDetails extends StatefulWidget {
  const ViolatedVehichleDetails({Key? key}) : super(key: key);

  @override
  State<ViolatedVehichleDetails> createState() =>
      _ViolatedVehichleDetailsState();
}

class _ViolatedVehichleDetailsState extends State<ViolatedVehichleDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("تفاصيل الطلب", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        cards("هوية المالك", '102255514484'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        cards("رقم الطلب", '1518'),
                        cards("تاريخ الطلب", '2023-03-08'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        cards("رقم اللوحة", '1342'),
                        cards("الحروف", 'DFR'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        cards("السيارة", "سوناتا"),
                        cards("نوع السيارة", "هونداي")
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        cards("موديل السيارة", "2007"),
                        cards("الحالة", "على قيد الحياه"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        cards("المنطقة", 'وسط الدمام - حي السلام'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widgetsUni.actionbutton('عرض الموقع', Icons.map,
                              () async {
                            if (await launchUrl(
                                Uri.parse(
                                    "https://www.google.com/maps/search/?api=1&query=${26.394624},${50.095718412}"),
                                mode: LaunchMode.externalApplication)) {
                            } else {
                              await launchUrl(
                                Uri.parse(
                                    "https://www.google.com/maps/search/?api=1&query=${26.394624},${50.095718412}"),
                              );
                            }
                          }),
                          widgetsUni.actionbutton(
                              'عرض المرفقات', Icons.attach_file, () {}),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget cards(String title, String desc) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
          child: Container(
        decoration: containerdecoration(BackGWhiteColor),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              style: subtitleTx(secondryColorText),
            ),
            Text(desc, style: subtitleTx(baseColorText)),
          ],
        ),
      )),
    ),
  );
}
