import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/HR/MainDepartmentEmployees.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class EventRequest extends StatefulWidget {
  const EventRequest({Key? key}) : super(key: key);

  @override
  State<EventRequest> createState() => _EventRequestState();
}

class _EventRequestState extends State<EventRequest> {
  List eventsType = [];
  List relatives = [];
  List degrees = [];
  var _eventID;
  var _relativesID = null;
  var _degreesID = null;
  final _formKey = GlobalKey<FormState>();

  var _EmployeeNumber = null;
  String? _EmployeeName = null;

  late List<MainDepartmentEmployees> _MainDepartmentEmployees = [];
  EmployeeProfile empinfo = new EmployeeProfile();

  var images;

  String? fileName;
  String? fileBytes;
  String? filePath;

  List listofimage = [];

  TextEditingController _dateFrom = TextEditingController();
  TextEditingController _note = TextEditingController();

  int i = 1;

  @override
  void initState() {
    super.initState();

    geteventsdata();
  }

  void InsertEvent() async {
    Alerts.confirmAlrt(context, "رسالة تأكيد", "هل تريد إرسال الطلب ؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: '... جاري المعالجة',
          maskType: EasyLoadingMaskType.black,
        );
        var reponse = await postAction(
            "Ens/InsertOccasionOrder",
            jsonEncode({
              "EmployeeNumber": _EmployeeNumber == null
                  ? int.parse(EmployeeProfile.getEmployeeNumber())
                  : int.parse(_EmployeeNumber.toString().split(".")[0]),
              "SocialTypeId": _eventID,
              "SocialOccurredDate": _dateFrom.text,
              "SocialEmployeeNote": _note.text,
              "CreationtypeID": _EmployeeNumber == null ? 1 : 2,
              "RelativeID": _relativesID,
              "DegreeID": _degreesID,
              "UserNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
              "FileBytes": fileBytes,
              "FileName": fileName,
            }));
        logApiModel logapiO = logApiModel();
        logapiO.ControllerName = "Ens";
        logapiO.ClassName = "InsertOccasionOrder";
        logapiO.ActionMethodName = "تقديم طلب مناسبة";
        logapiO.ActionMethodType = 2;

        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          logapiO.StatusCode = 1;
          logApi(logapiO);
          Alerts.successAlert(context, "", "تم إرسال الطلب").show();
        } else {
          logapiO.StatusCode = 0;
          logapiO.ErrorMessage = jsonDecode(reponse.body)["ErrorMessage"];
          logApi(logapiO);
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(reponse.body)["ErrorMessage"])
              .show();
        }

        EasyLoading.dismiss();
      }
    });
  }

  void getrelativesORdegrees(int id) async {
    if ((id == 3 || id == 5) && relatives.length == 0) {
      //مولود + وفاه
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      var respose = await getAction("Ens/GetRelatives");
      print(respose.body);

      relatives = jsonDecode(respose.body)["RelativeVMs"] ?? [];
      EasyLoading.dismiss();
    }
    if (id == 4 && degrees.length == 0) {
      //درجة العلمية
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      var respose = await getAction("Ens/GetDegrees");
      print(respose.body);

      degrees = jsonDecode(respose.body)["DegreeVMs"] ?? [];
      EasyLoading.dismiss();
    }
    setState(() {});
  }

  void geteventsdata() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    await getuserinfo();
    if (sharedPref.getBool("IsGeneralManager") == true) {
      var respose1 = await getAction("HR/GetAllEmployeesByManagerNumber/" +
          EmployeeProfile.getEmployeeNumber());
      // print(empinfo.MainDepartmentID.toString());
      //print("respose = " + respose.toString());
      try {
        if (jsonDecode(respose1.body)["EmpInfo"] != null) {
          _MainDepartmentEmployees =
              (jsonDecode(respose1.body)["EmpInfo"] as List)
                  .map(((e) => MainDepartmentEmployees.fromJson(e)))
                  .toList();

          //print(_MainDepartmentEmployees[0].EmployeeName);
          setState(() {});
        }
        EasyLoading.dismiss();
      } catch (Ex) {
        EasyLoading.dismiss();
      }
    }

    var respose = await getAction("Ens/GetOccasionsTypes");
    // print(respose.body);

    eventsType = jsonDecode(respose.body)["OccasionsTypeVMs"] ?? [];

    EasyLoading.dismiss();
    setState(() {});
  }

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          //  backgroundColor: Colors.transparent,

          appBar: AppBarW.appBarW("طلب تقديم مناسبة", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            if (sharedPref.getBool("IsGeneralManager") == true)
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
                                          style: subtitleTx(baseColorText))
                                    ],
                                  ),
                                )),
                                dropdownBuilder: (context, selectedItem) =>
                                    Container(
                                  child: selectedItem == null
                                      ? null
                                      : Text(
                                          _EmployeeName == null
                                              ? ""
                                              : _EmployeeName ?? "",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: baseColorText)),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                selectedItem: _EmployeeName == null
                                    ? null
                                    : _EmployeeName,
                                showSelectedItems: false,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton:
                                    _EmployeeNumber == null ? false : true,

                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                itemAsString: (item) =>
                                    item?.EmployeeName ?? "",
                                dropdownSearchDecoration: formlabel1("الموظف"),
                                // validator: (value) {
                                //   if (value == "" || value == null) {
                                //     return "الرجاء إختيار الموظف";
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    _EmployeeNumber = v?.EmployeeNumber;

                                    print(v?.EmployeeNumber.toString());
                                    _EmployeeName = v.EmployeeName;
                                    // if (v?.EmployeeNumber == null) {
                                    //   _EmployeeName = null;
                                    // }
                                    setState(() {});
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
                                      "الموظف",
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
                              items: eventsType,
                              popupBackgroundColor: BackGWhiteColor,
                              popupItemBuilder: (context, rr, isSelected) =>
                                  (Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Text(rr["OccasionTypeName"].toString(),
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
                                                    "OccasionTypeName"] ??
                                                "",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: baseColorText)),
                              ),
                              dropdownBuilderSupportsNullItem: true,
                              mode: Mode.BOTTOM_SHEET,
                              showClearButton: _eventID == null ? false : true,
                              maxHeight: 400,
                              showAsSuffixIcons: true,
                              dropdownSearchDecoration:
                                  formlabel1("نوع المناسبة"),
                              validator: (value) {
                                if (value == "" || value == null) {
                                  return "يرجى إختيار نوع المناسبة";
                                } else {
                                  return null;
                                }
                              },
                              showSearchBox: true,
                              onChanged: (v) {
                                try {
                                  setState(() {
                                    print(v);
                                    _eventID = v["OccasionTypeID"];
                                  });
                                  // _degreesID = null;
                                  // _relativesID = null;
                                  getrelativesORdegrees(_eventID);

                                  setState(() {});
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
                                    "نوع المناسبة",
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
                            if (_eventID == 3 || _eventID == 5)
                              DropdownSearch<dynamic>(
                                items: relatives,
                                popupBackgroundColor: BackGWhiteColor,
                                popupItemBuilder: (context, rr, isSelected) =>
                                    (Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(rr["RelativeNameArabic"].toString(),
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
                                                      "RelativeNameArabic"] ??
                                                  "",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: baseColorText)),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton:
                                    _relativesID == null ? false : true,
                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                dropdownSearchDecoration:
                                    formlabel1("صلة القرابة"),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "يرجى إختيار صلة القرابة";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      print(v);
                                      _relativesID = v["RelativeID"];
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
                                      "صلة القرابة",
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
                            if (_eventID == 3 || _eventID == 5)
                              SizedBox(
                                height: 10,
                              ),
                            if (_eventID == 4)
                              DropdownSearch<dynamic>(
                                items: degrees,
                                popupBackgroundColor: BackGWhiteColor,
                                popupItemBuilder: (context, rr, isSelected) =>
                                    (Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text(rr["DegreeNameArabic"].toString(),
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
                                                      "DegreeNameArabic"] ??
                                                  "",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: baseColorText)),
                                ),
                                dropdownBuilderSupportsNullItem: true,
                                mode: Mode.BOTTOM_SHEET,
                                showClearButton:
                                    _degreesID == null ? false : true,
                                maxHeight: 400,
                                showAsSuffixIcons: true,
                                dropdownSearchDecoration:
                                    formlabel1("درجة العلمية"),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "يرجى إختيار درجة العلمية";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      print(v);
                                      _degreesID = v["DegreeID"];
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
                                      "درجة العلمية",
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
                            if (_eventID == 4)
                              SizedBox(
                                height: 10,
                              ),
                            TextFormField(
                              controller: _dateFrom,
                              style: TextStyle(color: baseColorText),
                              readOnly: true,
                              // keyboardType: TextInputType.datetime,
                              maxLines: 1,
                              decoration: formlabel1("تاريخ المناسبة"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إختيار تاريخ المحدد';
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
                                  _dateFrom.text =
                                      date.toString().split(" ")[0];
                                  print('change $date');
                                }, onConfirm: (date) {
                                  _dateFrom.text =
                                      date.toString().split(" ")[0];
                                  print('confirm $date');
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.ar);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "إضافة المرفقات",
                              style: titleTx(baseColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    images = await Pickattachments.pickFile(
                                        ["pdf", "png", "jpeg", "jpg"]);

                                    print(images);

                                    if (images["size"] < 2000000) {
                                      filePath = images["path"];
                                      fileName = images["name"];
                                      fileBytes = images["base64"];
                                    } else {
                                      Alerts.warningAlert(context, "حجم الملف",
                                              "يجب ان لا يزيد حجم الملف عن 2 ميجابايت ")
                                          .show();
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
                                              Center(child: Text("صورة")),
                                            ],
                                          )
                                        : images["type"] == "pdf"
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: BackGWhiteColor,
                                                  border: Border.all(
                                                    color: bordercolor,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.picture_as_pdf,
                                                  color: baseColor,
                                                  size: 50,
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: BackGWhiteColor,
                                                  border: Border.all(
                                                    color: bordercolor,
                                                  ),
                                                ),
                                                child: Image.file(
                                                  File(filePath.toString()),
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                            if (images == null && _eventID == 4)
                              Text("يرجى ارفاق ملف", style: descTx2(redColor)),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              maxLength: 300,
                              style: TextStyle(color: baseColorText),
                              controller: _note,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              decoration: formlabel1("ملاحظات"),
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'يرجى كتابة ملاحظة';
                              //   } else if (value.length < 15) {
                              //     return 'الرجاء إدخال أكثر من ١٥ حرف';
                              //   }
                              //   return null;
                              // },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  widgetsUni.actionbutton(
                                    'إرسال',
                                    Icons.send,
                                    () {
                                      if (_formKey.currentState!.validate()) {
                                        if (images == null && _eventID == 4) {
                                          Alerts.warningAlert(context, "مرفقات",
                                                  "يرجى ارفاق صورة")
                                              .show();
                                        } else {
                                          InsertEvent();
                                        }
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
              ),
            ],
          )),
    );
  }
}
