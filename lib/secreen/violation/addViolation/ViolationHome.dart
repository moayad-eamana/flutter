import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import 'add_violation_home.dart';

class ViolationHome extends StatefulWidget {
  const ViolationHome({Key? key}) : super(key: key);

  @override
  State<ViolationHome> createState() => _ViolationHomeState();
}

class _ViolationHomeState extends State<ViolationHome> {
  @override
  Widget build(BuildContext context) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("نظام المخالفات", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(left: 18, right: 18, bottom: 15.h, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaggeredGrid.count(
                      crossAxisCount:
                          SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 10,
                      children: [
                        StaggeredGridTile.extent(
                            crossAxisCellCount: 1,
                            mainAxisExtent: hi,
                            child: ElevatedButton(
                                style: cardServiece,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => add_violation(1)),
                                  );
                                },
                                child: widgetsUni.cardcontentService(
                                    'assets/SVGs/violation.svg', "أفراد"))),
                        StaggeredGridTile.extent(
                            crossAxisCellCount: 1,
                            mainAxisExtent: hi,
                            child: ElevatedButton(
                                style: cardServiece,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => add_violation(2)),
                                  );
                                },
                                child: widgetsUni.cardcontentService(
                                    'assets/SVGs/violation.svg',
                                    "مؤسسات وشركات"))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
