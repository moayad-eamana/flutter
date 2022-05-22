import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  int ToggleSwitchindex = -1;

  String? selecteditem = null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => getMainDepartmentEmployees());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
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
    var respose = await getAction("HR/GetEmployeeReplacments/" +
        empinfo.EmployeeNumber.toString().split(".")[0]);
    // print(empinfo.MainDepartmentID.toString());
    //print("respose = " + respose.toString());
    try {
      if (jsonDecode(respose.body)["EmployeesList"] != null) {
        _MainDepartmentEmployees =
            (jsonDecode(respose.body)["EmployeesList"] as List)
                .map(((e) => MainDepartmentEmployees.fromJson(e)))
                .toList();

        //print(_MainDepartmentEmployees[0].EmployeeName);
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
          Alerts.successAlert(context, "", "تم ارسال الطلب").show();
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
    {"index": 0, "Flag": "نعم", "SignatureApprovalFlag": true},
    {"index": 1, "Flag": "لا", "SignatureApprovalFlag": false},
  ];

  bool errormessege = false;
  bool errormessege2 = false;

  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();

  UniqueKey _UniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("تقدیم طلب إجازة", context, null),
          body: Container(
            height: 100.h,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    imageBG,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
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
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "إجازة سعیدة",
                                  style: titleTx(baseColor),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "نحتاج بس البیانات التالیة لاستكمال طلب الإجازة",
                                  style: descTx1(secondryColorText),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              StaggeredGrid.count(
                                  crossAxisCount: responsiveGrid(1, 2),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  children: [
                                    TextFormField(
                                      controller: _daysNumber,
                                      style: TextStyle(
                                        color: baseColorText,
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      decoration: formlabel1("مدة الإجازة"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'لابد من إدخال مدة الإجازة بالارقام';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _date,
                                      style: TextStyle(
                                        color: baseColorText,
                                      ),
                                      readOnly: true,
                                      // keyboardType: TextInputType.datetime,
                                      maxLines: 1,
                                      decoration:
                                          formlabel1("تاریخ بدایة الإجازة"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'فضلاً أدخل تاریخ بدایة الإجازة';
                                        }
                                        return null;
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
                                          _date.text =
                                              date.toString().split(" ")[0];
                                          print('change $date');
                                        }, onConfirm: (date) {
                                          _date.text =
                                              date.toString().split(" ")[0];
                                          print('confirm $date');
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.ar);
                                      },
                                    ),
                                    DropdownSearch<dynamic>(
                                      items: vacationTypes,
                                      popupBackgroundColor: BackGWhiteColor,
                                      popupItemBuilder:
                                          (context, rr, isSelected) =>
                                              (Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                                rr["VacationTypeName"]
                                                    .toString(),
                                                style:
                                                    subtitleTx(baseColorText))
                                          ],
                                        ),
                                      )),
                                      dropdownBuilder:
                                          (context, selectedItem) => Container(
                                        decoration: null,
                                        child: selectedItem == null
                                            ? null
                                            : Text(
                                                selectedItem == null
                                                    ? ""
                                                    : selectedItem[
                                                            "VacationTypeName"] ??
                                                        "",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: baseColorText)),
                                      ),
                                      dropdownBuilderSupportsNullItem: true,
                                      mode: Mode.BOTTOM_SHEET,
                                      showClearButton: _VacationTypeID == null
                                          ? false
                                          : true,
                                      maxHeight: 400,
                                      showAsSuffixIcons: true,
                                      dropdownSearchDecoration:
                                          formlabel1("نوع الاجازة"),
                                      validator: (value) {
                                        if (value == "" || value == null) {
                                          return "يرجى إختيار نوع الإجازة";
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
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "نوع الإجازة",
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
                                    //////////
                                    ///
                                    ///
                                    DropdownSearch<dynamic>(
                                      popupBackgroundColor: BackGWhiteColor,
                                      key: UniqueKey(),
                                      items: _MainDepartmentEmployees,
                                      popupItemBuilder:
                                          (context, rr, isSelected) =>
                                              (Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Text(rr.EmployeeName,
                                                style:
                                                    subtitleTx(baseColorText))
                                          ],
                                        ),
                                      )),
                                      dropdownBuilder:
                                          (context, selectedItem) => Container(
                                        child: selectedItem == null
                                            ? null
                                            : Text(
                                                selecteditem == null
                                                    ? ""
                                                    : selecteditem ?? "",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: baseColorText)),
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
                                        errorStyle: TextStyle(color: redColor),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: responsiveMT(8, 30),
                                            horizontal: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: BorderSide(
                                              color: errormessege2
                                                  ? redColor
                                                  : bordercolor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: errormessege2
                                                  ? redColor
                                                  : bordercolor),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: errormessege2
                                                  ? redColor
                                                  : bordercolor),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == "" || value == null) {
                                          return "الرجاء إختيار الموظف البديل";
                                        } else {
                                          return null;
                                        }
                                      },
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

                                    errormessege2 == true
                                        ? Text(
                                            "الرجاء الاختيار الموظف البديل",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: redColor,
                                            ),
                                          )
                                        : Container(),

                                    SizedBox(
                                      height: 5,
                                    ),

                                    ///////////
                                    // DropdownSearch<MainDepartmentEmployees>(
                                    //   // key: UniqueKey(),
                                    //   items: _MainDepartmentEmployees,
                                    //   popupBackgroundColor: BackGWhiteColor,
                                    //   showSearchBox: true,
                                    //   itemAsString:
                                    //       (MainDepartmentEmployees? u) =>
                                    //           u?.getEmployeeName() ?? "",
                                    //   maxHeight: 400,
                                    //   showAsSuffixIcons: true,
                                    //   popupItemBuilder:
                                    //       (context, index, isSelected) =>
                                    //           (Container(
                                    //     margin: EdgeInsets.only(top: 10),
                                    //     child: Column(
                                    //       children: [
                                    //         Text(index.getEmployeeName(),
                                    //             style: subtitleTx(baseColorText))
                                    //       ],
                                    //     ),
                                    //   )),
                                    //   showSelectedItems: false,
                                    //   // dropdownBuilder: (context, selectedItem) =>
                                    //   //     Container(
                                    //   //   decoration: null,
                                    //   //   child: selectedItem == null
                                    //   //       ? null
                                    //   //       : Text(
                                    //   //           selectedItem == null
                                    //   //               ? ""
                                    //   //               : selectedItem.EmployeeName ??
                                    //   //                   "",
                                    //   //           style: subtitleTx(baseColorText),
                                    //   //         ),
                                    //   // ),
                                    //   //dropdownBuilderSupportsNullItem: true,
                                    //   mode: Mode.BOTTOM_SHEET,
                                    //   showClearButton:
                                    //       _ReplaceEmployeeNumber == null
                                    //           ? false
                                    //           : true,
                                    //   dropdownSearchDecoration:
                                    //       formlabel1("الموظف البديل"),
                                    //   validator: (value) {
                                    //     if (value == "" || value == null) {
                                    //       return "يرجى إختيار الموظف البديل";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    //   onChanged: (v) {
                                    //     try {
                                    //       _ReplaceEmployeeNumber =
                                    //           v?.getEmployeeNumber();

                                    //       print(
                                    //           v?.getEmployeeNumber().toString());
                                    //     } catch (e) {}
                                    //   },
                                    //   popupTitle: Container(
                                    //     height: 60,
                                    //     decoration: BoxDecoration(
                                    //       color: secondryColor,
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(20),
                                    //         topRight: Radius.circular(20),
                                    //       ),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "الموظف البديل",
                                    //         style: TextStyle(
                                    //           fontSize: 24,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   popupShape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(24),
                                    //       topRight: Radius.circular(24),
                                    //     ),
                                    //   ),
                                    // ),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "إعطاء البدیل صلاحیات التوقیع بالانابة في نظام المعاملات ؟",
                                            style: descTx1(baseColorText),
                                            maxLines: 3,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        ToggleSwitch(
                                          radiusStyle: true,
                                          borderWidth: 1,
                                          borderColor: [bordercolor],
                                          inactiveBgColor: BackGColor,
                                          inactiveFgColor: baseColorText,
                                          minWidth: 50.0,
                                          minHeight: 35,
                                          initialLabelIndex:
                                              ToggleSwitchindex == -1
                                                  ? null
                                                  : ToggleSwitchindex,
                                          activeBgColor: [baseColor],
                                          totalSwitches: 2,
                                          labels: ['نعم', 'لا'],
                                          onToggle: (index) {
                                            int indexS = index as int;
                                            _SignatureApproval =
                                                _SignatureApprovalFlag[indexS]
                                                    ["SignatureApprovalFlag"];

                                            ToggleSwitchindex =
                                                _SignatureApprovalFlag[indexS]
                                                    ["index"];

                                            print(
                                                'switched to: $_SignatureApproval');
                                          },
                                        ),
                                      ],
                                    ),
                                    errormessege == true
                                        ? Text(
                                            "هل توافق أم لا؟... الرجاء الاختيار",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: redColor,
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    // DropdownSearch<dynamic>(
                                    //   items: _SignatureApprovalFlag,
                                    //   popupItemBuilder:
                                    //       (context, rr, isSelected) => (Container(
                                    //     margin: EdgeInsets.only(top: 10),
                                    //     child: Column(
                                    //       children: [
                                    //         Text(rr["Flag"].toString(),
                                    //             style: subtitleTx(baseColorText))
                                    //       ],
                                    //     ),
                                    //   )),
                                    //   dropdownBuilder: (context, selectedItem) =>
                                    //       Container(
                                    //     decoration: null,
                                    //     child: selectedItem == null
                                    //         ? null
                                    //         : Text(
                                    //             selectedItem == null
                                    //                 ? ""
                                    //                 : selectedItem["Flag"] ?? "",
                                    //             style: subtitleTx(baseColorText),
                                    //           ),
                                    //   ),
                                    //   dropdownBuilderSupportsNullItem: true,
                                    //   mode: Mode.BOTTOM_SHEET,
                                    //   showClearButton: _SignatureApproval == null
                                    //       ? false
                                    //       : true,
                                    //   maxHeight: 400,
                                    //   showAsSuffixIcons: true,
                                    //   dropdownSearchDecoration:
                                    //       formlabel1("اختر"),
                                    //   // InputDecoration(
                                    //   //   hintText: "نوع الاجازة",
                                    //   //   helperStyle: TextStyle(color: Colors.amber),
                                    //   //   contentPadding: EdgeInsets.symmetric(
                                    //   //       vertical: responsiveMT(10, 30),
                                    //   //       horizontal: responsiveMT(10, 20)),
                                    //   //   border: OutlineInputBorder(
                                    //   //     borderRadius: BorderRadius.circular(4.0),
                                    //   //     borderSide: BorderSide(color: bordercolor),
                                    //   //   ),
                                    //   // ),
                                    //   validator: (value) {
                                    //     if (value == "" || value == null) {
                                    //       return "hgfef";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    //   showSearchBox: true,
                                    //   onChanged: (v) {
                                    //     try {
                                    //       setState(() {
                                    //         _SignatureApproval =
                                    //             v["SignatureApprovalFlag"];
                                    //       });
                                    //       print('object');
                                    //       print(v["SignatureApprovalFlag"]);
                                    //       // value = v;
                                    //       //value = v ?? "";
                                    //     } catch (e) {}
                                    //   },
                                    //   popupTitle: Container(
                                    //     height: 60,
                                    //     decoration: BoxDecoration(
                                    //       color: secondryColor,
                                    //       borderRadius: const BorderRadius.only(
                                    //         topLeft: Radius.circular(20),
                                    //         topRight: Radius.circular(20),
                                    //       ),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "اختر",
                                    //         style: TextStyle(
                                    //           fontSize: 24,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   popupShape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(24),
                                    //       topRight: Radius.circular(24),
                                    //     ),
                                    //   ),
                                    // ),

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
                                style: TextStyle(color: baseColorText),
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
                                    // widgetsUni.actionbutton(
                                    //   "الطلبات السابقة",
                                    //   Icons.local_attraction_sharp,
                                    //   () {
                                    //     //
                                    //     Alerts.warningAlert(context, "تنبيه",
                                    //             "لا توجد طلبات سابقة في حالتھا")
                                    //         .show();
                                    //     print("ee");
                                    //   },
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    widgetsUni.actionbutton(
                                      'الطلبات السابقة',
                                      Icons.history,
                                      () {
                                        Navigator.pushNamed(
                                            context, "/vacation_old_request");
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
                                        if (_SignatureApproval == null) {
                                          setState(() {
                                            errormessege = true;
                                          });
                                          Alerts.errorAlert(context, "خطأ",
                                                  "يرجى الاختيار الرغبة بإعطاء الموظف البديل صلاحية")
                                              .show();
                                        } else {
                                          setState(() {
                                            errormessege = false;
                                          });
                                        }
                                        ////
                                        if (_ReplaceEmployeeNumber == null) {
                                          setState(() {
                                            errormessege2 = true;
                                          });
                                        } else {
                                          setState(() {
                                            errormessege2 = false;
                                          });
                                        }
                                        if (_formKey.currentState!.validate() &&
                                            _SignatureApproval != null &&
                                            _ReplaceEmployeeNumber != null) {
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
                ],
              ),
            ),
          )),
    );
  }
}
