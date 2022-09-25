import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sizer/sizer.dart';

class bunud extends StatefulWidget {
  bunud(
      {required this.next,
      required this.back,
      required this.vaiolationModel,
      Key? key})
      : super(key: key);
  Function next;
  Function back;
  VaiolationModel vaiolationModel;

  @override
  State<bunud> createState() => _bunudState();
}

class _bunudState extends State<bunud> with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  List violationtype = [
    {'_violationTypeID': 1, '_violationTypeName': "مخالفة طرق"}
  ];
  var _violationTypeID;
  var _violationTypeName;

  List bunudtype = [
    {
      '_bunudTypeID': 1,
      '_bunudTypeName': "عدم وجود اسم المقاول على صبات الحماية"
    }
  ];
  var _bunudTypeID;
  var _bunudTypeName;

  List bunudvaluetype = [];
  var _bunudvalueTypeID;
  var _bunudvalueTypeName;

  bool checkbox = false;

  List bunudTable = [
    {
      '_violationTypeID': 1,
      '_violationTypeName': "مخالفة طرق",
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-عدم تسجيل المنشأة-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_bunudvalue': 5000,
      '_bunudloop': 1,
      'total': 5000
    },
    {
      '_violationTypeID': 1,
      '_violationTypeName': "مخالفة طرق",
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_bunudvalue': 5000,
      '_bunudloop': 1,
      'total': 5000
    },
    {
      '_violationTypeID': 1,
      '_violationTypeName': "مخالفة طرق",
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_bunudvalue': 5000,
      '_bunudloop': 1,
      'total': 5000
    },
  ];

  num generaltotal = 15000;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
              child: Column(
                children: [
                  Row(
                    children: [
                      widgetsUni.actionbutton("رجوع", Icons.next_plan, () {
                        widget.back();
                      }),
                    ],
                  ),
                  Text(
                    "البنود",
                    style: titleTx(baseColor),
                  ),
                  DropdownSearch<dynamic>(
                    items: violationtype,
                    popupBackgroundColor: BackGWhiteColor,
                    popupItemBuilder: (context, rr, isSelected) => (Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(rr["_violationTypeName"].toString(),
                              style: subtitleTx(baseColorText))
                        ],
                      ),
                    )),
                    dropdownBuilder: (context, selectedItem) => Container(
                      decoration: null,
                      child: selectedItem == null
                          ? null
                          : Text(
                              selectedItem == null
                                  ? ""
                                  : selectedItem["_violationTypeName"] ?? "",
                              style: TextStyle(
                                  fontSize: 16, color: baseColorText)),
                    ),
                    dropdownBuilderSupportsNullItem: true,
                    mode: Mode.BOTTOM_SHEET,
                    showClearButton: _violationTypeID == null ? false : true,
                    maxHeight: 400,
                    showAsSuffixIcons: true,
                    dropdownSearchDecoration: formlabel1("نوع المخالفة"),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "يرجى إختيار نوع المخالفة";
                      } else {
                        return null;
                      }
                    },
                    showSearchBox: true,
                    onChanged: (v) {
                      try {
                        setState(() {
                          print(v);
                          _violationTypeID = v["_violationTypeID"];
                          _violationTypeName = v["_violationTypeName"];
                        });
                        print('object');
                        print(v["_violationTypeID"]);
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
                          "نوع المخالفة",
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
                    controller: widget.vaiolationModel.comment.violationDate,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    readOnly: true,
                    // keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    decoration: formlabel1("تاریخ المخالفة"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'فضلاً أدخل تاریخ المخالفة';
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
                          minTime: DateTime(2021, 3, 5), onChanged: (date) {
                        widget.vaiolationModel.comment.violationDate.text =
                            date.toString().split(" ")[0];
                        print('change $date');
                      }, onConfirm: (date) {
                        widget.vaiolationModel.comment.violationDate.text =
                            date.toString().split(" ")[0];
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.ar);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (_violationTypeID == 1)
                    Row(
                      children: [
                        Checkbox(
                          value: checkbox,
                          onChanged: (v) {
                            setState(() {
                              checkbox = v!;
                              print(v);
                            });
                          },
                        ),
                        Text(
                          "إظهار بيانات إضافية",
                          style: descTx1(baseColorText),
                        ),
                      ],
                    ),
                  if (checkbox == true)
                    Container(
                      child: Table(
                        border: TableBorder.all(color: bordercolor),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth(),

                          // 2: FixedColumnWidth(64),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Container(
                                color: baseColor,
                                child: Center(
                                  child: Text(
                                    "البيانات",
                                    style: descTx1(Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                color: baseColor,
                                child: Center(
                                  child: Text(
                                    "القيمة",
                                    style: descTx1(Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "عنوان المخالفة",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "نوع المركبة",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "رقم الهيكل",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "رقم  لوحة المركبة (في حال مخالفة المركبات)",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "إضافة رقم هوية الكفيل",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text(
                                "أسم كفيل المخالف (في حال كان المخالف أجنبي)",
                                style: descTx1(baseColorText),
                                textAlign: TextAlign.center,
                              ),
                              TextField(
                                style: TextStyle(
                                  color: baseColorText,
                                ),
                                decoration: formlabel1(""),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownSearch<dynamic>(
                    items: bunudtype,
                    popupBackgroundColor: BackGWhiteColor,
                    popupItemBuilder: (context, rr, isSelected) => (Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(rr["_bunudTypeName"].toString(),
                              style: subtitleTx(baseColorText))
                        ],
                      ),
                    )),
                    dropdownBuilder: (context, selectedItem) => Container(
                      decoration: null,
                      child: selectedItem == null
                          ? null
                          : Text(
                              selectedItem == null
                                  ? ""
                                  : selectedItem["_bunudTypeName"] ?? "",
                              style: TextStyle(
                                  fontSize: 16, color: baseColorText)),
                    ),
                    dropdownBuilderSupportsNullItem: true,
                    mode: Mode.BOTTOM_SHEET,
                    showClearButton: _bunudTypeID == null ? false : true,
                    maxHeight: 400,
                    showAsSuffixIcons: true,
                    dropdownSearchDecoration: formlabel1("نوع البند"),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "يرجى إختيار نوع البند";
                      } else {
                        return null;
                      }
                    },
                    showSearchBox: true,
                    onChanged: (v) {
                      try {
                        setState(() {
                          print(v);
                          _bunudTypeID = v["_bunudTypeID"];
                          _bunudTypeName = v["_bunudTypeName"];
                          widget.vaiolationModel.comment.unit.text = "للتصريح";
                        });
                        print('object');
                        print(v["_bunudTypeID"]);
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
                          "نوع النبد",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: widget.vaiolationModel.comment.unit,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: baseColorText),
                          decoration: formlabel1("الوحدة"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'خطأ';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: widget.vaiolationModel.comment.repetition,
                          style: TextStyle(color: baseColorText),
                          decoration: formlabel1("العدد /\ التكرار"),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال العدد';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //here need if stutment to change the bunudvalue
                  TextFormField(
                    controller: widget.vaiolationModel.comment.bunudvalue,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: baseColorText),
                    decoration: formlabel1("القيمة المطبقة"),
                    enabled: true,
                    // inputFormatters: <TextInputFormatter>[ 1983
                    //                 FilteringTextInputFormatter.digitsOnly
                    //               ],
                    //               keyboardType: TextInputType.number,
                    maxLines: 1,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال القيمة المطبقة';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //here need if stutment to change the bunudvalue
                  if (false)
                    DropdownSearch<dynamic>(
                      items: bunudvaluetype,
                      popupBackgroundColor: BackGWhiteColor,
                      popupItemBuilder: (context, rr, isSelected) => (Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(rr["_bunudvalueTypeName"].toString(),
                                style: subtitleTx(baseColorText))
                          ],
                        ),
                      )),
                      dropdownBuilder: (context, selectedItem) => Container(
                        decoration: null,
                        child: selectedItem == null
                            ? null
                            : Text(
                                selectedItem == null
                                    ? ""
                                    : selectedItem["_bunudvalueTypeName"] ?? "",
                                style: TextStyle(
                                    fontSize: 16, color: baseColorText)),
                      ),
                      dropdownBuilderSupportsNullItem: true,
                      mode: Mode.BOTTOM_SHEET,
                      showClearButton: _violationTypeID == null ? false : true,
                      maxHeight: 400,
                      showAsSuffixIcons: true,
                      dropdownSearchDecoration: formlabel1("القيمة المطبقة"),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "يرجى إختيار القيمة المطبقة";
                        } else {
                          return null;
                        }
                      },
                      showSearchBox: true,
                      onChanged: (v) {
                        try {
                          setState(() {
                            print(v);
                            _bunudvalueTypeID = v["_bunudvalueTypeID"];
                            _bunudvalueTypeName = v["_bunudvalueTypeName"];
                          });
                          print('object');
                          print(v["_bunudvalueTypeID"]);
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
                            "القيمة المطبقة",
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
                  Row(
                    children: [
                      widgetsUni.actionbutton(
                        'إضافة البند',
                        Icons.add,
                        () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _bunudTypeID = 3;
                              var contain = bunudTable.where((element) =>
                                  element['_bunudTypeID'] == _bunudTypeID);
                              if (contain.isEmpty) {
                                bunudTable.add({
                                  '_violationTypeID': 1,
                                  '_violationTypeName': "مخالفة طرق",
                                  '_bunudTypeID': _bunudTypeID,
                                  '_bunudTypeName': _bunudTypeName,
                                  '_unit':
                                      widget.vaiolationModel.comment.unit.text,
                                  '_bunudvalue': widget
                                      .vaiolationModel.comment.bunudvalue.text,
                                  '_bunudloop': widget
                                      .vaiolationModel.comment.repetition.text,
                                  'total': int.parse(widget.vaiolationModel
                                          .comment.bunudvalue.text) *
                                      int.parse(widget.vaiolationModel.comment
                                          .repetition.text)
                                });
                                generaltotal += int.parse(widget.vaiolationModel
                                        .comment.bunudvalue.text) *
                                    int.parse(widget.vaiolationModel.comment
                                        .repetition.text);
                              } else {
                                Alerts.warningAlert(context, "تنبيه",
                                        "تم إضافة البند مسبقاً")
                                    .show();
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  bunudTable.length > 0
                      ? ListView.builder(
                          primary: false,
                          itemCount: bunudTable.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // generaltotal = generaltotal + bunudTable[index]['total'];

                            return Container(
                              height: 70,
                              child: Card(
                                color: BackGWhiteColor,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: bordercolor),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: ListTile(
                                  minLeadingWidth: 10,
                                  leading: Text(
                                      bunudTable[index]['_bunudloop']
                                              .toString() +
                                          "×",
                                      style: subtitleTx(secondryColor)),
                                  title: Text(
                                    bunudTable[index]['_bunudTypeName']
                                                .length >=
                                            22
                                        ? bunudTable[index]['_bunudTypeName']
                                                .toString()
                                                .substring(0, 25) +
                                            " ..."
                                        : bunudTable[index]['_bunudTypeName'],
                                    maxLines: 1,
                                    style: descTx1(baseColorText),
                                  ),
                                  subtitle: Text(
                                    bunudTable[index]['_unit'],
                                    style: descTx2(baseColorText),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        bunudTable[index]['total'].toString(),
                                        style: descTx1(baseColorText),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        icon: const Icon(Icons.delete),
                                        color: redColor,
                                        onPressed: () {
                                          setState(() {
                                            generaltotal -=
                                                bunudTable[index]['total'];
                                            bunudTable.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                            );
                            //  Column(
                            //   children: [
                            //     Container(
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
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         children: [
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               Column(
                            //                 children: [
                            //                   Text(
                            //                     "اسم  البند",
                            //                     style: subtitleTx(baseColor),
                            //                   ),
                            //                   Text(
                            //                     bunudTable[index]['_bunudTypeName'],
                            //                     style: descTx2(baseColorText),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //           widgetsUni.divider(),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               Column(
                            //                 children: [
                            //                   Text(
                            //                     "القيمة المطبقة",
                            //                     style: subtitleTx(baseColor),
                            //                   ),
                            //                   Text(
                            //                     bunudTable[index]['_bunudvalue']
                            //                         .toString(),
                            //                     style: descTx2(baseColorText),
                            //                   )
                            //                 ],
                            //               ),
                            //               Column(
                            //                 children: [
                            //                   Text(
                            //                     "العدد",
                            //                     style: subtitleTx(baseColor),
                            //                   ),
                            //                   Text(
                            //                     bunudTable[index]['_bunudloop']
                            //                         .toString(),
                            //                     style: descTx2(baseColorText),
                            //                   ),
                            //                 ],
                            //               ),
                            //               Column(
                            //                 children: [
                            //                   Text(
                            //                     "المجموع",
                            //                     style: subtitleTx(baseColor),
                            //                   ),
                            //                   Text(
                            //                     bunudTable[index]['total'].toString(),
                            //                     style: descTx2(baseColorText),
                            //                   )
                            //                 ],
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 10,
                            //     )
                            //   ],
                            // );
                          },
                        )
                      : Container(
                          height: 70,
                          width: 100.w,
                          child: Card(
                            child: Center(
                              child: Text(
                                "لا توجد بنود",
                                style: subtitleTx(baseColorText),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "الاجمالي العام",
                        style: subtitleTx(baseColor),
                      ),
                      Text(
                        generaltotal.toString(),
                        style: subtitleTx(baseColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      widgetsUni.actionbutton("تالي", Icons.arrow_forward, () {
                        if (bunudTable.isNotEmpty) {
                          widget.next();
                        } else {
                          Alerts.errorAlert(context, "خطأ",
                                  "الرجاء إضافة بند واحد على الاقل")
                              .show();
                        }
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
