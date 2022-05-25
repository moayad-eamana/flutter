import 'package:eamanaapp/provider/mahamme/LoansRequestsProvider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'LoansRequestsDetailesView.dart';

class LoansRequestsView extends StatefulWidget {
  LoansRequestsView({Key? key}) : super(key: key);

  @override
  _LoansRequestsViewState createState() => _LoansRequestsViewState();
}

class _LoansRequestsViewState extends State<LoansRequestsView> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (Provider.of<LoansRequestsProvider>(context, listen: false)
          .LoansRequestList
          .isEmpty) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );
        await Provider.of<LoansRequestsProvider>(context, listen: false)
            .fetchRejectReasonNames();
        await Provider.of<LoansRequestsProvider>(context, listen: false)
            .fethLoansRequests();
        EasyLoading.dismiss();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<LoansRequestsProvider>(context);
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الاعارات", context, null),
        body: _provider.LoansRequestList.length == 0
            ? Center(
                child: Text(
                  "لا يوجد إعتمادات",
                  style: subtitleTx(baseColorText),
                ),
              )
            : Stack(
                children: [
                  Image.asset(
                    imageBG,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (width >= 768.0 ? 2 : 1),
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 200),
                          itemCount: _provider.LoansRequestList.length,
                          itemBuilder: (BuildContext context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                curve: Curves.linear,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider.value(
                                                value: _provider,
                                                child:
                                                    LoansRequestsDetailesView(
                                                  index: index,
                                                )),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 200,
                                    child: Card(
                                      elevation: 1,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _provider.LoansRequestList[index]
                                                .EmployeeName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                                color: baseColor),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("نوع الطلب",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(_provider
                                                      .LoansRequestList[index]
                                                      .RequestTypeName),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("الاجراء المتخذ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(_provider
                                                      .LoansRequestList[index]
                                                      .StatusName),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            thickness: 0.5,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("التفاصيل"),
                                                Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
}
