import 'package:eamanaapp/provider/HrDecisionsProvider.dart';
import 'package:eamanaapp/secreen/eatemadat/HrDecisionsDetailesView.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
          status: 'loading...',
        );
        await Provider.of<HrDecisionsProvider>(context, listen: false)
            .fetchHrDecisions();
        EasyLoading.dismiss();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<HrDecisionsProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الإعتمادات", context),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/SVGs/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            ListView.builder(
                itemCount: _provider.HrDecisionsList.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: _provider,
                              child: HrDecisionsDetailesView(index),
                            ),
                          ));
                    },
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              _provider.HrDecisionsList[index].EmployeeName,
                              style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "نوع الطلب : " +
                                    _provider
                                        .HrDecisionsList[index].TransactionName,
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 13),
                              ),
                              Text(
                                "الإجراء المطلوب : " +
                                    _provider
                                        .HrDecisionsList[index].SignTypeName,
                                style: TextStyle(
                                    fontFamily: "Cairo", fontSize: 13),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text("التفاصيل")),
                              Icon(Icons.arrow_back_ios_new)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
