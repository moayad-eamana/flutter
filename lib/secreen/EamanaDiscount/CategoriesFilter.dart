import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class CategoriesFilter extends StatefulWidget {
  CategoriesFilter({Key? key}) : super(key: key);

  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  dynamic _GetCategories = [];
  double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  getdata() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    var respose = await getAction("Offers/GetCategories/");

    setState(() {
      _GetCategories = (jsonDecode(respose.body)["CategoriesList"]);

      // print(_GetCategories);
    });
    EasyLoading.dismiss();
  }

  List<dynamic> icon = [
    "assets/SVGs/offers.svg",
    "assets/SVGs/offers.svg",
    "assets/SVGs/offers.svg",
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("تصنيفات العروض", context, null),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  imageBG,
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: _GetCategories == null
                      ? Center(
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "لا يوجد تصنيفات",
                                  style: subtitleTx(secondryColorText),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              child: StaggeredGrid.count(
                                crossAxisCount:
                                    SizerUtil.deviceType == DeviceType.mobile
                                        ? 3
                                        : 4,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 8,
                                children: [
                                  ..._GetCategories.map(
                                    (e) => StaggeredGridTile.extent(
                                      crossAxisCellCount: 1,
                                      mainAxisExtent: hi,
                                      child: ElevatedButton(
                                        style: cardServiece,
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           CategoriesFilter()),
                                          // );
                                          print(e['CategoryID'].toString());
                                        },
                                        child: widgetsUni.cardcontentService(
                                          icon[e['CategoryID']],
                                          e['CategoryName'].toString(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ],
          )),
    );
  }
}
