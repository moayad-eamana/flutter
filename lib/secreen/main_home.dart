import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/services/servicesView.dart';
import 'package:eamanaapp/secreen/statistics/statistics.dart';
import 'package:eamanaapp/secreen/widgets/slider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'EmpInfo/EmpInfoView.dart';
import 'mahamme/InboxHedersView.dart';
import 'package:sizer/sizer.dart';
import 'package:barcode/barcode.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var _currentIndex = 0;
  List<int> selectsilder = [0, 1];

  List<dynamic> slider = [
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 70),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  //controller: _search,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.search), onPressed: () async {}),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "بحث الخدمات",
                    alignLabelWithHint: true,
                  ),
                  onChanged: (String val) {},
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text("خدمة سريعة"),
                    Expanded(
                      child: Container(
                          // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                        color: Colors.black,
                        height: 25,
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      )),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widgetsUni.servicebutton(
                          "مواعيد",
                          Icons.calendar_today,
                          () {
                            print("ee");
                          },
                        ),
                        widgetsUni.servicebutton(
                          "بياناتي",
                          Icons.data_saver_off_outlined,
                          () {
                            print("ee");
                          },
                        ),
                        widgetsUni.servicebutton(
                          "دليل الموظفين",
                          Icons.people_alt,
                          () {
                            print("ee");
                          },
                        ),
                        widgetsUni.servicebutton(
                          "طلب استيكر",
                          Icons.directions_car,
                          () {
                            print("ee");
                          },
                        ),
                        widgetsUni.servicebutton(
                          "تعريف بالراتب",
                          Icons.money,
                          () {
                            print("ee");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFDDDDDD),
                    ),
                    //color: baseColor,
                    borderRadius: BorderRadius.all(
                      new Radius.circular(4),
                    ),
                  ),
                  //color: Colors.red,
                  height: 300,
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "الخدمات الاكثر أستخداماً",
                        style: titleTx(baseColor),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 180.0,
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                _currentIndex = index;
                              },
                            );
                          },
                        ),
                        items: SliderWidget.sliderw(),
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: selectsilder.map((urlOfItem) {
                              int index = selectsilder.indexOf(urlOfItem);
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentIndex == index
                                      ? Color.fromRGBO(0, 0, 0, 0.8)
                                      : Color.fromRGBO(0, 0, 0, 0.3),
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            left: 5,
                            bottom: 5,
                            child: Image(
                                width: 15.w,
                                //height: 15.h,
                                image:
                                    AssetImage("assets/image/raqmy-logo.png")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
