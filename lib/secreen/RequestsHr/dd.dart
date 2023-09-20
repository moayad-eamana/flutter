import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LeaveRequestCompanies extends StatefulWidget {
  const LeaveRequestCompanies({Key? key}) : super(key: key);

  @override
  State<LeaveRequestCompanies> createState() => _LeaveRequestCompaniesState();
}

class _LeaveRequestCompaniesState extends State<LeaveRequestCompanies> {
  TextEditingController _date = TextEditingController();
  TextEditingController _note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<MainDepartmentEmployees> _MainDepartmentEmployees = [];
  EmployeeProfile empinfo = new EmployeeProfile();
  String? selecteditem = null;
  var _ReplaceEmployeeNumber;
  bool errormessege = false;
  bool errormessege2 = false;
  var resBody;
  var permissionTypeId;

  Future<void> getMainDepartmentEmployees() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    if (sharedPref.getString("dumyuser") != "10284928492") {
      var respose = await getAction("HR/GetCompanyEmployeeReplacementList/" +
          EmployeeProfile.getEmployeeNumber());
      // print(empinfo.MainDepartmentID.toString());
      //print("respose = " + respose.toString());
      try {
        if (jsonDecode(respose.body)["EmpInfo"] != null) {
          _MainDepartmentEmployees =
              (jsonDecode(respose.body)["EmpInfo"] as List)
                  .map(((e) => MainDepartmentEmployees.fromJson(e)))
                  .toList();

          print(_MainDepartmentEmployees[0].EmployeeName);
          setState(() {});
        }
        EasyLoading.dismiss();
      } catch (Ex) {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
      _MainDepartmentEmployees = [];
    }
  }

  @override
  void initState() {
    getMainDepartmentEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: AppBarW.appBarW("تقدیم طلب استئذان", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              SingleChildScrollView(
                child: Padding(
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
                      child: Builder(builder: (context) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "نحتاج بس البیانات التالیة لاستكمال طلب الاستئذان",
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
                                      controller: _date,
                                      style: TextStyle(
                                        color: baseColorText,
                                      ),
                                      readOnly: true,
                                      // keyboardType: TextInputType.datetime,
                                      maxLines: 1,
                                      decoration: formlabel1("تاریخ الاستئذان"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'فضلاً أدخل التاريخ  ';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            // theme: DatePickerThemeData(
                                            //   backgroundColor: BackGWhiteColor,
                                            //   // itemStyle: TextStyle(
                                            //   //   color: baseColorText,
                                            //   // ),
                                            // ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ]),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "نوع الاستئذان ",
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
                                    activeBgColor: [baseColor],
                                    totalSwitches: 2,
                                    initialLabelIndex: permissionTypeId == null
                                        ? null
                                        : (permissionTypeId == 1 ? 0 : 1),
                                    labels: ['حضور', 'انصراف'],
                                    onToggle: (index) {
                                      int indexS = index as int;

                                      permissionTypeId = indexS == 0 ? 1 : 2;
                                      print(
                                          'switched to: ' + indexS.toString());
                                    },
                                  ),
                                ],
                              ),
                              StaggeredGrid.count(
                                crossAxisCount: responsiveGrid(1, 2),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: [
                                  Text(
                                    "الموظف البديل ",
                                    style: descTx1(baseColorText),
                                    maxLines: 3,
                                  ),

                                  //DROPDOWN LIST WITH SEARCH FUNCTION
                                  DropdownSearch<dynamic>(
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
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: errormessege2
                                                ? redColor
                                                : bordercolor),
                                        borderRadius: BorderRadius.circular(4),
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

                                  errormessege2 == true
                                      ? Text(
                                          "الرجاء الاختيار الموظف البديل",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: redColor,
                                          ),
                                        )
                                      : Container(),
                                ],

                                //
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
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 110,
                                child: widgetsUni.actionbutton(
                                  'تنفيذ',
                                  Icons.send,
                                  () {
                                    ////
                                    ///
                                    if (permissionTypeId == null) {
                                      Alerts.errorAlert(context, "خطأ",
                                              "يجب إختيار نوع الاستئذان")
                                          .show();
                                      return;
                                    }
                                    if (_ReplaceEmployeeNumber == null) {
                                      setState(() {
                                        errormessege2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        errormessege2 = false;
                                      });
                                    }

                                    if (_formKey.currentState!.validate()) {
                                      InsertLeaveRequest();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<void> InsertLeaveRequest() async {
    Map data = {
      "EmployeeNumber": empinfo.EmployeeNumber,
      "ReplaceEmployeeNumber": _ReplaceEmployeeNumber,
      "PermissionTypeID": permissionTypeId,
      "PersmissionDate": _date.text,
      "Notes": _note.text.toString(),
    };

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

        var respose = await postAction("HR/InsertLeaveRequestCompanies", body);
        print(jsonDecode(respose.body));
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "LeaveRequestController";
        logapiO.ClassName = "LeaveRequestController";
        logapiO.ActionMethodName = "طلب استئذان";
        logapiO.ActionMethodType = 2;
        if (jsonDecode(respose.body)["StatusCode"] != 400) {
          logapiO.StatusCode = 0;
          logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
          logApi(logapiO);
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(respose.body)["ErrorMessage"])
              .show();
        } else {
          logapiO.StatusCode = 1;
          logApi(logapiO);
          Alerts.successAlert(context, "", "تم ارسال الطلب").show();
        }

        EasyLoading.dismiss();
      }
    });
  }
}
