import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/settings.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class VacationRequest extends StatefulWidget {
  const VacationRequest({Key? key}) : super(key: key);

  @override
  State<VacationRequest> createState() => _VacationRequestState();
}

class _VacationRequestState extends State<VacationRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _date = TextEditingController();
  TextEditingController _daysNumber = TextEditingController();
  TextEditingController _note = TextEditingController();
  // TextEditingController _date = TextEditingController();
  var _ReplaceEmployeeNumber;
  var _VacationTypeID;
  var _SignatureApproval;

  DropdownSearchW drop1 = new DropdownSearchW();
  EmployeeProfile empinfo = new EmployeeProfile();

  late List<MainDepartmentEmployees> _MainDepartmentEmployees = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => getMainDepartmentEmployees());
  }

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
  }

  Future<void> getMainDepartmentEmployees() async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    await getuserinfo();
    var respose = await getAction(
        "HR/GetMainDepartmentEmployees/" + empinfo.MainDepartmentID.toString());
    // print(empinfo.MainDepartmentID.toString());
    //print("respose = " + respose.toString());
    try {
      if (jsonDecode(respose.body)["EmployeesList"] != null) {
        _MainDepartmentEmployees =
            (jsonDecode(respose.body)["EmployeesList"] as List)
                .map(((e) => MainDepartmentEmployees.fromJson(e)))
                .toList();

        ///print(_MainDepartmentEmployees[0].EmployeeName);
        setState(() {});
        EasyLoading.dismiss();
      }
    } catch (Ex) {}
  }

  Future<void> InsertVacationRequest() async {
//rtyrtyer
    Map data = {
      "EmployeeNumber": empinfo.EmployeeNumber,
      "ReplaceEmployeeNumber": _ReplaceEmployeeNumber,
      "VacationDays": int.parse(_daysNumber.text),
      "VacationTypeID": int.parse(_VacationTypeID.toString().split(".")[0]),
      "StartDate": _date.text,
      //"2022-02-23T13:05:22.2919384+03:00",
      "Notes": _note.text.toString(),
      "SignatureApprovalFlag": _SignatureApproval,
    };
    print(data);
    //encode Map to JSON

    var body = json.encode(data);

    Alerts.confirmAlrt(context, "تأكيد", "هل انت متأكد؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: 'جاري إرسال الطلب...',
          maskType: EasyLoadingMaskType.black,
        );

        var respose = await postAction("HR/InsertVacationRequest/", body);
        print(jsonDecode(respose.body));
        if (jsonDecode(respose.body)["StatusCode"] != 400) {
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(respose.body)["ErrorMessage"])
              .show();
        } else {
          Alerts.successAlert(context, "تم النجاح", "تم ارسال الطلب").show();
        }

        EasyLoading.dismiss();
      }
    });
  }

  List<Map<dynamic, dynamic>> vacationTypes = [
    {"VacationTypeName": "إجازة اعتيادية", "VacationID": 116.0},
    {"VacationTypeName": "إجازة اضطرارية", "VacationID": 122.0},
    {"VacationTypeName": "تمديد إجازة اعتيادية", "VacationID": 124.0},
  ];

  List<Map<dynamic, dynamic>> _SignatureApprovalFlag = [
    {"Flag": "نعم", "SignatureApprovalFlag": true},
    {"Flag": "لا", "SignatureApprovalFlag": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("طلب إجازة", context, null),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.amber,
                  border: Border.all(
                    color: bordercolor,
                  ),
                  //color: baseColor,
                  borderRadius: BorderRadius.all(
                    new Radius.circular(4),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "فضلاً أدخل بيانات طلب إجازة",
                            style: titleTx(baseColor),
                          ),
                        ),
                        StaggeredGrid.count(
                            crossAxisCount: responsiveGrid(1, 2),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: [
                              TextFormField(
                                controller: _daysNumber,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: formlabel1("عدد الايام"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _date,
                                readOnly: true,
                                // keyboardType: TextInputType.datetime,
                                maxLines: 1,
                                decoration: formlabel1("تاريخ الإجازة"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    _date.text = date.toString().split(" ")[0];
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    _date.text = date.toString().split(" ")[0];
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                              DropdownSearch<dynamic>(
                                items: _MainDepartmentEmployees,
                                popupItemBuilder:
                                    (context, index, isSelected) => (Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(index.EmployeeName,
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
                                              : selectedItem.EmployeeName ?? "",
                                          style: subtitleTx(baseColorText),
                                        ),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton: _ReplaceEmployeeNumber == null
                                    ? false
                                    : true,
                                itemAsString: (item) => item.EmployeeName,
                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                dropdownSearchDecoration:
                                    formlabel1("الموظف البديل"),
                                //  InputDecoration(
                                //   hintText: "الموظف البديل",
                                //   //helperStyle: TextStyle(color: Colors.amber),
                                //   contentPadding: EdgeInsets.symmetric(
                                //       vertical: responsiveMT(10, 30),
                                //       horizontal: responsiveMT(10, 20)),
                                //   border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(4.0),

                                //     borderSide: BorderSide(color: bordercolor),
                                //   ),
                                // ),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "hgfef";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      _ReplaceEmployeeNumber = v.EmployeeNumber;
                                    });
                                    print('object');
                                    print(v.EmployeeNumber.toString());
                                    // value = v;
                                    //value = v ?? "";

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
                              // drop1.drop(items, "الموظف البديل", context),
                              // DropdownSearch<String>(
                              //   validator: (v) =>
                              //       v == null ? "required field" : null,
                              //   dropdownSearchDecoration: InputDecoration(
                              //     hintText: "الموظف البديل",
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         vertical: 2.0, horizontal: 20.0),
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(4.0),
                              //       borderSide: BorderSide(color: bordercolor),
                              //     ),
                              //   ),
                              //   mode: Mode.MENU,
                              //   showSelectedItems: true,
                              //   items: ["نور الدين", "مؤيد", "محمد", 'شريف'],
                              //   popupItemDisabled: (String s) =>
                              //       s.startsWith('I'),
                              //   onChanged: print,
                              // ),
                              DropdownSearch<dynamic>(
                                items: vacationTypes,
                                popupItemBuilder: (context, rr, isSelected) =>
                                    (Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(rr["VacationTypeName"].toString(),
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
                                                      "VacationTypeName"] ??
                                                  "",
                                          style: subtitleTx(baseColorText),
                                        ),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton:
                                    _VacationTypeID == null ? false : true,
                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                dropdownSearchDecoration:
                                    formlabel1("نوع الاجازة"),
                                // InputDecoration(
                                //   hintText: "نوع الاجازة",
                                //   helperStyle: TextStyle(color: Colors.amber),
                                //   contentPadding: EdgeInsets.symmetric(
                                //       vertical: responsiveMT(10, 30),
                                //       horizontal: responsiveMT(10, 20)),
                                //   border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(4.0),
                                //     borderSide: BorderSide(color: bordercolor),
                                //   ),
                                // ),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "hgfef";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      _VacationTypeID = v["VacationID"];
                                    });
                                    print('object');
                                    print(v["VacationID"]);
                                    // value = v;
                                    //value = v ?? "";
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
                              Text(
                                "هل ترغب بمنح البديل صلاحية التوقيع بالإنابة في النظام المعاملات الإلكترونية ؟",
                                style: descTx1(baseColorText),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DropdownSearch<dynamic>(
                                items: _SignatureApprovalFlag,
                                popupItemBuilder: (context, rr, isSelected) =>
                                    (Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(rr["Flag"].toString(),
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
                                              : selectedItem["Flag"] ?? "",
                                          style: subtitleTx(baseColorText),
                                        ),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton:
                                    _SignatureApproval == null ? false : true,
                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                dropdownSearchDecoration: formlabel1("اختر"),
                                // InputDecoration(
                                //   hintText: "نوع الاجازة",
                                //   helperStyle: TextStyle(color: Colors.amber),
                                //   contentPadding: EdgeInsets.symmetric(
                                //       vertical: responsiveMT(10, 30),
                                //       horizontal: responsiveMT(10, 20)),
                                //   border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(4.0),
                                //     borderSide: BorderSide(color: bordercolor),
                                //   ),
                                // ),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "hgfef";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      _SignatureApproval =
                                          v["SignatureApprovalFlag"];
                                    });
                                    print('object');
                                    print(v["SignatureApprovalFlag"]);
                                    // value = v;
                                    //value = v ?? "";
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
                                      "اختر",
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

                              //   DropdownSearch<String>(
                              //     validator: (v) =>
                              //         v == null ? "required field" : null,
                              //     dropdownSearchDecoration: InputDecoration(
                              //       hintText: "نوع الإجازة",
                              //       contentPadding: const EdgeInsets.symmetric(
                              //           vertical: 2.0, horizontal: 20.0),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(4.0),
                              //         borderSide: BorderSide(color: bordercolor),
                              //       ),
                              //     ),
                              //     mode: Mode.MENU,
                              //     showSelectedItems: true,
                              //     items: [
                              //       "إجازة اضطرارية",
                              //       "إجازة اعتيادية",
                              //       "تمديد إجازة اعتيادية",
                              //     ],
                              //     popupItemDisabled: (String s) =>
                              //         s.startsWith('I'),
                              //     onChanged: print,
                              //   ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _note,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: formlabel1("ملاحظات"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              widgetsUni.actionbutton(
                                "الطلبات السابقة",
                                Icons.local_attraction_sharp,
                                () {
                                  print("ee");
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
                                    InsertVacationRequest();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
