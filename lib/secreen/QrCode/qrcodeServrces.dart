import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/utilities/QRCodeList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class QrCodeServices {
  BuildContext context;
  QrCodeServices(this.context);

  static List<Widget> qrCodeWidget(BuildContext context) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return [
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          // ...QrcodeList.qrcodelist(context).map((e) {
          //   return StaggeredGridTileW(
          //       1,
          //       hi,
          //       widgetsUni.servicebutton2(
          //           e["service_name"], e["icon"], e["Action"]));
          // }),
        ],
      ),
    ];
  }
}
