import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class attendanceService {
  BuildContext context;
  attendanceService(this.context);

  static List<Widget> attendanceWidget(BuildContext context) {
    listOfServices list = listOfServices(context);
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return [
      if (sharedPref.getInt("empTypeID") == 8)
        Text(
          "الحضور والإنصراف",
          style: subtitleTx(baseColor),
        ),
      if (sharedPref.getInt("empTypeID") == 8) widgetsUni.divider(),
      if (sharedPref.getInt("empTypeID") == 8)
        SizedBox(
          height: 10,
        ),
      if (sharedPref.getInt("empTypeID") == 8)
        StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            ...list.attendanceService().map((e) {
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
