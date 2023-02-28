import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class Momten extends StatefulWidget {
  const Momten({Key? key}) : super(key: key);

  @override
  State<Momten> createState() => _MomtenState();
}

class _MomtenState extends State<Momten> {
  dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBarW.appBarW("مُمْتَنّ", context, null),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("إلى", style: descTx1(baseColorText)),
                            SizedBox(
                              width: 8,
                            ),
                            Flexible(
                              child: DropdownSearch<dynamic>(
                                items: null,
                                popupBackgroundColor: BackGWhiteColor,
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
                                    formlabel1("اختر الشخص"),
                                validator: (value) {
                                  if (value == "" || value == null) {
                                    return "يرجى اختيار الشخص";
                                  } else {
                                    return null;
                                  }
                                },
                                showSearchBox: true,
                                onChanged: (v) {
                                  try {
                                    setState(() {
                                      print(v);
                                      // _VacationTypeID = v["VacationID"];
                                      // VacationTypeName =
                                      //     v["VacationTypeName"];
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
                                      "اختر الشحص",
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
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "مع شكري لما اظهرته من :",
                          style: descTx1(baseColorText),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: ListTile(
                                title: Text(
                                  "الإيجابية",
                                  style: descTx1(baseColorText),
                                ),
                                leading: Radio(
                                  value: "الإيجابية",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                      print(groupValue);
                                    });
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                title: Text(
                                  "التواصل الفعال",
                                  style: descTx1(baseColorText),
                                ),
                                leading: Radio(
                                  value: "التواصل الفعال",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                      print(groupValue);
                                    });
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: ListTile(
                                title: Text(
                                  "نقل المعرفة",
                                  style: descTx1(baseColorText),
                                ),
                                leading: Radio(
                                  value: "نقل المعرفة",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                      print(groupValue);
                                    });
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                title: Text(
                                  "حل المشكلات",
                                  style: descTx1(baseColorText),
                                ),
                                leading: Radio(
                                  value: "حل المشكلات",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                      print(groupValue);
                                    });
                                  },
                                  activeColor: baseColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widgetsUni.actionbutton('إرسال', Icons.send, () {
                              print(groupValue);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
