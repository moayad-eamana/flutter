import 'package:eamanaapp/provider/mahamme/HrDecisionsProvider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'HrDecisionsDetailesView.dart';

class HrDecisionsView extends StatefulWidget {
  const HrDecisionsView({Key? key}) : super(key: key);

  @override
  _HrDecisionsViewState createState() => _HrDecisionsViewState();
}

class _HrDecisionsViewState extends State<HrDecisionsView> {
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (Provider.of<HrDecisionsProvider>(context, listen: false)
              .HrDecisionsList
              .length ==
          0) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );
        await Provider.of<HrDecisionsProvider>(context, listen: false)
            .fetchHrDecisions();
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
    var _provider = Provider.of<HrDecisionsProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("القرارت الإلكترونية", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            _provider.HrDecisionsList.length == 0
                ? Center(
                    child: Text(
                      "لا يوجد بيانات",
                      style: subtitleTx(baseColorText),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: AnimationLimiter(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (width >= 768.0 ? 2 : 1),
                                  mainAxisSpacing: 12,
                                  mainAxisExtent: 140),
                          itemCount: _provider.HrDecisionsList.length,
                          itemBuilder: (BuildContext context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
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
                                                HrDecisionsDetailesView(index),
                                          ),
                                        ));
                                  },
                                  child: Card(
                                    elevation: 1,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          _provider.HrDecisionsList[index]
                                              .EmployeeName,
                                          style: TextStyle(
                                              color: baseColor,
                                              fontFamily: ("Cairo"),
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  width >= 768.0 ? 22 : 14),
                                        )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "نوع الطلب : " +
                                                  _provider
                                                      .HrDecisionsList[index]
                                                      .TransactionName,
                                              style: TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              "الإجراء المطلوب : " +
                                                  _provider
                                                      .HrDecisionsList[index]
                                                      .SignTypeName,
                                              style: TextStyle(
                                                  fontFamily: "Cairo",
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Divider(
                                            endIndent: 8,
                                            indent: 8,
                                            thickness: 0.5,
                                            height: 20,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text("التفاصيل")),
                                            Icon(Icons.arrow_back_ios_new)
                                          ],
                                        )
                                      ],
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
