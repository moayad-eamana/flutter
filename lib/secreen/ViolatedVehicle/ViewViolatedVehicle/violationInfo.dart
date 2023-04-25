import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class violationInfo extends StatefulWidget {
  dynamic vehicle;

  violationInfo(this.vehicle);

  @override
  State<violationInfo> createState() => _violationInfoState();
}

class _violationInfoState extends State<violationInfo> {
  TextEditingController band =
      TextEditingController(text: "ترك المركبة التالفة إلخ. ........");

  int ToggleSwitchindex = -1;

  dynamic _selectedItem;

  dynamic statusID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      statusID = widget.vehicle["StatusID"];
      print(statusID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 2,
                  decoration: formlabel1("بند المخالفة"),
                  readOnly: true,
                  controller: band,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              TextF("المبلغ", "5000"),
              SizedBox(
                width: 5,
              ),
              // TextF("رقم السداد", "4434334"),
              // SizedBox(
              //   width: 5,
              // ),
              // TextF("حالة المخالفة", "غير مسددة"),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // ta3hd(),
        // SizedBox(
        //   height: 15,
        // ),
        // action(),
        // SizedBox(
        //   height: 15,
        // ),
        // attachment(),
        // SizedBox(
        //   height: 15,
        // ),

        // statusID == 4
        if (statusID == 4) e3tmadbutton(),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  TextF(String lable, String text) {
    return Expanded(
      child: TextField(
        maxLines: 1,
        decoration: formlabel1(lable),
        readOnly: true,
        style: descTx1(secondryColorText),
        controller: TextEditingController(text: text),
      ),
    );
  }

  Widget ta3hd() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "هل تم سداد الرسوم المستحقة لسحب السيارة ؟",
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
                    ToggleSwitchindex == -1 ? null : ToggleSwitchindex,
                activeBgColor: [baseColor],
                totalSwitches: 2,
                labels: ['نعم', 'لا'],
                onToggle: (index) {
                  int indexS = index as int;

                  ToggleSwitchindex = indexS;

                  print('switched to: $index');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget action() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "الاجراء",
                style: descTx1(baseColorText),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: DropdownSearch<dynamic>(
                  items: null,
                  selectedItem: _selectedItem == null ? null : _selectedItem,
                  key: UniqueKey(),
                  popupBackgroundColor: BackGWhiteColor,
                  popupItemBuilder: (context, rr, isSelected) => (Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(rr["DistrictName"].toString(),
                            style: subtitleTx(baseColorText))
                      ],
                    ),
                  )),
                  dropdownBuilder: (context, selectedItem) => Container(
                    decoration: null,
                    child: selectedItem == null
                        ? null
                        : Text(selectedItem == null ? "" : selectedItem ?? "",
                            style:
                                TextStyle(fontSize: 16, color: baseColorText)),
                  ),
                  dropdownBuilderSupportsNullItem: true,
                  mode: Mode.BOTTOM_SHEET,
                  // showClearButton:
                  //     _VacationTypeID == null ? false : true,
                  maxHeight: 400,
                  showAsSuffixIcons: true,
                  dropdownSearchDecoration: formlabel1("اختر الاجراء"),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "يرجى الاجراء";
                    } else {
                      return null;
                    }
                  },
                  showSearchBox: true,
                  onChanged: (v) {
                    try {
                      // setState(() {
                      //   print(v);
                      //   _selectedItem = v["DistrictName"];
                      //   widget.violatedVehicle.MuniciplaityInfo["DistrictID"] =
                      //       v["DistrictID"];
                      // });
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
                        "اختر الاجراء",
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
        ],
      ),
    );
  }

  Widget attachment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المرفقات",
            style: subtitleTx(baseColorText),
          ),
          widgetsUni.divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  GestureDetector(
                    onTap: () {
                      //print("object");
                    },
                    child: Placeholder(
                      color: secondryColorText,
                      strokeWidth: 0.4,
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // BottomSheet(index, docTypeID);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(child: Text("صورة")),
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(
            "صورة السيارة",
            style: descTx1(baseColorText),
          ),
        ],
      ),
    );
  }

  Widget e3tmadbutton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgetsUni.actionbutton('إعتماد', Icons.forward, () async {
            Alerts.confirmAlrt(
                    context, "رسالة تأكيد", "هل تريد إعتماد المخالفة ؟", "نعم")
                .show()
                .then((value) async {
              if (value == true) {
                EasyLoading.show(
                  status: '... جاري المعالجة',
                  maskType: EasyLoadingMaskType.black,
                );
                var reponse = await postAction(
                    "Inbox/UpdateViolatedVehiclesRequestStatus",
                    jsonEncode({
                      "RequestNumber": widget.vehicle["RequestID"],
                      "Notes": "",
                      "NewStatusID": 5,
                      "EmployeeNumber":
                          int.parse(EmployeeProfile.getEmployeeNumber()),
                    }));
                if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                  Alerts.successAlert(context, "", "سيتم إرسال رسالة نصية ")
                      .show()
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  Alerts.errorAlert(context, "خطأ",
                          jsonDecode(reponse.body)["ErrorMessage"])
                      .show();
                }
                EasyLoading.dismiss();
              }
            });
          }),
        ],
      ),
    );
  }
}
