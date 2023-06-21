import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/events/event_comments.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

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

  List<XFile>? images;
  final ImagePicker _picker = ImagePicker();
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
              "EmployeeNumber": int.parse(EmployeeProfile.getEmployeeNumber()),
              "SocialTypeId": _eventID,
              "SocialOccurredDate": _dateFrom.text,
              "SocialEmployeeNote": _note.text,
              "CreationtypeID": 1,
              "RelativeID": _relativesID,
              "DegreeID": _degreesID,
              "UserNumber": int.parse(EmployeeProfile.getEmployeeNumber())
            }));
        if (jsonDecode(reponse.body)["StatusCode"] == 400) {
          Alerts.successAlert(context, "", "تم إرسال الطلب").show();
        } else {
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
    var respose = await getAction("Ens/GetOccasionsTypes");
    print(respose.body);

    eventsType = jsonDecode(respose.body)["OccasionsTypeVMs"] ?? [];
    EasyLoading.dismiss();
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
                            // Text(
                            //   "إضافة المرفقات",
                            //   style: titleTx(baseColor),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     Container(
                            //       height: 70,
                            //       width: 70,
                            //       decoration: BoxDecoration(
                            //         color: BackGWhiteColor,
                            //         border: Border.all(
                            //           color: bordercolor,
                            //         ),
                            //         //color: baseColor,
                            //         borderRadius: BorderRadius.all(
                            //           new Radius.circular(4),
                            //         ),
                            //       ),
                            //       child: IconButton(
                            //         padding: EdgeInsets.zero,
                            //         constraints: BoxConstraints(),
                            //         icon: const Icon(Icons.image),
                            //         color: baseColor,
                            //         onPressed: () async {
                            //           //from gallary
                            //           images = await _picker.pickMultiImage(
                            //             imageQuality: 100,
                            //             maxHeight: 1440,
                            //             maxWidth: 1440,
                            //           );
                            //           print(images);
                            //           if (images != null) {
                            //             for (int i = 0;
                            //                 i < images!.length;
                            //                 i++) {
                            //               final imageTemp =
                            //                   File(images![i].path);
                            //               var base64 = base64Encode(
                            //                   await imageTemp.readAsBytes());
                            //               int sizeInBytes =
                            //                   imageTemp.lengthSync();
                            //               double sizeInMb =
                            //                   sizeInBytes / (1024 * 1024);
                            //               print(sizeInMb);
                            //               listofimage.add({
                            //                 'path': images![i].path,
                            //                 'type':
                            //                     images![i].name.split(".").last,
                            //                 'name': images![i].name,
                            //                 'base64': base64,
                            //                 'size': sizeInMb
                            //               });
                            //             }

                            //             setState(() {});
                            //           } else {
                            //             return;
                            //           }
                            //         },
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              width: 10,
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
                                        InsertEvent();
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
