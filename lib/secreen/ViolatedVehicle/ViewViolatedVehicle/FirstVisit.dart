import 'package:eamanaapp/provider/ViolatedVehicle/FirstVisitP.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class FirstVisit extends StatefulWidget {
  int typId;
  List imageByArcSerial;
  dynamic firstvisit;
  FirstVisit(this.firstvisit, this.imageByArcSerial, this.typId);

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
      getimage();
    });
  }

  void getimage() async {
    path = widget.imageByArcSerial
        .where((element) => element["DocTypeID"] == 762)
        .toList();
    print(path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    path = widget.imageByArcSerial
        .where((element) => element["DocTypeID"] == 762)
        .toList();
    print(path);
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
                  "https://archive.eamana.gov.sa/TransactFileUpload/" +
                      path[index]["FilePath"].toString(),
                  context);
            },
          ),
        ),
        // eatmad for first visit
        if (widget.firstvisit["StatusID"] == 2 && widget.typId != -1)
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widgetsUni.actionbutton('إحالة الطلب للمراقب', Icons.forward,
                    () async {
                  FirstVisitP.transformToinespector(
                      context, widget.firstvisit["RequestID"]);
                }),
                //cancel request
                widgetsUni.actionbutton('إغلاق الطلب', Icons.close, () async {
                  FirstVisitP.cancelRequest(
                      context, widget.firstvisit["RequestID"]);
                }),
              ],
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
