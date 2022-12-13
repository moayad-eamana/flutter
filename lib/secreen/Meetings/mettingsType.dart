import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/Meetings/manageTime/manageMettingTime.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class meettingsType extends StatefulWidget {
  const meettingsType({Key? key}) : super(key: key);

  @override
  State<meettingsType> createState() => _meettingsTypeState();
}

class _meettingsTypeState extends State<meettingsType> {
  @override
  Widget build(BuildContext context) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إدارة المواعيد", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StaggeredGrid.count(
                        crossAxisCount:
                            SizerUtil.deviceType == DeviceType.mobile ? 2 : 1,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 10,
                        children: [
                          StaggeredGridTile.extent(
                            crossAxisCellCount: 1,
                            mainAxisExtent: 120,
                            child: ElevatedButton(
                                style: cardServiece,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                        create: (context) => MettingsProvider(),
                                        // ignore: prefer_const_constructors
                                        child: MeetingView(),
                                      ),
                                    ),
                                  );
                                },
                                child: widgetsUni.cardcontentService(
                                    'assets/SVGs/mawa3idi.svg', "مواعيدي")),
                          ),
                          if (sharedPref.getBool("permissionforAppReq") == true)
                            StaggeredGridTile.extent(
                              crossAxisCellCount: 1,
                              mainAxisExtent: 120,
                              child: ElevatedButton(
                                  style: cardServiece,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              customerServiceRrequests(
                                                  "LeaderAppointment_dashboard")),
                                    );
                                  },
                                  child: widgetsUni.cardcontentService(
                                      'assets/SVGs/mawa3idi-mustafeed.svg',
                                      "مواعيد المستفيد")),
                            ),
                        ],
                      ),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         height: 120,
                      //         width: 50.w,
                      //         child: ElevatedButton(
                      //             style: cardServiece,
                      //             onPressed: () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       ChangeNotifierProvider(
                      //                     create: (context) =>
                      //                         MettingsProvider(),
                      //                     // ignore: prefer_const_constructors
                      //                     child: MeetingView(),
                      //                   ),
                      //                 ),
                      //               );
                      //             },
                      //             child: widgetsUni.cardcontentService(
                      //                 'assets/SVGs/mawa3idi.svg', "مواعيدي")),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     if (sharedPref.getBool("permissionforAppReq") == true)
                      //       Expanded(
                      //         child: Container(
                      //           height: 120,
                      //           child: ElevatedButton(
                      //               style: cardServiece,
                      //               onPressed: () {
                      //                 Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           customerServiceRrequests(
                      //                               "LeaderAppointment_dashboard")),
                      //                 );
                      //               },
                      //               child: widgetsUni.cardcontentService(
                      //                   'assets/SVGs/mawa3idi-mustafeed.svg',
                      //                   "مواعيد المستفيد")),
                      //         ),
                      //       ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      if (sharedPref.getBool("permissionforAppManege3") == true)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 120,
                                child: ElevatedButton(
                                    style: cardServiece,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                manegeMeetingTime()),
                                      );
                                    },
                                    child: widgetsUni.cardcontentService(
                                        'assets/SVGs/edit_calendar.svg',
                                        "إدارة المواعيد")),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                              height: 120,
                            ))
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
