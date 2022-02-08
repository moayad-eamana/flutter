import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SliderWidget {
  static List<Widget> sliderw() {
    return [
      Container(
        //color: Colors.red,
        //width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        //decoration: BoxDecoration(color: Colors.amber),
        child: StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 30,
          children: [
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(Icons.task, "مهامي"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.note_add, "طلب خارج دوام"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.note_add, "رصيد إجازات"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.local_offer_rounded, "عروض الموظفين"))),
          ],
        ),
      ),
      Container(
        //color: Colors.red,
        //width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        //decoration: BoxDecoration(color: Colors.amber),
        child: StaggeredGrid.count(
          crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          children: [
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.not_accessible, "طلب إجازة"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.note_add, "طلب خارج دوام"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.note_add, "رصيد إجازات"))),
            StaggeredGridTile.extent(
                crossAxisCellCount: 1,
                mainAxisExtent: 100,
                child: ElevatedButton(
                    style: cardServiece,
                    onPressed: () {
                      print("object");
                    },
                    child: widgetsUni.cardcontentService(
                        Icons.note_add, "طلب إنتداب"))),
          ],
        ),
      )
    ];
  }
}
