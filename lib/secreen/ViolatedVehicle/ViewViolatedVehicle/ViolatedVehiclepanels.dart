import 'dart:convert';

import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/FirstVisit.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/SecondVisit.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/transactions.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/violationInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import 'ViolatedVehicleinfo.dart';

class ViolatedVehichleDetails extends StatefulWidget {
  dynamic vehicle;
  int typId;
  ViolatedVehichleDetails(this.vehicle, this.typId);

  @override
  State<ViolatedVehichleDetails> createState() =>
      _ViolatedVehichleDetailsState();
}

class _ViolatedVehichleDetailsState extends State<ViolatedVehichleDetails> {
  bool page1 = false;
  bool page2 = false;
  bool page3 = false;
  bool page4 = false;
  bool page5 = false;
  List imageByArcSerial = [];
  @override
  void initState() {
    // TODO: implement initState
    getimage();
    openDefultePanel();
    super.initState();
  }

  void getimage() async {
    var respone = await getAction(
        "ViolatedCars/GetVisitAttachments/${widget.vehicle["Visits"][0]["ArcSerial"]}");
    respone = jsonDecode(respone.body);
    if (respone["StatusCode"] == 400) {
      respone = respone["data"];
      print(respone[0]["FilePath"]);
      imageByArcSerial = respone;
      print(imageByArcSerial);
      setState(() {});
    } else {
      //Alerts.warningAlert(context, "رسالة", "لا توجد بيانات").show();
    }
  }

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
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) async {
                        changePanale(panelIndex, isExpanded);
                      },
                      children: [
                        carinfo(),
                        firstvisit(),
                        if (widget.vehicle["StatusID"] >= 3) secondvisit(),
                        if (widget.vehicle["StatusID"] >= 4) violationInfoW(),
                        // transaction(),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                transactions(widget.vehicle["RequestID"])),
                      );
                    },
                    child: Text("سجل الطلب"),
                    style: ElevatedButton.styleFrom(
                      primary: baseColor, // Background color
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ExpansionPanel carinfo() {
    return ExpansionPanel(
      backgroundColor: BackGColor,
      isExpanded: page1,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        print(isExpanded);
        return ListTile(
          title: Text(
            "معلومات السيارة",
            style: subtitleTx(baseColor),
          ),
        );
      },
      body: ViolatedVehicle(widget.vehicle),
    );
  }

  ExpansionPanel firstvisit() {
    return ExpansionPanel(
      backgroundColor: BackGColor,
      isExpanded: page2,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        print(isExpanded);
        return ListTile(
          title: Text(
            "الزيارة الأولى",
            style: subtitleTx(baseColor),
          ),
        );
      },
      body: FirstVisit(widget.vehicle, imageByArcSerial, widget.typId),
    );
  }

  ExpansionPanel secondvisit() {
    return ExpansionPanel(
      backgroundColor: BackGColor,
      isExpanded: page3,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        print(isExpanded);
        return ListTile(
          title: Text(
            "الزيارة الثانية",
            style: subtitleTx(baseColor),
          ),
        );
      },
      body: SecondVisit(widget.vehicle, imageByArcSerial, widget.typId),
    );
  }

  ExpansionPanel violationInfoW() {
    return ExpansionPanel(
      backgroundColor: BackGColor,
      isExpanded: page4,
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        print(isExpanded);
        return ListTile(
          title: Text(
            "معلومات المخالفة",
            style: subtitleTx(baseColor),
          ),
        );
      },
      body: violationInfo(widget.vehicle, widget.typId),
    );
  }

  changePanale(panelIndex, isExpanded) {
    if (panelIndex == 0) {
      page1 = !page1;
      page2 = false;
      page3 = false;
      page4 = false;
      page5 = false;
    } else if (panelIndex == 1) {
      page2 = !page2;
      page1 = false;
      page3 = false;
      page4 = false;
      page5 = false;
    } else if (panelIndex == 2) {
      page3 = !page3;
      page1 = false;
      page2 = false;
      page4 = false;
      page5 = false;
    } else if (panelIndex == 3) {
      page4 = !page4;
      page1 = false;
      page2 = false;
      page3 = false;
      page5 = false;
    } else if (panelIndex == 4) {
      page5 = !page5;
      page4 = false;
      page1 = false;
      page2 = false;
      page3 = false;
    }
    setState(() {});
  }

  openDefultePanel() {
    if (widget.typId == 152) {
      page2 = true;
    } else if (widget.typId == 153) {
      page3 = true;
    } else if (widget.typId == 154 || widget.typId == 156) {
      page4 = true;
    }

    setState(() {});
  }
}
