import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
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
  var _ReplaceEmployeeNumber;
  String? selecteditem = null;
  late List<MainDepartmentEmployees> _MainDepartmentEmployees = [];
  TextEditingController _startDate = new TextEditingController();
  TextEditingController _endtDate = new TextEditingController();
  TextEditingController _HoursNumberC = new TextEditingController();

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
    if (Provider.of<EatemadatProvider>(context, listen: false)
            .getHrRequests[widget.index ?? 0]
            .RequestTypeID ==
        3) {
      _ReplaceEmployeeNumber =
          Provider.of<EatemadatProvider>(context, listen: false)
              .getHrRequests[widget.index ?? 0]
              .ReplacementEmployeeNumber
              .toString()
              .split(".")[0];
      getMainDepartmentEmployees();
    }

    if (Provider.of<EatemadatProvider>(context, listen: false)
            .getHrRequests[widget.index ?? 0]
            .RequestTypeID ==
        2) {
      var _provider = Provider.of<EatemadatProvider>(context, listen: false)
          .getHrRequests[widget.index ?? 0];
      _HoursNumberC.text = _provider.OverTimeHours.toString();
      _startDate.text = _provider.StartDateG.split("T")[0];
      _endtDate.text = _provider.EndDateG.split("T")[0];
      setState(() {});
    }
    super.initState();
  }

  Future<void> getMainDepartmentEmployees() async {
    String emNo = Provider.of<EatemadatProvider>(context, listen: false)
        .getHrRequests[widget.index ?? 0]
        .RequesterEmployeeNumber
        .toString()
        .split(".")[0];

    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );

    var respose = await getAction("HR/GetEmployeeReplacments/" + emNo);
    // print(empinfo.MainDepartmentID.toString());
    //print("respose = " + respose.toString());

    try {
      if (jsonDecode(respose.body)["EmployeesList"] != null) {
        _MainDepartmentEmployees =
            (jsonDecode(respose.body)["EmployeesList"] as List)
                .map(((e) => MainDepartmentEmployees.fromJson(e)))
                .toList();

        //print(_MainDepartmentEmployees[0].EmployeeName);
        selecteditem = Provider.of<EatemadatProvider>(context, listen: false)
            .getHrRequests[widget.index ?? 0]
            .ReplacementEmployeeName;
        setState(() {});
        EasyLoading.dismiss();
      }
    } catch (Ex) {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var _provider = Provider.of<EatemadatProvider>(context, listen: false);
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
                                        TextW(_provider
                                                    .getHrRequests[
                                                        widget.index ?? 0]
                                                    .RequestTypeID ==
                                                2
                                            ? "عدد الساعات"
                                            : "عدد الأيام"),
                                        Text(
                                            _provider
                                                        .getHrRequests[
                                                            widget.index ?? 0]
                                                        .RequestTypeID ==
                                                    2
                                                ? _provider
                                                    .getHrRequests[
                                                        widget.index ?? 0]
                                                    .OverTimeHours
                                                    .toString()
                                                : _provider
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
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              if (_provider.getHrRequests[widget.index ?? 0]
                                      .RequestTypeID ==
                                  2)
                                OutofDuties(),
                              if (_provider.getHrRequests[widget.index ?? 0]
                                      .RequestTypeID ==
                                  3)
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownSearch<dynamic>(
                                    popupBackgroundColor: BackGWhiteColor,
                                    key: UniqueKey(),
                                    items: _MainDepartmentEmployees,
                                    popupItemBuilder:
                                        (context, rr, isSelected) => (Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Text(rr.EmployeeName,
                                              style: subtitleTx(baseColorText))
                                        ],
                                      ),
                                    )),
                                    dropdownBuilder: (context, selectedItem) =>
                                        Container(
                                      child: selectedItem == null
                                          ? null
                                          : Text(
                                              selecteditem == null
                                                  ? ""
                                                  : selecteditem ?? "",
                                              style: subtitleTx(baseColorText),
                                            ),
                                    ),
                                    dropdownBuilderSupportsNullItem: true,
                                    selectedItem: selecteditem == null
                                        ? null
                                        : selecteditem,
                                    showSelectedItems: false,
                                    mode: Mode.BOTTOM_SHEET,
                                    showClearButton:
                                        _ReplaceEmployeeNumber == null
                                            ? false
                                            : true,
                                    maxHeight: 400,
                                    showAsSuffixIcons: true,
                                    itemAsString: (item) =>
                                        item?.EmployeeName ?? "",
                                    dropdownSearchDecoration: InputDecoration(
                                      // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                      labelText: "الموظف البديل",
                                      labelStyle:
                                          TextStyle(color: secondryColorText),

                                      border: OutlineInputBorder(),

                                      errorStyle: TextStyle(color: redColor),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: responsiveMT(8, 30),
                                          horizontal: 10.0),
                                    ),
                                    showSearchBox: true,
                                    onChanged: (v) {
                                      try {
                                        _ReplaceEmployeeNumber =
                                            v?.EmployeeNumber;

                                        print(v?.EmployeeNumber.toString());
                                        selecteditem = v.EmployeeName;
                                        //setState(() {});
                                      } catch (e) {}
                                    },
                                    popupTitle: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: secondryColor,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "الموظف البديل",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    popupShape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: DropdownSearch<String>(
                                  items: _provider.resonsSrtings,
                                  maxHeight: 300,
                                  key: key,
                                  mode: Mode.BOTTOM_SHEET,
                                  showClearButton: true,
                                  showAsSuffixIcons: true,
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "سبب الرفض",
                                    errorText: isValied == true
                                        ? null
                                        : "الرجاء إختيار السبب",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
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
                                  popupShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: bordercolor)),
                                  filled: true,
                                  fillColor: BackGWhiteColor,
                                  labelText: "ملاحظات",
                                  alignLabelWithHint: true,
                                ),
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
                                              dynamic bool = true;

                                              bool =
                                                  await _provider.deleteEtmad(
                                                      widget.index ?? 0,
                                                      false,
                                                      resondID,
                                                      _ReplaceEmployeeNumber,
                                                      _provider
                                                          .getHrRequests[
                                                              widget.index ?? 0]
                                                          .RequestTypeID);

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
                                        dynamic bool = true;
                                        if (_provider
                                                .getHrRequests[
                                                    widget.index ?? 0]
                                                .RequestTypeID ==
                                            2) {
                                          bool = await _provider
                                              .UpdateOutDutyRequest(jsonEncode({
                                            "OutDutyHours": double.parse(
                                                _HoursNumberC.text),
                                            "StartDate": _startDate.text,
                                            "EndDate": _endtDate.text,
                                            "UpdatedBy": sharedPref
                                                .getDouble("EmployeeNumber")
                                                .toString()
                                                .split(".")[0],
                                            "RequestNumber": _provider
                                                .getHrRequests[
                                                    widget.index ?? 0]
                                                .RequestNumber
                                          }));
                                        }
                                        if (bool == true) {
                                          bool = await _provider.deleteEtmad(
                                              widget.index ?? 0,
                                              true,
                                              resondID,
                                              _ReplaceEmployeeNumber,
                                              _provider
                                                  .getHrRequests[
                                                      widget.index ?? 0]
                                                  .RequestTypeID);
                                        }
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

  Widget OutofDuties() {
    return Column(
      children: [
        Container(
          decoration: containerdecoration(BackGWhiteColor),
          child: SpinBox(
            max: 7,
            min: 0.5,
            value: double.parse(_HoursNumberC.text),
            decimals: 1,
            readOnly: true,
            step: 0.5,
            decoration: InputDecoration(
              labelText: 'ادخل عدد الساعات',
            ),
            textStyle: subtitleTx(secondryColorText),
            incrementIcon: Icon(
              Icons.add_box_outlined,
              size: 30,
              color: baseColor,
            ),
            decrementIcon: Icon(
              Icons.indeterminate_check_box_outlined,
              size: 30,
              color: baseColor,
            ),
            onChanged: (value) {
              _HoursNumberC.text = value.toString();
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: _startDate,
          readOnly: true,
          maxLines: 1,
          decoration: formlabel1("تاريخ البداية"),
          onTap: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2020, 3, 5), onChanged: (date) {
              print('change $date');
            }, onConfirm: (date) {
              _startDate.text = date.toString().split(" ")[0];
              setState(() {});
              print('confirm $date');
            }, currentTime: DateTime.now(), locale: LocaleType.ar);
          },
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          //   controller: _date,
          readOnly: true,
          controller: _endtDate, // keyboardType: TextInputType.datetime,
          maxLines: 1,
          decoration: formlabel1("تاريخ النهاية"),

          onTap: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2020, 3, 5), onChanged: (date) {
              print('change $date');
            }, onConfirm: (date) {
              _endtDate.text = date.toString().split(" ")[0];
              setState(() {});
              print('confirm $date');
            }, currentTime: DateTime.now(), locale: LocaleType.ar);
          },
        ),
      ],
    );
  }
}
