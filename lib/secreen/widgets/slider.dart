import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SliderWidget {
  static List<Widget> sliderw(BuildContext context, dynamic id) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 250;

    return [
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          if (id == 1)
            StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => EatemadatProvider(),
                          // ignore: prefer_const_constructors
                          child: InboxHedersView(),
                        ),
                      ),
                    );
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/e3tmadaty.svg', "إعتماداتي")),
            ),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/OutdutyRequest');
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/kharejdawam.svg', "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    print("object");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/ejaza.svg', "رصيد إجازات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/EamanaDiscount');
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/offers.svg', "عروض الموظفين"))),
        ],
      ),
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/VacationRequest');
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/ejaza.svg', "طلب إجازة"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/OutdutyRequest");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/kharejdawam.svg', "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/auhad');
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/3ohad.svg', "العهد"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/entedab");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/entdab.svg', "طلب إنتداب"))),
        ],
      )
    ];
  }
}
