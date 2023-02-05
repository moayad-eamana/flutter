import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';

class salaryWidgets {
  BuildContext context;
  salaryWidgets(this.context);

  static List<Widget> salaryWidget(BuildContext context) {
    listOfServices list = listOfServices(context);
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return [
      if (sharedPref.getInt("empTypeID") != 8)
        Text(
          "الرواتب",
          style: subtitleTx(baseColor),
        ),
      if (sharedPref.getInt("empTypeID") != 8) widgetsUni.divider(),
      if (sharedPref.getInt("empTypeID") != 8)
        StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            ...list.Salarservices().map((e) {
              return StaggeredGridTileW(
                  1,
                  hi,
                  widgetsUni.servicebutton2(
                      e["service_name"], e["icon"], e["Action"]));
            }),
          ],
        ),
    ];
  }
}
