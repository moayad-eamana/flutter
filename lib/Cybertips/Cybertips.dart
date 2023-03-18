import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class Cybertips extends StatefulWidget {
  Cybertips({Key? key}) : super(key: key);

  @override
  State<Cybertips> createState() => _CybertipsState();
}

class _CybertipsState extends State<Cybertips> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("نصائح", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            ListView.builder(
                itemCount: CybertipsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: containerdecoration(Colors.white),
                        child: ListTile(
                          title: Text(
                            CybertipsList[index]["title"],
                            style: subtitleTx(baseColor),
                          ),
                          subtitle: Text(CybertipsList[index]["body"],
                              style: subtitleTx(baseColorText)),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  List CybertipsList = [
    {
      "title": "نصائح لحماية جهازك الآلي",
      "body":
          "قم بعمل نسخ إحتياطي لجهازك والإعدادات الخاصة بك بإنتظام لاتضغط علىأي رسائل بريد إلكتروني تصل من بريد مشبوه"
    },
    {
      "title": "الاستخدام الآمن للإنترنت",
      "body":
          "إنتبه من حقوق الملكيةالفكرية عند تحميل الملفات والمستندات من الانترنت"
    },
  ];
}
