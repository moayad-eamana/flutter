import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/FirstVisit.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/SecondVisit.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/violationInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import 'ViolatedVehicleinfo.dart';

class ViolatedVehichleDetails extends StatefulWidget {
  dynamic vehicle;
  ViolatedVehichleDetails(this.vehicle);

  @override
  State<ViolatedVehichleDetails> createState() =>
      _ViolatedVehichleDetailsState();
}

class _ViolatedVehichleDetailsState extends State<ViolatedVehichleDetails> {
  bool page1 = false;
  bool page2 = false;
  bool page3 = false;
  bool page4 = false;

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
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) async {
                    changePanale(panelIndex, isExpanded);
                  },
                  children: [
                    carinfo(),
                    firstvisit(),
                    secondvisit(),
                    violationInfoW()
                  ],
                ),
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
      body: FirstVisit(widget.vehicle),
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
      body: SecondVisit(widget.vehicle),
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
      body: violationInfo(widget.vehicle),
    );
  }

  changePanale(panelIndex, isExpanded) {
    if (panelIndex == 0) {
      page1 = !page1;
      page2 = false;
      page3 = false;
      page4 = false;
    } else if (panelIndex == 1) {
      page2 = !page2;
      page1 = false;
      page3 = false;
      page4 = false;
    } else if (panelIndex == 2) {
      page3 = !page3;
      page1 = false;
      page2 = false;
      page4 = false;
    } else if (panelIndex == 3) {
      page4 = !page4;
      page1 = false;
      page2 = false;
      page3 = false;
    }
    setState(() {});
  }
}
