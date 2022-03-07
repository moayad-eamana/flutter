import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sizer/sizer.dart';

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
        appBar: AppBarW.appBarW("تفاصيل الطلب", context, null),
        body: Container(
          height: 100.h,
          child: Stack(
            children: [
              Image.asset(
                imageBG,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Container(
                color: BackGWhiteColor,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                                color: BackGWhiteColor,
                                elevation: 1,
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
                                          style: TextStyle(
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
                                                .getHrRequests[
                                                    widget.index ?? 0]
                                                .Days
                                                .toString()
                                                .split(".")[0],
                                            style: TextStyle(
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
                                color: BackGWhiteColor,
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
                                                .getHrRequests[
                                                    widget.index ?? 0]
                                                .StartDateG
                                                .split("T")[0],
                                            style: TextStyle(
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
                                                .getHrRequests[
                                                    widget.index ?? 0]
                                                .EndDateG
                                                .split("T")[0],
                                            style: TextStyle(
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
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1,
                        color: BackGWhiteColor,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 50),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    EdgeInsets.fromLTRB(
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
                                                  color: secondryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'سبب الرفض',
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
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(24),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLines: 3,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: bordercolor)),
                                                  filled: true,
                                                  fillColor: BackGWhiteColor,
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
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: redColor, // background
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

                                        Alerts.confirmAlrt(context, "",
                                                "تأكيد رفض الطلب", "رفض")
                                            .show()
                                            .then((val) async {
                                          if (val == true) {
                                            EasyLoading.show(
                                              status: 'جاري المعالجة...',
                                              maskType:
                                                  EasyLoadingMaskType.black,
                                            );
                                            var bool =
                                                await _provider.deleteEtmad(
                                                    widget.index ?? 0,
                                                    false,
                                                    resondID);
                                            EasyLoading.dismiss();
                                            if (bool == true) {
                                              Alerts.successAlert(context, "",
                                                      "تم رفض الطلب")
                                                  .show()
                                                  .then((value) {
                                                // to exit from secreen after clicking حسنا btn
                                                //remova page from secreen
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              Alerts.errorAlert(
                                                      context, "", bool)
                                                  .show();
                                            }
                                          }
                                        });
                                      },
                                      child: Text('رفض'),
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
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: baseColor, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () {
                                    Alerts.confirmAlrt(context, "",
                                            "تأكيد قبول الطلب", "قبول")
                                        .show()
                                        .then((val) async {
                                      if (val == true) {
                                        EasyLoading.show(
                                          status: 'جاري المعالجة...',
                                          maskType: EasyLoadingMaskType.black,
                                        );
                                        var bool = await _provider.deleteEtmad(
                                            widget.index ?? 0, true, resondID);
                                        EasyLoading.dismiss();
                                        if (bool == true) {
                                          Alerts.successAlert(
                                                  context, "", "تم القبول ")
                                              .show()
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          Alerts.errorAlert(context, "", bool)
                                              .show();
                                        }
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
      ),
    );
  }

  Widget employeeName(_provider) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 90,
      child: Card(
        elevation: 1,
        color: BackGWhiteColor,
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
