import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SliderWidget {
  static List<Widget> sliderw(BuildContext context) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 250;

    return [
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 30,
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
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => EatemadatProvider(),
                          // ignore: prefer_const_constructors
                          child: InboxHedersView(),
                        ),
                      ),
                    );
                  },
                  child:
                      widgetsUni.cardcontentService(Icons.task, "إعتماداتي"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {},
                  child: widgetsUni.cardcontentService(
                      Icons.note_add, "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    print("object");
                  },
                  child: widgetsUni.cardcontentService(
                      Icons.note_add, "رصيد إجازات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/EamanaDiscount');
                  },
                  child: widgetsUni.cardcontentService(
                      Icons.local_offer_rounded, "عروض الموظفين"))),
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
                      Icons.not_accessible, "طلب إجازة"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, '/EamanaDiscount');
                  },
                  child: widgetsUni.cardcontentService(
                      Icons.note_add, "طلب خارج دوام"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    print("object");
                  },
                  child: widgetsUni.cardcontentService(
                      Icons.note_add, "رصيد إجازات"))),
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    print("object");
                  },
                  child: widgetsUni.cardcontentService(
                      Icons.note_add, "طلب إنتداب"))),
        ],
      )
    ];
  }
}
