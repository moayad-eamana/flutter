import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SliderWidget {
  static List<Widget> sliderw(BuildContext context, dynamic id) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 120 : 250;
    listOfServices list = listOfServices(context);
    return [
      StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            ...list.sliderService1().map((e) {
              return StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: hi,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: e["Action"],
                    child: widgetsUni.cardcontentService(
                        e["icon"], e["service_name"])),
              );
            }),
          ]),
      StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            ...list.sliderService2().map((e) {
              return StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: hi,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: e["Action"],
                    child: widgetsUni.cardcontentService(
                        e["icon"], e["service_name"])),
              );
            }),
          ]),
    ];
  }
}
