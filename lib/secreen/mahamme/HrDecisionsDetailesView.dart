import 'package:eamanaapp/provider/mahamme/HrDecisionsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class HrDecisionsDetailesView extends StatefulWidget {
  int index;

  HrDecisionsDetailesView(this.index);

  @override
  _HrDecisionsDetailesViewState createState() =>
      _HrDecisionsDetailesViewState();
}

class _HrDecisionsDetailesViewState extends State<HrDecisionsDetailesView> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<HrDecisionsProvider>(context, listen: false)
        .HrDecisionsList;
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("التفاصيل", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      child: Card(
                        color: BackGWhiteColor,
                        elevation: 1,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                _provider[widget.index].EmployeeName,
                                style: TextStyle(
                                    color: baseColor,
                                    fontFamily: ("Cairo"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: width >= 768.0 ? 22 : 14),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("رقم الوظيفي : " +
                                    _provider[widget.index]
                                        .EmplyeeNumber
                                        .toString()),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    indent: 10,
                                    thickness: 0.5,
                                  ),
                                ),
                                Text("التاريخ : " +
                                    _provider[widget.index]
                                        .ExexutionDateG
                                        .toString()
                                        .split("T")[0]),
                              ],
                            ),
                            Divider(
                              endIndent: 8,
                              indent: 8,
                              thickness: 0.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("رقم الطلب : " +
                                    _provider[widget.index].Seq.toString())
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("نوع الطلب"),
                                  Text(_provider[widget.index].TransactionName)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.forward),
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("الاجراء المتخذ"),
                                  Text(_provider[widget.index].SignTypeName)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 100.w,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("الادارة السابقة"),
                            Text(_provider[widget.index].OldDepartmentName)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 100.w,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("الادارة الحالية"),
                            Text(_provider[widget.index].NewDepartmentName)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("المرتبة السابقة"),
                                  Text(_provider[widget.index]
                                      .OldClass
                                      .toString())
                                ],
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.forward),
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("المرتبة الحالية"),
                                  Text(_provider[widget.index]
                                      .NewClass
                                      .toString())
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: baseColor, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              Alerts.confirmAlrt(
                                      context, "", "تأكيد قبول الطلب", "نعم")
                                  .show()
                                  .then((value) async {
                                if (value == true) {
                                  EasyLoading.show(
                                    status: '... جاري المعالجة',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  var bool =
                                      await Provider.of<HrDecisionsProvider>(
                                              context,
                                              listen: false)
                                          .PostAproveDesition(widget.index);
                                  EasyLoading.dismiss();
                                  if (bool == true) {
                                    Alerts.successAlert(
                                            context, "", "تم القبول ")
                                        .show()
                                        .then((value) {
                                      // to exit from secreen after clicking حسنا btn
                                      //remova page from secreen
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    Alerts.errorAlert(context, "", bool).show();
                                  }
                                }
                              });
                            },
                            child: Text("قبول"),
                          ),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
