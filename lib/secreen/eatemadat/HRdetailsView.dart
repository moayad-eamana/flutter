import 'package:eamanaapp/provider/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HRdetailsView extends StatefulWidget {
  int? index;
  HRdetailsView({this.index});

  @override
  _HRdetailsViewState createState() => _HRdetailsViewState();
}

class _HRdetailsViewState extends State<HRdetailsView> {
  double width = 0.0;
  String resondID = "";
  final key = GlobalKey();
  bool isValied = true;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (Provider.of<EatemadatProvider>(context, listen: false)
              .resonsSrtings
              .length ==
          0) {
        EasyLoading.show(
          status: 'جاري المعالجة...',
          maskType: EasyLoadingMaskType.black,
        );
        await Provider.of<EatemadatProvider>(context, listen: false)
            .fetchRejectReasonNames();
        EasyLoading.dismiss();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var _provider = Provider.of<EatemadatProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("تفاصيل الطلب", context),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/SVGs/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    employeeName(_provider),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextW("نوع الطلب"),
                                      Text(
                                        _provider
                                            .getHrRequests[widget.index ?? 0]
                                            .RequestType,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextW("عدد الساعات"),
                                      Text(
                                          _provider
                                              .getHrRequests[widget.index ?? 0]
                                              .Days
                                              .toString()
                                              .split(".")[0],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 90,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextW("البداية"),
                                      Text(
                                          _provider
                                              .getHrRequests[widget.index ?? 0]
                                              .StartDateG
                                              .split("T")[0],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextW("النهاية"),
                                      Text(
                                          _provider
                                              .getHrRequests[widget.index ?? 0]
                                              .EndDateG
                                              .split("T")[0],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 200,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: DropdownSearch<String>(
                                            items: _provider.resonsSrtings,
                                            maxHeight: 300,
                                            key: key,
                                            mode: Mode.BOTTOM_SHEET,
                                            showClearButton: true,
                                            showAsSuffixIcons: true,
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "سبب الرفض",
                                              errorText: isValied == true
                                                  ? null
                                                  : "الرجاء إختيار السبب",
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      12, 12, 0, 0),
                                              border: OutlineInputBorder(),
                                            ),
                                            showSearchBox: true,
                                            onChanged: (String? v) {
                                              setState(() {
                                                resondID = v ?? "";
                                                if (resondID != "") {
                                                  isValied = true;
                                                }
                                              });
                                            },
                                            popupTitle: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'سبب الرفض',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            popupShape:
                                                const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24),
                                                topRight: Radius.circular(24),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Expanded(
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black)),
                                                filled: true,
                                                fillColor: Colors.white,
                                                labelText: "ملاحظات",
                                                alignLabelWithHint: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red, // background
                                      onPrimary: Colors.white, // foreground
                                    ),
                                    onPressed: () {
                                      if (resondID == "") {
                                        setState(() {
                                          isValied = false;
                                        });

                                        return;
                                      } else {
                                        setState(() {
                                          isValied = true;
                                        });
                                      }
                                      bool reject = false;
                                      Alert(
                                        context: context,
                                        type: AlertType.warning,
                                        title: "",
                                        desc: "تأكيد رفض الطلب",
                                        buttons: [
                                          DialogButton(
                                            child: const Text(
                                              "رفض",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              _provider.deleteEtmad(
                                                  widget.index ?? 0,
                                                  false,
                                                  resondID);

                                              reject = true;
                                              Navigator.pop(context);
                                            },
                                            width: 120,
                                          ),
                                          DialogButton(
                                            child: const Text(
                                              "إلغاء",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                      ).show().then((value) {
                                        if (reject) {
                                          Alert(
                                            context: context,
                                            type: AlertType.warning,
                                            title: "",
                                            desc: "تم رفض الطلب",
                                            buttons: [
                                              DialogButton(
                                                child: const Text(
                                                  "حسنا",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                width: 120,
                                              ),
                                            ],
                                          ).show().then((value) {
                                            Navigator.pop(context);
                                          });
                                        }
                                      });
                                    },
                                    child: const Text('رفض'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {
                                  bool reject = false;
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "",
                                    desc: "تأكيد قبول الطلب",
                                    buttons: [
                                      DialogButton(
                                        child: const Text(
                                          "قبول",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () async {
                                          await _provider.deleteEtmad(
                                              widget.index ?? 0,
                                              true,
                                              resondID);

                                          reject = true;
                                          Navigator.pop(context);
                                        },
                                        width: 120,
                                      ),
                                      DialogButton(
                                        child: const Text(
                                          "إلغاء",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show().then((value) {
                                    if (reject) {
                                      Alert(
                                        context: context,
                                        type: AlertType.warning,
                                        title: "",
                                        desc: "تم قبول الطلب بنجاح",
                                        buttons: [
                                          DialogButton(
                                            child: const Text(
                                              "حسنا",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            width: 120,
                                          ),
                                        ],
                                      ).show().then((value) {
                                        Navigator.pop(context);
                                      });
                                    }
                                  });
                                },
                                child: Text("قبول"),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget employeeName(_provider) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 90,
      child: Card(
        elevation: 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _provider.getHrRequests[widget.index ?? 0].RequesterName,
                  style: TextStyle(
                      color: baseColor,
                      fontFamily: ("Cairo"),
                      fontWeight: FontWeight.bold,
                      fontSize: width >= 768.0 ? 22 : 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextW("الرقم الوظيفي : " +
                    _provider.getHrRequests[widget.index ?? 0]
                        .RequesterEmployeeNumber
                        .toString()
                        .split(".")[0]),
                TextW("رقم الطلب : " +
                    _provider.getHrRequests[widget.index ?? 0].RequestNumber
                        .toString()
                        .split(".")[0])
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget TextW(String txt) {
    double width = MediaQuery.of(context).size.width;

    return Text(
      txt,
      style: TextStyle(fontFamily: "Cairo", fontSize: width >= 768.0 ? 18 : 14),
    );
  }
}
