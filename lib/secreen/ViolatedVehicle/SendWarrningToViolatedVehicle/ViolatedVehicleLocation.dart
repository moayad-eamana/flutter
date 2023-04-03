import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'WarnViolatedVehiclePageView.dart';

class ViolatedVehicleLocation extends StatefulWidget {
  ViolatedVehicleLocation(
      {required this.violatedVehicle,
      required this.nextPage,
      required this.backPage,
      Key? key})
      : super(key: key);
  ViolatedVehicle violatedVehicle;
  Function nextPage;
  Function backPage;

  @override
  State<ViolatedVehicleLocation> createState() =>
      _ViolatedVehicleLocationState();
}

class _ViolatedVehicleLocationState extends State<ViolatedVehicleLocation>
    with AutomaticKeepAliveClientMixin {
  final _formKey1 = GlobalKey<FormState>();

  List municipalities = [];
  List neighborhood = [];
  TextEditingController _streetname = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getbaladyat();
    super.initState();
  }

  void getbaladyat() async {
    if (widget.violatedVehicle.MuniciplaityInfo.length == 0) {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      var respose = await getAction("ViolatedCars/GetActiveMunicipalities");
      print(respose.body);
      setState(() {
        municipalities = jsonDecode(respose.body)["Items"];
      });
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  children: [
                    Form(
                      key: _formKey1,
                      child: Container(
                        child: Column(
                          children: [
                            DropdownSearch<dynamic>(
                              items: municipalities,
                              popupBackgroundColor: BackGWhiteColor,
                              popupItemBuilder: (context, rr, isSelected) =>
                                  (Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text(rr["MunicipalityName"].toString(),
                                        style: subtitleTx(baseColorText))
                                  ],
                                ),
                              )),
                              dropdownBuilder: (context, selectedItem) =>
                                  Container(
                                decoration: null,
                                child: selectedItem == null
                                    ? null
                                    : Text(
                                        selectedItem == null
                                            ? ""
                                            : selectedItem[
                                                    "MunicipalityName"] ??
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
                                  formlabel1("اختر البلدية"),
                              validator: (value) {
                                if (value == "" || value == null) {
                                  return "يرجى اختيار البلدية";
                                } else {
                                  return null;
                                }
                              },
                              showSearchBox: true,
                              onChanged: (v) {
                                try {
                                  setState(() {
                                    print(v);
                                    widget.violatedVehicle.MuniciplaityInfo[
                                            "MunicipalityName"] =
                                        v["MunicipalityName"].toString();
                                    widget.violatedVehicle.MuniciplaityInfo[
                                            "MuniciplaityCode"] =
                                        v["MuniciplaityCode"];
                                    print(widget
                                        .violatedVehicle.MuniciplaityInfo);
                                  });
                                } catch (e) {
                                  print(e);
                                }
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
                                    "اختر البلدية",
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
                              emptyBuilder: (context, searchEntry) => Center(
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
                            DropdownSearch<dynamic>(
                              items: null,
                              popupBackgroundColor: BackGWhiteColor,
                              popupItemBuilder: (context, rr, isSelected) =>
                                  (Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text(rr["type"].toString(),
                                        style: subtitleTx(baseColorText))
                                  ],
                                ),
                              )),
                              dropdownBuilder: (context, selectedItem) =>
                                  Container(
                                decoration: null,
                                child: selectedItem == null
                                    ? null
                                    : Text(
                                        selectedItem == null
                                            ? ""
                                            : selectedItem["type"] ?? "",
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
                              dropdownSearchDecoration: formlabel1("اختر الحي"),
                              validator: (value) {
                                if (value == "" || value == null) {
                                  return "يرجى اختيار الحي";
                                } else {
                                  return null;
                                }
                              },
                              showSearchBox: true,
                              onChanged: (v) {
                                try {
                                  setState(() {
                                    print(v);
                                    // _registrationType = v["type"];
                                    // _registrationCode = v["code"];
                                  });
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
                                    "اختر الحي",
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
                              emptyBuilder: (context, searchEntry) => Center(
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
                              controller: _streetname,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              style: TextStyle(color: baseColorText),
                              decoration: formlabel1("اسم الشارع"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "الرجاء إدخال اسم الشارع";
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _note,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              style: TextStyle(color: baseColorText),
                              decoration: formlabel1("ملاحظات"),
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "الرجاء إدخال ملاحظات";
                              //   }
                              // },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widgetsUni
                                    .actionbutton('رجوع', Icons.arrow_back, () {
                                  widget.backPage();
                                }),
                                widgetsUni.actionbutton(
                                    'التالي', Icons.arrow_forward, () async {
                                  if (!_formKey1.currentState!.validate()) {
                                    return;
                                  } else {
                                    // widget.nextPage();
                                    setState(() {
                                      widget.violatedVehicle
                                              .sendwarning["MuniciplaityID"] =
                                          widget.violatedVehicle
                                                  .MuniciplaityInfo[
                                              "MuniciplaityCode"];
                                      widget.violatedVehicle
                                          .sendwarning["DistrictID"] = "";
                                      widget.violatedVehicle
                                              .sendwarning["StreetName"] =
                                          _streetname.text;
                                      print(widget.violatedVehicle.sendwarning);
                                    });
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
