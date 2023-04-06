import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/FirstVisit.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

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

  changePanale(panelIndex, isExpanded) {
    if (panelIndex == 0) {
      page1 = !page1;
      page2 = false;
      setState(() {});
    } else if (panelIndex == 1) {
      page2 = !page2;
      page1 = false;
      setState(() {});
    }
  }
}
