import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';

class bunud extends StatefulWidget {
  const bunud({Key? key}) : super(key: key);

  @override
  State<bunud> createState() => _bunudState();
}

class _bunudState extends State<bunud> {
  final _formKey = GlobalKey<FormState>();

  List violationtype = [];
  var _violationTypeID;
  var _violationTypeName;

  List bunudtype = [];
  var _bunudTypeID;
  var _bunudTypeName;

  TextEditingController _unit = TextEditingController();
  TextEditingController _boundloop = TextEditingController();
  TextEditingController _boundvalue = TextEditingController();

  List bunudTable = [
    {
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-دم تسجيل المنشأة-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_boundvalue': 5000,
      '_boundloop': 1,
      'total': 5000
    },
    {
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_boundvalue': 5000,
      '_boundloop': 1,
      'total': 5000
    },
    {
      '_bunudTypeID': 1,
      '_bunudTypeName': '1-عدم تسجيل المنشأة',
      '_unit': 'لا توجد',
      '_boundvalue': 5000,
      '_boundloop': 1,
      'total': 5000
    },
  ];

  num generaltotal = 0;

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _unit,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: baseColorText),
                          decoration: formlabel1("الوحدة"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _boundloop,
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: baseColorText),
                          decoration: formlabel1("العدد \ التكرار"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //here need if stutment to change the bunudvalue
                  TextFormField(
                    controller: _boundvalue,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: baseColorText),
                    decoration: formlabel1("القيمة المطبقة"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      widgetsUni.actionbutton(
                        'إضافة البند',
                        Icons.add,
                        () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    primary: false,
                    itemCount: bunudTable.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      generaltotal = generaltotal + bunudTable[index]['total'];

                      return Container(
                        height: 70,
                        child: Card(
                          child: ListTile(
                            minLeadingWidth: 10,
                            leading: Text(
                                bunudTable[index]['_boundloop'].toString() +
                                    "×",
                                style: subtitleTx(baseColor)),
                            title: Text(
                              bunudTable[index]['_bunudTypeName'],
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
                                Icon(Icons.delete),
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
                      //                     bunudTable[index]['_boundvalue']
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
                      //                     bunudTable[index]['_boundloop']
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
