import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class questServices {
  BuildContext context;
  questServices(this.context);

  static List<Widget> questWidget(BuildContext context) {
    listOfServices list = listOfServices(context);
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return [
      Text(
        "مهامي",
        style: subtitleTx(baseColor),
      ),
      widgetsUni.divider(),
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          ...list.questService().map((e) {
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
