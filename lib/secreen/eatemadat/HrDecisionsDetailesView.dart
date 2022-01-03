import 'package:eamanaapp/provider/HrDecisionsProvider.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
                                  const Text("نوع الطلب"),
                                  Text(_provider[widget.index].TransactionName)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.forward),
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
                            height: 120,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("الادارة السابقة"),
                                  Text(
                                      _provider[widget.index].OldDepartmentName)
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.forward),
                        Expanded(
                          child: Container(
                            height: 120,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("الادارة الحالية"),
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
                                  const Text("المرتبة السابقة"),
                                  Text(_provider[widget.index]
                                      .OldClass
                                      .toString())
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.forward),
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("المرتبة الحالية"),
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
                            onPressed: () {
                              showalert("", "هل أنت متأكد من القبول", context)
                                  .show()
                                  .then((value) {
                                if (value == true) {
                                  showalertsu("", "تم القبول ")
                                      .show()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            },
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

  Alert showalert(String title, String desc, context) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            "نعم",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            EasyLoading.show(
              status: 'loading...',
            );
            await Provider.of<HrDecisionsProvider>(context, listen: false)
                .PostAproveDesition(widget.index);
            Navigator.pop(context, true);
            EasyLoading.dismiss();
          },
          width: 120,
        ),
        DialogButton(
          child: const Text(
            "إلغاء",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    );
  }

  Alert showalertsu(String title, String desc) {
    return Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            "حسنا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        ),
      ],
    );
  }
}
