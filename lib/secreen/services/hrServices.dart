import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class hrServicesWidget {
  BuildContext context;
  hrServicesWidget(this.context);
  List<Widget> hrServices() {
    listOfServices list = listOfServices(context);
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return [
      //hr
      if (sharedPref.getInt("empTypeID") != 8 ||
          sharedPref.getInt("MainDepartmentID") == 422150000)
        Text(
          "خدمات الموظفين",
          style: subtitleTx(baseColor),
        ),
      if (sharedPref.getInt("empTypeID") != 8 ||
          sharedPref.getInt("MainDepartmentID") == 422150000)
        widgetsUni.divider(),
      if (sharedPref.getInt("empTypeID") != 8 ||
          sharedPref.getInt("MainDepartmentID") == 422150000)
        SizedBox(
          height: 5,
        ),
      if (sharedPref.getInt("empTypeID") != 8 ||
          sharedPref.getInt("MainDepartmentID") == 422150000)
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: StaggeredGrid.count(
            crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            children: [
              ...list.hrservices().map((e) {
                return StaggeredGridTileW(
                    1,
                    hi,
                    widgetsUni.servicebutton2(
                        e["service_name"], e["icon"], e["Action"]));
              }),
            ],
          ),
        ),
    ];
  }
}
