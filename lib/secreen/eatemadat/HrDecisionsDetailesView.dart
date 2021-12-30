import 'package:eamanaapp/provider/HrDecisionsProvider.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    var _provider = Provider.of<HrDecisionsProvider>(context).HrDecisionsList;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("التفاصيل", context),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/SVGs/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            Center(
                              child: Text(_provider[widget.index].EmployeeName),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(" رقم الوظيفي : " +
                                    _provider[widget.index]
                                        .EmplyeeNumber
                                        .toString()),
                                const SizedBox(
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
                            const Divider(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("الادارة السابقة"),
                                  Text(
                                      _provider[widget.index].OldDepartmentName)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.forward),
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("الادارة الحالية"),
                                  Text(
                                      _provider[widget.index].NewDepartmentName)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {},
                            child: const Text("قبول"),
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
