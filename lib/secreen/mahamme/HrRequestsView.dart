import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'HRdetailsView.dart';

class HrRequestsView extends StatefulWidget {
  HrRequestsView({Key? key}) : super(key: key);

  @override
  _HrRequestsViewState createState() => _HrRequestsViewState();
}

class _HrRequestsViewState extends State<HrRequestsView> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (Provider.of<EatemadatProvider>(context, listen: false)
              .getHrRequests
              .length ==
          0) {
        EasyLoading.show(
          status: 'جاري المعالجة...',
          maskType: EasyLoadingMaskType.black,
        );
        await Provider.of<EatemadatProvider>(context, listen: false)
            .fetchHrRequests();
        EasyLoading.dismiss();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    var _provider = Provider.of<EatemadatProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إعتماد شؤون الموضفين", context),
        body: Stack(
          children: [
            Image.asset(
              'assets/image/Union_1.png',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: _provider.getHrRequests.length == 0
                  ? Container()
                  : AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (width >= 768.0 ? 2 : 1),
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 170),
                          itemCount: _provider.getHrRequests.length,
                          itemBuilder: (BuildContext context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                curve: Curves.linear,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider.value(
                                                value: _provider,
                                                child: HRdetailsView(
                                                  index: index,
                                                )),
                                      ),
                                    );
                                  },
                                  child: Card(
                                      elevation: 1,
                                      color: Colors.white,
                                      //  color: Colors.white,
                                      //elevation: 3,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              Provider.of<EatemadatProvider>(
                                                      context)
                                                  .getHrRequests[index]
                                                  .RequesterName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Cairo",
                                                  color: baseColor),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 10, top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                subCard(
                                                    "نوع الطلب",
                                                    _provider
                                                        .getHrRequests[index]
                                                        .RequestType),
                                                dividerW(),
                                                subCard(
                                                    "تاريخ الطلب",
                                                    _provider
                                                        .getHrRequests[index]
                                                        .StartDateG
                                                        .split("T")[0]),
                                                //    dividerW(),
                                                //  subCard(
                                                //    "رقم الطلب",
                                                //  _provider.getHrRequests[index].RequestNumber
                                                //    .toString()),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            endIndent: 5,
                                            indent: 5,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 10, left: 10, top: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "التفاصيل",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: "Cairo"),
                                                ),
                                                Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            );
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dividerW() {
    return SizedBox(
      height: 50,
      child: VerticalDivider(
        thickness: 0.1,
        color: Colors.black,
        indent: 5,
      ),
    );
  }

  Widget subCard(String title, String dec) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14, fontFamily: "Cairo", fontWeight: FontWeight.bold),
        ),
        Text(dec, style: TextStyle(fontSize: 14, fontFamily: "Cairo"))
      ],
    );
  }
}
