import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstVisit extends StatefulWidget {
  dynamic firstvisit;
  FirstVisit(this.firstvisit);

  @override
  State<FirstVisit> createState() => _FirstVisitState();
}

class _FirstVisitState extends State<FirstVisit> {
  dynamic visits;
  List path = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      visits = widget.firstvisit["Visits"][0];
      print(visits);
      getimage();
    });
  }

  void getimage() async {
    var respone = await getAction(
        "ViolatedCars/GetVisitAttachments/${visits["ArcSerial"]}");
    respone = jsonDecode(respone.body);
    if (respone["StatusCode"] == 400) {
      respone = respone["data"];
      print(respone[0]["FilePath"]);
      path = [
        "https://archive.eamana.gov.sa/TransactFileUpload/" +
            respone[1]["FilePath"]
      ];
      setState(() {});
    } else {
      Alerts.warningAlert(context, "رسالة", "لا توجد بيانات").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            cards(
                "تاريخ الزيارة", visits["VisitDate"].toString().split("T")[0]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("ملاحظات",
                visits["Notes"] == "" ? "لاتوجد ملاحظات" : visits["Notes"]),
          ],
        ),
        SizedBox(
          height: 5,
        ),

        /// show images
        Container(
          margin: EdgeInsets.all(15),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: path.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 5.0),
            itemBuilder: (BuildContext context, int index) {
              return widgetsUni.viewImageNetwork(
                  path[index].toString(), context);
            },
          ),
        ),
      ],
    );
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
}
