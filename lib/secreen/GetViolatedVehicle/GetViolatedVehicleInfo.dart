import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GetViolationVehicleInfo extends StatefulWidget {
  const GetViolationVehicleInfo({Key? key}) : super(key: key);

  @override
  State<GetViolationVehicleInfo> createState() =>
      _GetViolationVehicleInfoState();
}

class _GetViolationVehicleInfoState extends State<GetViolationVehicleInfo> {
  dynamic groupValue = 1;
  TextEditingController _platenumber = TextEditingController();
  TextEditingController _plateText = TextEditingController();
  TextEditingController _VehicleIDNumber = TextEditingController();
  dynamic resulte;
  String _registrationType = "";
  int _registrationCode = 0;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  List registrationType = [
    {"type": "خاص", "code": 1},
    {"type": "نقل عام", "code": 2},
    {"type": "نقل خاص", "code": 3},
    {"type": "حافلة صغيرة عامة", "code": 4},
    {"type": "حافلة صغيرة خاصة", "code": 5},
    {"type": "أجرة", "code": 6},
    {"type": "أشغال عامة", "code": 7},
    {"type": "تصدير", "code": 8},
    {"type": "دبلوماسي", "code": 9},
    {"type": "دراجة آلية", "code": 10},
    {"type": "مؤقت", "code": 11},
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBarW.appBarW("إستعلام عن مخالفة السيارة", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: BackGWhiteColor,
                        border: Border.all(
                          color: bordercolor,
                        ),
                        //color: baseColor,
                        borderRadius: BorderRadius.all(
                          new Radius.circular(4),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: ListTile(
                                    title: Text(
                                      "رقم اللوحة",
                                      style: descTx1(baseColorText),
                                    ),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value;
                                          print(groupValue);
                                        });
                                      },
                                      activeColor: baseColor,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListTile(
                                    title: Text(
                                      "رقم الهيكل",
                                      style: descTx1(baseColorText),
                                    ),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        setState(() {
                                          groupValue = value;
                                          print(groupValue);
                                        });
                                      },
                                      activeColor: baseColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (groupValue == 1)
                              Form(
                                key: _formKey1,
                                child: Container(
                                  child: Column(
                                    children: [
                                      DropdownSearch<dynamic>(
                                        items: registrationType,
                                        popupBackgroundColor: BackGWhiteColor,
                                        popupItemBuilder:
                                            (context, rr, isSelected) =>
                                                (Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              Text(rr["type"].toString(),
                                                  style:
                                                      subtitleTx(baseColorText))
                                            ],
                                          ),
                                        )),
                                        dropdownBuilder:
                                            (context, selectedItem) =>
                                                Container(
                                          decoration: null,
                                          child: selectedItem == null
                                              ? null
                                              : Text(
                                                  selectedItem == null
                                                      ? ""
                                                      : selectedItem["type"] ??
                                                          "",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: baseColorText)),
                                        ),
                                        dropdownBuilderSupportsNullItem: true,
                                        mode: Mode.BOTTOM_SHEET,
                                        // showClearButton:
                                        //     _VacationTypeID == null ? false : true,
                                        maxHeight: 400,
                                        showAsSuffixIcons: true,
                                        dropdownSearchDecoration:
                                            formlabel1("اختر النوع"),
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            return "يرجى اختيار النوع";
                                          } else {
                                            return null;
                                          }
                                        },
                                        showSearchBox: true,
                                        onChanged: (v) {
                                          try {
                                            setState(() {
                                              print(v);
                                              _registrationType = v["type"];
                                              _registrationCode = v["code"];
                                            });
                                            print('object');
                                            print(v["code"]);
                                            // value = v;
                                            //value = v ?? "";
                                          } catch (e) {}
                                        },
                                        popupTitle: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: secondryColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "اختر النوع",
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
                                        emptyBuilder: (context, searchEntry) =>
                                            Center(
                                          child: Text(
                                            "لا يوجد بيانات",
                                            style: TextStyle(
                                              color: baseColorText,
                                            ),
                                          ),
                                        ),
                                        searchFieldProps: TextFieldProps(
                                          textAlign: TextAlign.right,
                                          decoration: formlabel1(""),
                                          style: TextStyle(
                                            color: baseColorText,
                                          ),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        clearButton: Icon(
                                          Icons.clear,
                                          color: baseColor,
                                        ),
                                        dropDownButton: Icon(
                                          Icons.arrow_drop_down,
                                          color: baseColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _platenumber,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        style: TextStyle(color: baseColorText),
                                        decoration: formlabel1("رقم اللوحة"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "الرجاء إدخال رقم اللوحة";
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                          controller: _plateText,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style:
                                              TextStyle(color: baseColorText),
                                          decoration: formlabel1("الحروف"),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "الرجاء إدخال حروف اللوحة";
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            if (groupValue == 2)
                              Container(
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKey2,
                                      child: TextFormField(
                                        controller: _VehicleIDNumber,
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        style: TextStyle(color: baseColorText),
                                        decoration: formlabel1("رقم الهيكل"),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "الرجاء إدخال رقم الهيكل";
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                widgetsUni.actionbutton('إستعلام', Icons.send,
                                    () async {
                                  print(groupValue);
                                  if (groupValue == 2) {
                                    if (!_formKey2.currentState!.validate()) {
                                      return;
                                    }
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    var respons = await getAction(
                                        "NIC/GetViolatedVehicleInfoByVehicleIDNumber?VehicleIDNumber=" +
                                            _VehicleIDNumber.text);
                                    if (jsonDecode(
                                            respons.body)["StatusCode"] ==
                                        400) {
                                      resulte = jsonDecode(respons.body)[
                                                  "ResponseData"]["data"]
                                              ["GetViolatedVehicleInfoResponse"]
                                          ["GetViolatedVehicleInfoResult"];
                                      print(resulte);
                                      EasyLoading.dismiss();
                                      setState(() {});
                                    } else {
                                      Alerts.warningAlert(context, "تنبيه",
                                              "لا يوجد بيانات")
                                          .show();
                                      EasyLoading.dismiss();
                                    }
                                  } else {
                                    if (!_formKey1.currentState!.validate()) {
                                      return;
                                    }
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    List platechar =
                                        _plateText.text.trim().split(" ");
                                    print(platechar);

                                    var respons = await getAction(
                                        "NIC/GetViolatedVehicleInfoByPlatNumber?text1=${platechar[0]}&text2=${platechar[1]}&text3=${platechar[2]}&plateNumber=${_platenumber.text}&registrationTypeID=${_registrationCode}");
                                    if (jsonDecode(
                                            respons.body)["StatusCode"] ==
                                        400) {
                                      resulte = jsonDecode(respons.body)[
                                                  "ResponseData"]["data"]
                                              ["GetViolatedVehicleInfoResponse"]
                                          ["GetViolatedVehicleInfoResult"];

                                      print(resulte);
                                      EasyLoading.dismiss();
                                      setState(() {});
                                    } else {
                                      Alerts.warningAlert(context, "تنبيه",
                                              "لا يوجد بيانات")
                                          .show();
                                      EasyLoading.dismiss();
                                    }
                                  }
                                }),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  if (resulte != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            cards(
                                "هوية المالك", resulte["PersonID"].toString()),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            cards("السيارة", resulte["MakeDescAr"]),
                            cards("نوع السيارة", resulte["ModelDescAr"])
                          ],
                        ),
                        Row(
                          children: [
                            cards("موديل السيارة",
                                resulte["ModelYear"].toString()),
                            cards(
                                "الحالة",
                                resulte["IsAlive"] == 1
                                    ? "على قيد الحياة"
                                    : "متوفى"),
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cards(String title, String desc) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Card(
            child: Container(
          decoration: containerdecoration(BackGWhiteColor),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: subtitleTx(secondryColorText),
              ),
              Text(desc, style: subtitleTx(baseColorText)),
            ],
          ),
        )),
      ),
    );
  }
}
