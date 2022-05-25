import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class SliderWidget {
  static List<Widget> sliderw(BuildContext context, dynamic id) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 120 : 250;

    return [
      StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 2 : 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        children: [
          // if (id == 1)
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
                  onPressed: () async {
                    EasyLoading.show(
                      status: '... جاري المعالجة',
                      maskType: EasyLoadingMaskType.black,
                    );
                    String emNo = await EmployeeProfile.getEmployeeNumber();
                    dynamic respose =
                        await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
                    print(respose);
                    respose =
                        jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
                    EasyLoading.dismiss();
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          backgroundColor: BackGWhiteColor,
                          title: Builder(builder: (context) {
                            return Center(
                              child: Text(
                                'رصيد الاجازات',
                                style: titleTx(baseColor),
                              ),
                            );
                          }),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                respose.toString(),
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: secondryColor),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widgetsUni.actionbutton(
                                  'طلب إجازة',
                                  Icons.send,
                                  () {
                                    Navigator.pushNamed(
                                            context, "/VacationRequest")
                                        .then(
                                            (value) => Navigator.pop(context));
                                  },
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text(
                                    'إغلاق',
                                    style: subtitleTx(baseColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
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
                    Navigator.pushNamed(context, '/auhad');
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/3ohad.svg', "العهد"))),
          // StaggeredGridTile.extent(
          //     crossAxisCellCount: 1,
          //     mainAxisExtent: hi,
          //     child: ElevatedButton(
          //         style: cardServiece,
          //         onPressed: () {
          //           Navigator.pushNamed(context, '/EamanaDiscount');
          //         },
          //         child: widgetsUni.cardcontentService(
          //             'assets/SVGs/offers.svg', "عروض الموظفين"))),
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
              crossAxisCellCount: 1, mainAxisExtent: hi, child: Container()),
          // StaggeredGridTile.extent(
          //     crossAxisCellCount: 1,
          //     mainAxisExtent: hi,
          //     child: ElevatedButton(
          //         style: cardServiece,
          //         onPressed: () {
          //           Navigator.pushNamed(context, "/OutdutyRequest");
          //         },
          //         child: widgetsUni.cardcontentService(
          //             'assets/SVGs/kharejdawam.svg', "طلب خارج دوام"))),
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
