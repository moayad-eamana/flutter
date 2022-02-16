import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/provider/mahamme/LoansRequestsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoansRequestsDetailesView extends StatefulWidget {
  int? index;
  LoansRequestsDetailesView({index});

  @override
  _LoansRequestsDetailesViewState createState() =>
      _LoansRequestsDetailesViewState();
}

class _LoansRequestsDetailesViewState extends State<LoansRequestsDetailesView> {
  int val = 1;
  String error = "";
  var FinancialType = null;
  var ApproveFlag = "A";

  @override
  Widget build(BuildContext context) {
    var _list = Provider.of<LoansRequestsProvider>(context, listen: false)
        .LoansRequestList[widget.index ?? 0];
    var _provider = Provider.of<LoansRequestsProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("الاعارات", context),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset(
                'assets/image/Union_1.png',
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Column(
                children: [
                  Card(
                    elevation: 1,
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          _list.EmployeeName,
                          style: TextStyle(
                              color: baseColor,
                              fontFamily: ("Cairo"),
                              fontWeight: FontWeight.bold,
                              fontSize: width >= 768.0 ? 22 : 14),
                        )),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("الجهه المعار اليها",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(_list.LocationName),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                thickness: 0.5,
                              ),
                            ),
                            Column(
                              children: [
                                const Text("مده الاعاره",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(_list.DurationName),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("الجهة المتحملة للاعارة :" +
                            _list.EmployeeDepartmentName),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "جهة العمل",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_list.EmployeeDepartmentName),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "الوظيفة",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(_list.ActualJobName == ""
                                    ? "محلل نظم"
                                    : _list.ActualJobName),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "سبب الاعارة",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(_list.Reasons))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "بداية الاعارة",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("2020/01/01"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "نهاية الاعارة",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("2020/12/29"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "توصيات اللجنة",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(_list.Recommendations))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            child: const Text("قبول"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              String loan = "";
                              String errorval = "";
                              FinancialType = "A";
                              ApproveFlag = "A";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 300,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  title: const Text(
                                                      "تتكفل الجهة الاصلية"),
                                                  leading: Radio(
                                                    value: 1,
                                                    groupValue: val,
                                                    toggleable: true,
                                                    onChanged: (s) {
                                                      FinancialType = "A";
                                                      setState(() {
                                                        val = 1;
                                                      });
                                                    },
                                                    activeColor: Colors.green,
                                                  ),
                                                ),
                                                ListTile(
                                                  title: const Text(
                                                      "تتكفل الجهة المعارة"),
                                                  leading: Radio(
                                                    value: 2,
                                                    groupValue: val,
                                                    toggleable: true,
                                                    onChanged: (s) {
                                                      FinancialType = "S";
                                                      setState(() {
                                                        val = 2;
                                                      });
                                                    },
                                                    activeColor: Colors.green,
                                                  ),
                                                ),
                                                DropdownSearch<String>(
                                                  items: const [
                                                    "سنة",
                                                    "ثلاثة أشهر",
                                                    "ثلاث سنوات",
                                                    "ستة أشهر"
                                                  ],
                                                  maxHeight: 300,
                                                  mode: Mode.BOTTOM_SHEET,
                                                  showClearButton: true,
                                                  showAsSuffixIcons: true,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    labelText: "مدة الاعارة",
                                                    errorText: errorval == ""
                                                        ? null
                                                        : errorval,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            12, 12, 0, 0),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  showSearchBox: true,
                                                  onChanged: (String? v) {
                                                    setState(() {
                                                      if (v == null) {
                                                        loan = "";
                                                        errorval =
                                                            "الرجاء إختيار مدة الاعارة";
                                                      } else {
                                                        loan = v;
                                                        errorval = "";
                                                      }
                                                    });
                                                  },
                                                  popupTitle: Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[100],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'مدة الاعارة',
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  popupShape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(24),
                                                      topRight:
                                                          Radius.circular(24),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 3,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelText: "ملاحظات",
                                                    alignLabelWithHint: true,
                                                  ),
                                                  onChanged: (String val) {
                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            color: Colors.red,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "إلغاء",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          FlatButton(
                                            color: Colors.green,
                                            onPressed: () async {
                                              if (errorval != "" ||
                                                  loan == "") {
                                                setState(() {
                                                  errorval =
                                                      "الرجاء إختيار مدة الاعارة";
                                                });

                                                return;
                                              }
                                              EasyLoading.show(
                                                status: 'جاري المعالجة...',
                                                maskType:
                                                    EasyLoadingMaskType.black,
                                              );
                                              await _provider.deleteLoansReques(
                                                  widget.index ?? 0);
                                              EasyLoading.dismiss();
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text("تأكيد",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ).then((value) {
                                if (value == true) {
                                  Alerts.successAlert(context, "", "تم القبول")
                                      .show()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                            child: const Text("رفض"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              String resaon = "";
                              FinancialType = null;
                              ApproveFlag = "R";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 220,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 1,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelText: "سبب الرفض",
                                                    alignLabelWithHint: true,
                                                  ),
                                                  onChanged: (String val) {
                                                    setState(() {});
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 3,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black)),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    labelText: "ملاحظات",
                                                    alignLabelWithHint: true,
                                                  ),
                                                  onChanged: (String val) {
                                                    setState(() {});
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            color: Colors.red,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "إلغاء",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          FlatButton(
                                            color: Colors.green,
                                            onPressed: () {
                                              print(resaon);
                                              if (error != "" || resaon == "") {
                                                setState(() {
                                                  error =
                                                      "الرجاء إختيار سبب الرفض";
                                                });
                                                return;
                                              }
                                              _provider.deleteLoansReques(
                                                  widget.index ?? 0);
                                              Navigator.pop(context, true);
                                            },
                                            child: const Text("تأكيد",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ).then((value) {
                                if (value == true) {
                                  Alerts.successAlert(context, "", "تم الرفض")
                                      .show()
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
