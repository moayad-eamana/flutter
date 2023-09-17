import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/functions/handelCalander.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:eamanaapp/utilities/styles/CSS/CSS.dart';

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
  var VacationTypeName;
  var images;

  String? fileName;
  String? fileBytes;
  String? filePath;
  bool selectedOption = false;
  bool showError = false;
  bool showAttachmentError = false;

  DropdownSearchW drop1 = new DropdownSearchW();
  EmployeeProfile empinfo = new EmployeeProfile();

  late List<MainDepartmentEmployees> _MainDepartmentEmployees = [];

  int ToggleSwitchindex = -1;

  String? selecteditem = null;

  @override
  void initState() {
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "VacationsController";
    logapiO.ClassName = "VacationsController";
    logapiO.ActionMethodName = "صفحة طلب إجازة";
    logapiO.ActionMethodType = 1;
    logApi(logapiO);
    super.initState();
    getMainDepartmentEmployees();
  }

//push
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
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    await getuserinfo();
    if (sharedPref.getString("dumyuser") != "10284928492") {
      var respose = sharedPref.getInt("empTypeID") != 8
          ? await getAction("HR/GetEmployeeReplacments/" +
              EmployeeProfile.getEmployeeNumber())
          : await getAction("HR/GetCompanyEmployeeReplacementList/" +
              EmployeeProfile.getEmployeeNumber());
      // print(empinfo.MainDepartmentID.toString());
      //print("respose = " + respose.toString());
      try {
        if (jsonDecode(respose.body)[sharedPref.getInt("empTypeID") != 8
                ? "EmployeesList"
                : "EmpInfo"] !=
            null) {
          _MainDepartmentEmployees = (jsonDecode(respose.body)[
                  sharedPref.getInt("empTypeID") != 8
                      ? "EmployeesList"
                      : "EmpInfo"] as List)
              .map(((e) => MainDepartmentEmployees.fromJson(e)))
              .toList();

          //print(_MainDepartmentEmployees[0].EmployeeName);
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

  Future<void> InsertVacationRequest() async {
//rtyrtyer
    Map data = sharedPref.getInt("empTypeID") != 8
        ? {
            "EmployeeNumber": empinfo.EmployeeNumber,
            "ReplaceEmployeeNumber": _ReplaceEmployeeNumber,
            "VacationDays": int.parse(_daysNumber.text),
            "VacationTypeID":
                int.parse(_VacationTypeID.toString().split(".")[0]),
            "StartDate": _date.text,
            //"2022-02-23T13:05:22.2919384+03:00",
            "Notes": _note.text.toString(),
            "SignatureApprovalFlag": _SignatureApproval,
          }
        : {
            "EmployeeNumber": EmployeeProfile.getEmployeeNumber(),
            "ReqplacmentEmployeeNumber":
                int.parse(_ReplaceEmployeeNumber.toString().split(".")[0]),
            "VacationDays": int.parse(_daysNumber.text),
            "StartDate": _date.text,
            "VacationTypeID": int.parse(_VacationTypeID.toString()),
            "Notes": _note.text.toString(),
            "FileBytes": _VacationTypeID == 1 ? null : fileBytes,
            "FileName": _VacationTypeID == 1 ? null : fileName
            // "DepartmentID": 8,
            // "BdgLoc": 9
            // "EndDate": "2023-07-05T12:04:57.2705948+03:00",
          };
    print(data);
    //encode Map to JSON

    var body = json.encode(data);
    if (sharedPref.getInt("empTypeID") == 8 &&
        images == null &&
        _VacationTypeID != 1) {
      //  Alerts.errorAlert(context, "خطأ", "يجب إدخال مرفق").show();
      return;
    }

    Alerts.confirmAlrt(context, "تأكيد", "هل انت متأكد؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: 'جاري إرسال الطلب...',
          maskType: EasyLoadingMaskType.black,
        );

        var respose = sharedPref.getInt("empTypeID") != 8
            ? await postAction("HR/InsertVacationRequest/", body)
            : await postAction("HR/InsertVacationRequestCompanies", body);
        print(jsonDecode(respose.body));
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "VacationsController";
        logapiO.ClassName = "VacationsController";
        logapiO.ActionMethodName = "طلب إجازة";
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
          Alerts.successAlert(context, "", "تم ارسال الطلب")
              .show()
              .then((value) async {
            String endDate = DateTime(
              int.parse(_date.text.split("-")[0]),
              (int.parse(_date.text.split("-")[1])),
              (int.parse(_date.text.split("-")[2]) +
                  int.parse(_daysNumber.text)),
            ).toString();
            print(endDate);
            await handelCalander.pusToCalander(
                _date.text,
                _date.text.split(" ")[0],
                null,
                null,
                "إجازة",
                "بداية" + VacationTypeName);
            await handelCalander.pusToCalander(
                endDate.split(" ")[0],
                endDate.split(" ")[0],
                null,
                null,
                "إجازة",
                "نهاية " + VacationTypeName);
          });
        }

        EasyLoading.dismiss();
      }
    });
  }

  List<Map<dynamic, dynamic>> vacationTypes =
      sharedPref.getInt("empTypeID") != 8
          ? [
              {"VacationTypeName": "إجازة اعتيادية", "VacationID": 116.0},
              {"VacationTypeName": "إجازة اضطرارية", "VacationID": 122.0},
              {"VacationTypeName": "تمديد إجازة اعتيادية", "VacationID": 124.0},
            ]
          : [
              {"VacationTypeName": "إجازة اعتيادية", "VacationID": 1},
              {"VacationTypeName": "إجازة مرضية", "VacationID": 2},
              {"VacationTypeName": "إجازة إستثنائية", "VacationID": 3}
            ];

  List<Map<dynamic, dynamic>> _SignatureApprovalFlag = [
    {"index": 0, "Flag": "نعم", "SignatureApprovalFlag": true},
    {"index": 1, "Flag": "لا", "SignatureApprovalFlag": false},
  ];

  bool errormessege = false;
  // bool errormessege2 = false;

  final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();

  UniqueKey _UniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBarW.appBarW("تقدیم طلب إجازة", context, null),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //vacation day label
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "مدة الاجازة",
                              style: fontsStyle.px14(
                                  fontsStyle.thirdColor(), FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //vacation day textform field
                          Container(
                            child: TextFormField(
                              controller: _daysNumber,
                              decoration: CSS.TextFieldDecoration('عدد الايام'),
                              style: fontsStyle.px14(
                                  Colors.grey, FontWeight.normal),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى كتابة عدد الايام';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // vacation date label
                          Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "تاريخ بداية الاجازة",
                                style: fontsStyle.px14(
                                    fontsStyle.thirdColor(), FontWeight.bold),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          //vacation date textform field
                          Container(
                            child: TextFormField(
                              controller: _date,
                              readOnly: true,
                              minLines: 1,
                              decoration: CSS.TextFieldDecoration(
                                'اختر التاريخ',
                                icon: Icon(Icons.calendar_today_outlined),
                              ),
                              style: fontsStyle.px14(
                                  Colors.grey, FontWeight.normal),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              maxLines: 1,
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //vacation type label
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "نوع الاجازة",
                              style: fontsStyle.px14(
                                  fontsStyle.thirdColor(), FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //vacation type textform field
                          DropdownSearch<dynamic>(
                            items: vacationTypes,
                            popupBackgroundColor: Colors.white,
                            popupItemBuilder: (context, rr, isSelected) =>
                                (Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Text(
                                    rr["VacationTypeName"].toString(),
                                    style: subtitleTx(baseColorText),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  )
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
                                          : selectedItem["VacationTypeName"] ??
                                              "",
                                      style: TextStyle(
                                          fontSize: 16, color: baseColorText)),
                            ),
                            dropdownBuilderSupportsNullItem: true,
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton:
                                _VacationTypeID == null ? false : true,
                            maxHeight: 300,
                            showAsSuffixIcons: true,
                            dropdownSearchDecoration:
                                CSS.TextFieldDecoration("نوع الاجازة"),
                            validator: (value) {
                              if (value == "" || value == null) {
                                return "يرجى اختيار نوع الإجازة";
                              } else {
                                return null;
                              }
                            },
                            showSearchBox: false,
                            onChanged: (v) {
                              try {
                                setState(() {
                                  print(v);
                                  _VacationTypeID = v["VacationID"];
                                  VacationTypeName = v["VacationTypeName"];
                                });
                                print('object');
                                print(v["VacationID"]);
                                // value = v;
                                //value = v ?? "";
                              } catch (e) {}
                            },
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            popupTitle: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: fontsStyle.HeaderColor(),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text("نوع الاجازة",
                                    style: fontsStyle.px20(
                                        Colors.white, FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          if (_VacationTypeID == 2 || _VacationTypeID == 3)
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "المرفقات",
                                style: fontsStyle.px14(
                                    fontsStyle.thirdColor(), FontWeight.bold),
                              ),
                            ),
                          if (_VacationTypeID == 2 || _VacationTypeID == 3)
                            SizedBox(
                              height: 10,
                            ),

                          if (_VacationTypeID == 2 || _VacationTypeID == 3)
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    images = await Pickattachments.pickFile(
                                        ["pdf", "png", "jpeg", "jpg"]);

                                    print(images);
                                    if (images != null) {
                                      if (images["size"] < 2000000) {
                                        filePath = images["path"];
                                        fileName = images["name"];
                                        fileBytes = images["base64"];
                                        showAttachmentError = false;
                                      } else {
                                        Alerts.warningAlert(
                                                context,
                                                "حجم الملف",
                                                "يجب ان لا يزيد حجم الملف عن 2 ميجابايت ")
                                            .show();
                                      }
                                    }

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: images == null
                                        ? Stack(
                                            children: [
                                              Placeholder(
                                                color: secondryColorText,
                                                strokeWidth: 0.4,
                                                fallbackHeight: 100,
                                                fallbackWidth: 100,
                                              ),
                                              Center(child: Text("مرفق")),
                                            ],
                                          )
                                        : images["type"] == "pdf"
                                            ? Icon(
                                                Icons.picture_as_pdf,
                                                color: baseColor,
                                                size: 50,
                                              )
                                            : Image.file(
                                                File(filePath.toString()),
                                                width: 100,
                                                height: 100,
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          if (_VacationTypeID == 2 || _VacationTypeID == 3)
                            if (showAttachmentError)
                              Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Text(
                                      "يرجى ارفاق ملف",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  )),
                          if (_VacationTypeID == 2 || _VacationTypeID == 3)
                            SizedBox(
                              height: 20,
                            ),
                          //vacation replacement employee label
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              "الموظف البديل",
                              style: fontsStyle.px14(
                                  fontsStyle.thirdColor(), FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //vacation replacement employee field
                          DropdownSearch<dynamic>(
                            popupBackgroundColor: BackGWhiteColor,
                            // key: UniqueKey(),
                            items: _MainDepartmentEmployees,
                            popupItemBuilder: (context, rr, isSelected) =>
                                (Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Text(rr.EmployeeName,
                                      style: subtitleTx(baseColorText)),
                                  Divider(
                                    thickness: 1,
                                  )
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
                                          fontSize: 16, color: baseColorText)),
                            ),
                            dropdownBuilderSupportsNullItem: true,
                            selectedItem:
                                selecteditem == null ? null : selecteditem,
                            showSelectedItems: false,
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton:
                                _ReplaceEmployeeNumber == null ? false : true,
                            maxHeight: 400,
                            showAsSuffixIcons: true,
                            itemAsString: (item) => item?.EmployeeName ?? "",
                            dropdownSearchDecoration:
                                CSS.TextFieldDecoration("الموظف البديل"),
                            validator: (value) {
                              if (value == null || value == '') {
                                return "يرجى اختيار الموظف البديل";
                              }
                              return null;
                            },
                            showSearchBox: true,
                            onChanged: (v) {
                              try {
                                _ReplaceEmployeeNumber = v?.EmployeeNumber;
                                selecteditem = v.EmployeeName;
                                print(v?.EmployeeNumbder.toString());

                                //setState(() {});
                              } catch (e) {}
                            },
                            popupTitle: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: fontsStyle.HeaderColor(),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Text("الموظف البديل",
                                    style: fontsStyle.px20(
                                        Colors.white, FontWeight.bold)),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
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
                            ),
                            dropDownButton: Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),

                          // errormessege2 == true
                          //     ? Row(
                          //         children: [
                          //           Text(
                          //             "الرجاء اختيار الموظف البديل",
                          //             style: TextStyle(
                          //               color: redColor,
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          //signature approval:
                          if (sharedPref.getInt("empTypeID") != 8)
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "إعطاء البديل صلاحيات التوقيع في نظام المعاملات؟",
                                      style: fontsStyle.px14(
                                          fontsStyle.thirdColor(),
                                          FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                // ToggleSwitch(
                                //   radiusStyle: true,
                                //   borderWidth: 1,
                                //   borderColor: [bordercolor],
                                //   inactiveBgColor: BackGColor,
                                //   inactiveFgColor: baseColorText,
                                //   minWidth: 50.0,
                                //   minHeight: 35,
                                //   initialLabelIndex: ToggleSwitchindex == -1
                                //       ? null
                                //       : ToggleSwitchindex,
                                //   activeBgColor: [baseColor],
                                //   totalSwitches: 2,
                                //   labels: ['نعم', 'لا'],
                                //   onToggle: (index) {
                                //     int indexS = index as int;
                                //     _SignatureApproval =
                                //         _SignatureApprovalFlag[indexS]
                                //             ["SignatureApprovalFlag"];

                                //     ToggleSwitchindex =
                                //         _SignatureApprovalFlag[indexS]["index"];

                                //     print('switched to: $_SignatureApproval');
                                //   },
                                // ),
                              ],
                            ),
                          if (sharedPref.getInt("empTypeID") != 8)
                            Row(
                              children: [
                                Radio<bool>(
                                  value: true,
                                  groupValue: _SignatureApproval,
                                  onChanged: (value) {
                                    setState(() {
                                      _SignatureApproval = value!;
                                    });
                                  },
                                ),
                                Text('نعم'),
                                Radio<bool>(
                                  focusColor: fontsStyle.HeaderColor(),
                                  value: false,
                                  groupValue: _SignatureApproval,
                                  onChanged: (value) {
                                    setState(() {
                                      _SignatureApproval = value!;
                                    });
                                  },
                                ),
                                Text('لا'),
                              ],
                            ),
                          showError == true &&
                                  sharedPref.getInt("empTypeID") != 8
                              ? Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Text(
                                      "يرجى اختيار الرغبة في إعطاء الصلاحية",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ))
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          //vacation notes label
                          Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                "الملاحظات",
                                style: fontsStyle.px14(
                                    fontsStyle.thirdColor(), FontWeight.bold),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          //vacation notes text form feild
                          TextFormField(
                            controller: _note,
                            decoration: CSS.TextFieldDecoration('اكتب ملاحظات'),
                            style:
                                fontsStyle.px14(Colors.grey, FontWeight.normal),
                            maxLines: 3,
                            minLines: 3,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // submit button
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            height: 40,
                            width: 250,
                            child: ElevatedButton(
                              onPressed: () {
                                validateSelection();
                                validateAttachment();
                                if (sharedPref.getInt("empTypeID") != 8 &&
                                    _formKey.currentState!.validate()) {
                                  InsertVacationRequest();
                                }
                                if (sharedPref.getInt("empTypeID") == 8 &&
                                    _formKey.currentState!.validate()) {
                                  InsertVacationRequest();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: fontsStyle.HeaderColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                              child: Text(
                                'ارسال',
                                style: fontsStyle.px16(
                                    Colors.white, FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Stack(
        //   children: [
        //     widgetsUni.bacgroundimage(),
        //     SingleChildScrollView(
        //       child: Padding(
        //         padding: EdgeInsets.all(20.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             color: BackGWhiteColor,
        //             border: Border.all(
        //               color: bordercolor,
        //             ),
        //             //color: baseColor,
        //             borderRadius: BorderRadius.all(
        //               new Radius.circular(4),
        //             ),
        //           ),
        //           child:
        //           Form(
        //             key: _formKey,
        //             child: Padding(
        //               padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Center(
        //                     child: Text(
        //                       "إجازة سعیدة",
        //                       style: titleTx(baseColor),
        //                     ),
        //                   ),
        //                   Center(
        //                     child: Text(
        //                       "نحتاج بس البیانات التالیة لاستكمال طلب الإجازة",
        //                       style: descTx1(secondryColorText),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   StaggeredGrid.count(
        //                       crossAxisCount: responsiveGrid(1, 2),
        //                       mainAxisSpacing: 10,
        //                       crossAxisSpacing: 10,
        //                       children: [
        //                         TextFormField(
        //                           controller: _daysNumber,
        //                           style: TextStyle(
        //                             color: baseColorText,
        //                           ),
        //                           inputFormatters: <TextInputFormatter>[
        //                             FilteringTextInputFormatter.digitsOnly
        //                           ],
        //                           keyboardType: TextInputType.number,
        //                           maxLines: 1,
        //                           decoration: formlabel1("مدة الإجازة"),
        //                           validator: (value) {
        //                             if (value == null || value.isEmpty) {
        //                               return 'لابد من إدخال مدة الإجازة بالارقام';
        //                             }
        //                             return null;
        //                           },
        //                         ),
        //                         TextFormField(
        //                           controller: _date,
        //                           style: TextStyle(
        //                             color: baseColorText,
        //                           ),
        //                           readOnly: true,
        //                           // keyboardType: TextInputType.datetime,
        //                           maxLines: 1,
        //                           decoration:
        //                               formlabel1("تاریخ بدایة الإجازة"),
        //                           validator: (value) {
        //                             if (value == null || value.isEmpty) {
        //                               return 'فضلاً أدخل تاریخ بدایة الإجازة';
        //                             }
        //                             return null;
        //                           },
        //                           onTap: () {
        //                             DatePicker.showDatePicker(context,
        //                                 theme: DatePickerTheme(
        //                                   backgroundColor: BackGWhiteColor,
        //                                   itemStyle: TextStyle(
        //                                     color: baseColorText,
        //                                   ),
        //                                 ),
        //                                 showTitleActions: true,
        //                                 minTime: DateTime(2021, 3, 5),
        //                                 onChanged: (date) {
        //                               _date.text =
        //                                   date.toString().split(" ")[0];
        //                               print('change $date');
        //                             }, onConfirm: (date) {
        //                               _date.text =
        //                                   date.toString().split(" ")[0];
        //                               print('confirm $date');
        //                             },
        //                                 currentTime: DateTime.now(),
        //                                 locale: LocaleType.ar);
        //                           },
        //                         ),
        //                         DropdownSearch<dynamic>(
        //                           items: vacationTypes,
        //                           popupBackgroundColor: BackGWhiteColor,
        //                           popupItemBuilder:
        //                               (context, rr, isSelected) => (Container(
        //                             margin: EdgeInsets.only(top: 10),
        //                             child: Column(
        //                               children: [
        //                                 Text(
        //                                     rr["VacationTypeName"].toString(),
        //                                     style: subtitleTx(baseColorText))
        //                               ],
        //                             ),
        //                           )),
        //                           dropdownBuilder: (context, selectedItem) =>
        //                               Container(
        //                             decoration: null,
        //                             child: selectedItem == null
        //                                 ? null
        //                                 : Text(
        //                                     selectedItem == null
        //                                         ? ""
        //                                         : selectedItem[
        //                                                 "VacationTypeName"] ??
        //                                             "",
        //                                     style: TextStyle(
        //                                         fontSize: 16,
        //                                         color: baseColorText)),
        //                           ),
        //                           dropdownBuilderSupportsNullItem: true,
        //                           mode: Mode.BOTTOM_SHEET,
        //                           showClearButton:
        //                               _VacationTypeID == null ? false : true,
        //                           maxHeight: 400,
        //                           showAsSuffixIcons: true,
        //                           dropdownSearchDecoration:
        //                               formlabel1("نوع الاجازة"),
        //                           validator: (value) {
        //                             if (value == "" || value == null) {
        //                               return "يرجى إختيار نوع الإجازة";
        //                             } else {
        //                               return null;
        //                             }
        //                           },
        //                           showSearchBox: true,
        //                           onChanged: (v) {
        //                             try {
        //                               setState(() {
        //                                 print(v);
        //                                 _VacationTypeID = v["VacationID"];
        //                                 VacationTypeName =
        //                                     v["VacationTypeName"];
        //                               });
        //                               print('object');
        //                               print(v["VacationID"]);
        //                               // value = v;
        //                               //value = v ?? "";
        //                             } catch (e) {}
        //                           },
        //                           popupTitle: Container(
        //                             height: 60,
        //                             decoration: BoxDecoration(
        //                               color: secondryColor,
        //                               borderRadius: BorderRadius.only(
        //                                 topLeft: Radius.circular(20),
        //                                 topRight: Radius.circular(20),
        //                               ),
        //                             ),
        //                             child: Center(
        //                               child: Text(
        //                                 "نوع الإجازة",
        //                                 style: TextStyle(
        //                                   fontSize: 24,
        //                                   fontWeight: FontWeight.bold,
        //                                   color: Colors.white,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           popupShape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.only(
        //                               topLeft: Radius.circular(24),
        //                               topRight: Radius.circular(24),
        //                             ),
        //                           ),
        //                           emptyBuilder: (context, searchEntry) =>
        //                               Center(
        //                             child: Text(
        //                               "لا يوجد بيانات",
        //                               style: TextStyle(
        //                                 color: baseColorText,
        //                               ),
        //                             ),
        //                           ),
        //                           searchFieldProps: TextFieldProps(
        //                             textAlign: TextAlign.right,
        //                             decoration: formlabel1(""),
        //                             style: TextStyle(
        //                               color: baseColorText,
        //                             ),
        //                             textDirection: TextDirection.rtl,
        //                           ),
        //                           clearButton: Icon(
        //                             Icons.clear,
        //                             color: baseColor,
        //                           ),
        //                           dropDownButton: Icon(
        //                             Icons.arrow_drop_down,
        //                             color: baseColor,
        //                           ),
        //                         ),

        //                         //////////
        //                         ///
        //                         ///
        //                         DropdownSearch<dynamic>(
        //                           popupBackgroundColor: BackGWhiteColor,
        //                           key: UniqueKey(),
        //                           items: _MainDepartmentEmployees,
        //                           popupItemBuilder:
        //                               (context, rr, isSelected) => (Container(
        //                             margin: EdgeInsets.only(top: 10),
        //                             child: Column(
        //                               children: [
        //                                 Text(rr.EmployeeName,
        //                                     style: subtitleTx(baseColorText))
        //                               ],
        //                             ),
        //                           )),
        //                           dropdownBuilder: (context, selectedItem) =>
        //                               Container(
        //                             child: selectedItem == null
        //                                 ? null
        //                                 : Text(
        //                                     selecteditem == null
        //                                         ? ""
        //                                         : selecteditem ?? "",
        //                                     style: TextStyle(
        //                                         fontSize: 16,
        //                                         color: baseColorText)),
        //                           ),
        //                           dropdownBuilderSupportsNullItem: true,
        //                           selectedItem: selecteditem == null
        //                               ? null
        //                               : selecteditem,
        //                           showSelectedItems: false,
        //                           mode: Mode.BOTTOM_SHEET,
        //                           showClearButton:
        //                               _ReplaceEmployeeNumber == null
        //                                   ? false
        //                                   : true,
        //                           maxHeight: 400,
        //                           showAsSuffixIcons: true,
        //                           itemAsString: (item) =>
        //                               item?.EmployeeName ?? "",
        //                           dropdownSearchDecoration: InputDecoration(
        //                             // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        //                             labelText: "الموظف البديل",
        //                             labelStyle:
        //                                 TextStyle(color: secondryColorText),
        //                             errorStyle: TextStyle(color: redColor),
        //                             contentPadding: EdgeInsets.symmetric(
        //                                 vertical: responsiveMT(8, 30),
        //                                 horizontal: 10.0),
        //                             border: OutlineInputBorder(
        //                               borderRadius:
        //                                   BorderRadius.circular(4.0),
        //                               borderSide: BorderSide(
        //                                   color: errormessege2
        //                                       ? redColor
        //                                       : bordercolor),
        //                             ),
        //                             enabledBorder: OutlineInputBorder(
        //                               borderSide: BorderSide(
        //                                   color: errormessege2
        //                                       ? redColor
        //                                       : bordercolor),
        //                               borderRadius: BorderRadius.circular(4),
        //                             ),
        //                             focusedBorder: OutlineInputBorder(
        //                               borderSide: BorderSide(
        //                                   color: errormessege2
        //                                       ? redColor
        //                                       : bordercolor),
        //                               borderRadius: BorderRadius.circular(4),
        //                             ),
        //                           ),
        //                           validator: (value) {
        //                             if (value == "" || value == null) {
        //                               return "الرجاء إختيار الموظف البديل";
        //                             } else {
        //                               return null;
        //                             }
        //                           },
        //                           showSearchBox: true,
        //                           onChanged: (v) {
        //                             try {
        //                               _ReplaceEmployeeNumber =
        //                                   v?.EmployeeNumber;

        //                               print(v?.EmployeeNumber.toString());
        //                               selecteditem = v.EmployeeName;
        //                               //setState(() {});
        //                             } catch (e) {}
        //                           },
        //                           popupTitle: Container(
        //                             height: 60,
        //                             decoration: BoxDecoration(
        //                               color: secondryColor,
        //                               borderRadius: const BorderRadius.only(
        //                                 topLeft: Radius.circular(20),
        //                                 topRight: Radius.circular(20),
        //                               ),
        //                             ),
        //                             child: Center(
        //                               child: Text(
        //                                 "الموظف البديل",
        //                                 style: TextStyle(
        //                                   fontSize: 24,
        //                                   fontWeight: FontWeight.bold,
        //                                   color: Colors.white,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           popupShape: const RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.only(
        //                               topLeft: Radius.circular(24),
        //                               topRight: Radius.circular(24),
        //                             ),
        //                           ),
        //                           emptyBuilder: (context, searchEntry) =>
        //                               Center(
        //                             child: Text(
        //                               "لا يوجد بيانات",
        //                               style: TextStyle(
        //                                 color: baseColorText,
        //                               ),
        //                             ),
        //                           ),
        //                           searchFieldProps: TextFieldProps(
        //                             textAlign: TextAlign.right,
        //                             decoration: formlabel1(""),
        //                             style: TextStyle(
        //                               color: baseColorText,
        //                             ),
        //                             textDirection: TextDirection.rtl,
        //                           ),
        //                           clearButton: Icon(
        //                             Icons.clear,
        //                             color: baseColor,
        //                           ),
        //                           dropDownButton: Icon(
        //                             Icons.arrow_drop_down,
        //                             color: baseColor,
        //                           ),
        //                         ),

        //                         errormessege2 == true
        //                             ? Text(
        //                                 "الرجاء الاختيار الموظف البديل",
        //                                 style: TextStyle(
        //                                   fontSize: 10,
        //                                   color: redColor,
        //                                 ),
        //                               )
        //                             : Container(),

        //                         SizedBox(
        //                           height: 5,
        //                         ),
        //                         if (sharedPref.getInt("empTypeID") != 8)
        //                           Row(
        //                             children: [
        //                               Expanded(
        //                                 child: Text(
        //                                   "إعطاء البدیل صلاحیات التوقیع بالانابة في نظام المعاملات ؟",
        //                                   style: descTx1(baseColorText),
        //                                   maxLines: 3,
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: 2,
        //                               ),
        //                               ToggleSwitch(
        //                                 radiusStyle: true,
        //                                 borderWidth: 1,
        //                                 borderColor: [bordercolor],
        //                                 inactiveBgColor: BackGColor,
        //                                 inactiveFgColor: baseColorText,
        //                                 minWidth: 50.0,
        //                                 minHeight: 35,
        //                                 initialLabelIndex:
        //                                     ToggleSwitchindex == -1
        //                                         ? null
        //                                         : ToggleSwitchindex,
        //                                 activeBgColor: [baseColor],
        //                                 totalSwitches: 2,
        //                                 labels: ['نعم', 'لا'],
        //                                 onToggle: (index) {
        //                                   int indexS = index as int;
        //                                   _SignatureApproval =
        //                                       _SignatureApprovalFlag[indexS]
        //                                           ["SignatureApprovalFlag"];

        //                                   ToggleSwitchindex =
        //                                       _SignatureApprovalFlag[indexS]
        //                                           ["index"];

        //                                   print(
        //                                       'switched to: $_SignatureApproval');
        //                                 },
        //                               ),
        //                             ],
        //                           ),
        //                         errormessege == true
        //                             ? Text(
        //                                 "هل توافق أم لا؟... الرجاء الاختيار",
        //                                 style: TextStyle(
        //                                   fontSize: 10,
        //                                   color: redColor,
        //                                 ),
        //                               )
        //                             : Container(),
        //                         if (sharedPref.getInt("empTypeID") != 8)
        //                           SizedBox(
        //                             height: 5,
        //                           ),

        //                       ]),
        //                   if (sharedPref.getInt("empTypeID") != 8)
        //                     SizedBox(
        //                       height: 10,
        //                     ),
        //                   TextFormField(
        //                     controller: _note,
        //                     keyboardType: TextInputType.text,
        //                     maxLines: 3,
        //                     style: TextStyle(color: baseColorText),
        //                     decoration: formlabel1("ملاحظات"),
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Align(
        //                     alignment: Alignment.bottomCenter,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       children: [
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         widgetsUni.actionbutton(
        //                           'الطلبات السابقة',
        //                           Icons.history,
        //                           () {
        //                             Navigator.pushNamed(
        //                                 context, "/vacation_old_request");
        //                           },
        //                         ),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         widgetsUni.actionbutton(
        //                           'تنفيذ',
        //                           Icons.send,
        //                           () {
        //                             // Validate returns true if the form is valid, or false otherwise.
        //                             if (_SignatureApproval == null &&
        //                                 sharedPref.getInt("empTypeID") != 8) {
        //                               setState(() {
        //                                 errormessege = true;
        //                               });
        //                               Alerts.errorAlert(context, "خطأ",
        //                                       "يرجى الاختيار الرغبة بإعطاء الموظف البديل صلاحية")
        //                                   .show();
        //                             } else {
        //                               setState(() {
        //                                 errormessege = false;
        //                               });
        //                             }
        //                             ////
        //                             if (_ReplaceEmployeeNumber == null) {
        //                               setState(() {
        //                                 errormessege2 = true;
        //                               });
        //                             } else {
        //                               setState(() {
        //                                 errormessege2 = false;
        //                               });
        //                             }
        //                             if (_formKey.currentState!.validate() &&
        //                                 _SignatureApproval != null &&
        //                                 _ReplaceEmployeeNumber != null) {

        //                               InsertVacationRequest();
        //                             }
        //                             if (sharedPref.getInt("empTypeID") == 8 &&
        //                                 _ReplaceEmployeeNumber != null &&
        //                                 _formKey.currentState!.validate()) {
        //                               InsertVacationRequest();
        //                             }
        //                           },
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),

        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  void validateSelection() {
    setState(() {
      showError = _SignatureApproval == null;
    });
  }

  void validateAttachment() {
    setState(() {
      showAttachmentError = fileBytes == null;
    });
  }
}
