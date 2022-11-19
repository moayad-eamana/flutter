import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class Entedab extends StatefulWidget {
  const Entedab({Key? key}) : super(key: key);

  @override
  _EntedabState createState() => _EntedabState();
}

class _EntedabState extends State<Entedab> {
  TextEditingController _date = TextEditingController();
  TextEditingController _dayNumber = TextEditingController();
  TextEditingController _Note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<MandateLocations> mandateLocations = [];
  DropdownSearchW drop1 = new DropdownSearchW();
  double locationId = 0;
  String MandateTypeID = "";
  String? selecteditem = null;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarW.appBarW("طلب إنتداب", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                //color: Colors.amber,
                decoration: BoxDecoration(
                    color: BackGWhiteColor,
                    border: Border.all(color: bordercolor),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "فضلا أدخل بيانات طلب الانتداب",
                        style: subtitleTx(secondryColorText),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: StaggeredGrid.count(
                            crossAxisCount: responsiveGrid(1, 2),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: baseColorText),
                                readOnly: true,
                                maxLines: 1,
                                controller: _date,
                                decoration: formlabel1("تاريخ الانتداب"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "الرجاء إختيار التاريخ";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      theme: DatePickerTheme(
                                        backgroundColor: BackGWhiteColor,
                                        itemStyle: TextStyle(
                                          color: baseColorText,
                                        ),
                                      ),
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    //  print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      _date.text =
                                          date.toString().split(" ")[0];
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: baseColorText),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                controller: _dayNumber,
                                decoration: formlabel1("عدد الايام"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "الرجاء إدخال عدد الايام";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              EntedabTypes(),
                              mandateLocations.length == 0
                                  ? location()
                                  : location(),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                style: TextStyle(color: baseColorText),
                                controller: _Note,
                                decoration: formlabel1("ملاحظات"),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widgetsUni.actionbutton(
                            'الطلبات السابقة',
                            Icons.history,
                            () {
                              Navigator.pushNamed(context, "/Mandates_history");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          widgetsUni.actionbutton(
                            'تنفيذ',
                            Icons.send,
                            () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                Alerts.confirmAlrt(
                                        context, "", "هل أنت متأكد", "نعم")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    double emNo = await EmployeeProfile
                                        .getEmployeeNumberasDouble();
                                    int DepartmentID =
                                        await EmployeeProfile.getDepartmentID();
                                    // print(double.parse(
                                    //     DepartmentID.toStringAsFixed(1)));
                                    // print({
                                    //   "EmployeeNumber": emNo,
                                    //   "MandateTypeID": MandateTypeID,
                                    //   "MandateDays": int.parse(_dayNumber.text),
                                    //   "StartDate": _date.text,
                                    //   "EndDate": "",
                                    //   "MandateLocationID": locationId,
                                    //   "DepartmentID": double.parse(
                                    //       DepartmentID.toStringAsFixed(1)),
                                    //   "Notes": _Note.text
                                    // });
                                    EasyLoading.show(
                                      status: '... جاري المعالجة',
                                      maskType: EasyLoadingMaskType.black,
                                    );
                                    var response = await postAction(
                                        "HR/InsertMandateRequest",
                                        jsonEncode({
                                          "EmployeeNumber": emNo,
                                          "MandateTypeID": MandateTypeID,
                                          "MandateDays":
                                              int.parse(_dayNumber.text),
                                          "StartDate": _date.text,
                                          "EndDate": "",
                                          "MandateLocationID": int.parse(
                                              locationId
                                                  .toString()
                                                  .split(".")[0]),
                                          "DepartmentID": double.parse(
                                              DepartmentID.toStringAsFixed(1)),
                                          "Notes": _Note.text
                                        }));
                                    EasyLoading.dismiss();
                                    if (jsonDecode(
                                            response.body)["StatusCode"] !=
                                        400) {
                                      Alerts.errorAlert(
                                              context,
                                              "خطأ",
                                              jsonDecode(response.body)[
                                                  "ErrorMessage"])
                                          .show();
                                      return;
                                    } else {
                                      Alerts.successAlert(
                                              context, "", "تمت الاضافة بنجاح")
                                          .show();
                                    }
                                    // print(response);
                                  }
                                });

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //       content: Text('Processing Data')),
                                // );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget EntedabTypes() {
    return DropdownSearch<dynamic>(
      popupBackgroundColor: BackGWhiteColor,
      items: [
        {"typeId": "1", "name": "داخلي"},
        {"typeId": "2", "name": "خارجي"}
      ],
      popupItemBuilder: (context, rr, isSelected) => (Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(rr["name"].toString(), style: subtitleTx(baseColorText))
          ],
        ),
      )),

      showSelectedItems: false,
      mode: Mode.BOTTOM_SHEET,
      showClearButton: MandateTypeID == "" ? false : true,
      maxHeight: 400,
      showAsSuffixIcons: true,
      itemAsString: (item) => item["name"],
      // showSelectedItems: true,
      dropdownSearchDecoration: formlabel1("نوع الانتداب"),
      //added in last update
      dropdownBuilder: (context, selectedItem) => Container(
        decoration: null,
        child: selectedItem == null
            ? null
            : Text(
                selectedItem['name'] == null ? "" : selectedItem['name'] ?? "",
                style: TextStyle(fontSize: 16, color: baseColorText)),
      ),
      dropdownBuilderSupportsNullItem: true,
      //  InputDecoration(
      //   hintText: "نوع الانتداب",
      //   helperStyle: TextStyle(color: Colors.amber),
      //   contentPadding: EdgeInsets.symmetric(
      //       vertical: responsiveMT(10, 30), horizontal: responsiveMT(10, 20)),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4.0),
      //     borderSide: BorderSide(color: bordercolor),
      //   ),
      // ),
      validator: (value) {
        if (value == "" || value == null) {
          return "الرجاء إدخال نوع الانتداب";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (v) async {
        setState(() {
          selecteditem = null;

          locationId = 0;
          mandateLocations = [];
        });

        //
        if (sharedPref.getString("dumyuser") != "10284928492") {
          String emNo = await EmployeeProfile.getEmployeeNumber();
          try {
            MandateTypeID = v["typeId"].toString();
            EasyLoading.show(
              status: '... جاري المعالجة',
              maskType: EasyLoadingMaskType.black,
            );
            var respose = await getAction("HR/GetMandateLocationListByTypeId/" +
                v["typeId"].toString() +
                "/" +
                emNo);
            EasyLoading.dismiss();
            setState(() {
              mandateLocations =
                  (jsonDecode(respose.body)["MandateLocationsList"] as List)
                      .map(((e) => MandateLocations.fromJson(e)))
                      .toList();
            });
            //     print(mandateLocations);
          } catch (e) {}
        } else {
          mandateLocations = [
            {"MandateLocationID": 1.1, "MandateLocationName": "السعودية"}
          ].map(((e) => MandateLocations.fromJson(e))).toList();
          setState(() {});
        }

        //value = v ?? "";
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
            "نوع الانتداب",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: baseColorText,
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
    );
  }

//push
  Widget location() {
    return DropdownSearch<dynamic>(
      popupBackgroundColor: BackGWhiteColor,
      key: UniqueKey(),

      items: mandateLocations,
      itemAsString: (item) => item.MandateLocationName,
      popupItemBuilder: (context, rr, isSelected) => (Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text(rr.MandateLocationName, style: subtitleTx(baseColorText))
          ],
        ),
      )),
      dropdownBuilder: (context, selectedItem) => Container(
        child: selectedItem == null
            ? null
            : Text(
                selecteditem == null ? "" : selecteditem ?? "",
                style: TextStyle(fontSize: 16, color: baseColorText),
              ),
      ),
      selectedItem: selecteditem == null ? null : selecteditem,

      dropdownBuilderSupportsNullItem: true,
      //  showSelectedItems: true,
      mode: Mode.BOTTOM_SHEET,
      showClearButton: locationId == 0 || locationId == 0.0 ? false : true,
      maxHeight: 400,
      showAsSuffixIcons: true,

      // showSelectedItems: true,
      dropdownSearchDecoration: formlabel1("جهة الانتداب"),
      // InputDecoration(
      //   hintText: "جهة الانتداب",
      //   helperStyle: TextStyle(color: Colors.amber),
      //   contentPadding: EdgeInsets.symmetric(
      //       vertical: responsiveMT(10, 30), horizontal: responsiveMT(10, 20)),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(4.0),
      //     borderSide: BorderSide(color: bordercolor),
      //   ),
      // ),
      validator: (value) {
        if (value == "" || value == null) {
          return "الرجاء إدخال جهة الانتداب";
        } else {
          return null;
        }
      },

      showSearchBox: true,
      onChanged: (v) async {
        //   print('object');
        //  print(v.MandateLocationID);
        if (v != null) {
          locationId = v.MandateLocationID;

          selecteditem = v.MandateLocationName;
        } else {
          selecteditem = null;
        }

        //   print(locationId);

        //value = v ?? "";
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
            "جهة الانتداب",
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
    );
  }
}

class MandateLocations {
  double MandateLocationID;
  String MandateLocationName;

  MandateLocations(this.MandateLocationID, this.MandateLocationName);

  factory MandateLocations.fromJson(dynamic json) {
    return MandateLocations(
      json["MandateLocationID"],
      json["MandateLocationName"],
    );
  }
}
