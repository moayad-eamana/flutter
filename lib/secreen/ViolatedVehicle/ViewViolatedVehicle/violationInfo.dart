import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
  dynamic attac;
  int ToggleSwitchindex = -1;

  dynamic _selectedItem;

  dynamic statusID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSadadStatus();
    setState(() {
      statusID = widget.vehicle["StatusID"];
      print(statusID);
    });
  }

  getSadadStatus() async {
    if (!(widget.vehicle["IsPaid"])) {
      var response = await getAction("ViolatedCars/GetSadadBillStatus/" +
          widget.vehicle["SadadNumber"].toString());
      print("object");
      widget.vehicle["IsPaid"] = (jsonDecode(response.body)["data"]["IsPaid"]);
      print(widget.vehicle["IsPaid"]);
      setState(() {});
    }
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
              TextF("المبلغ",
                  widget.vehicle["ViolationAmount"].toString().split(".")[0]),
              SizedBox(
                width: 5,
              ),
              if (statusID == 5)
                TextF("رقم السداد", widget.vehicle["SadadNumber"].toString()),
              if (statusID == 5)
                SizedBox(
                  width: 5,
                ),
              if (statusID == 5)
                TextF("حالة المخالفة",
                    widget.vehicle["IsPaid"] ? "مسددة" : "غير مسددة"),
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

        if (statusID == 5 &&
            findDateDifrince() > 90 &&
            widget.vehicle["IsPaid"] == false)
          attachment(),
        SizedBox(
          height: 15,
        ),

        // statusID == 4
        if ((statusID == 5 &&
            widget.vehicle["IsPaid"] == false &&
            findDateDifrince() <= 90))
          Text(
            "تبقى " + (90 - findDateDifrince()).toString() + " يوم مهلة",
            style: subtitleTx(baseColor),
          ),
        if (statusID == 4) e3tmadbutton(),

        e5tmadbutton(),
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
              InkWell(
                onTap: () async {
                  attac =
                      await Pickattachments.pickImage(ImageSource.gallery) ??
                          attac;
                  setState(() {});
                },
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    attac == null
                        ? Placeholder(
                            color: secondryColorText,
                            strokeWidth: 0.4,
                            fallbackHeight: 100,
                            fallbackWidth: 100,
                          )
                        : Image.file(
                            File(attac["path"]),
                            width: 100,
                            height: 100,
                          ),
                  ],
                ),
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

  Widget e5tmadbutton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.vehicle["IsPaid"] == false && findDateDifrince() > 90)
          Container(
              width: 150,
              child: widgetsUni.actionbutton("تحويل الطلب", Icons.send, () {
                if (attac == null) {
                  Alerts.errorAlert(context, "خطأ", "يجب إدراج صورة السيارة")
                      .show();
                  return;
                }
                Alerts.confirmAlrt(context, "",
                        "سوف يتم تحويل الطلب إلى مدير إدارة النظافة", "تحويل")
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
                          "NewStatusID": 6,
                          "EmployeeNumber":
                              int.parse(EmployeeProfile.getEmployeeNumber()),
                        }));
                    if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                      var response2 = await postAction(
                          "ViolatedCars/UploadImages",
                          jsonEncode({
                            "EmplpyeeNumber":
                                int.parse(EmployeeProfile.getEmployeeNumber()),
                            "ArcSerial": widget.vehicle["ArcSerial"],
                            "Attachements": [
                              {
                                "DocTypeID": 762,
                                "FileBytes": attac["base64"],
                                "FileName": attac["name"],
                                "FilePath": attac["path"],
                                "DocTypeName": attac["type"]
                              },
                            ]
                          }));
                      EasyLoading.dismiss();
                      Alerts.successAlert(context, "", "تم تحويل الطلب")
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
              })),
        SizedBox(
          width: 10,
        ),
        if (widget.vehicle["IsPaid"] == true)
          Container(
              width: 150,
              child: widgetsUni.actionbutton("تم تسليم السيارة", Icons.send,
                  () async {
                Alerts.confirmAlrt(context, "", "سوف يتم إلغاء الطلب", "نعم")
                    .show()
                    .then((value) async {
                  EasyLoading.show(
                    status: '... جاري المعالجة',
                    maskType: EasyLoadingMaskType.black,
                  );
                  var reponse = await postAction(
                      "Inbox/UpdateViolatedVehiclesRequestStatus",
                      jsonEncode({
                        "RequestNumber": widget.vehicle["RequestID"],
                        "Notes": "",
                        "NewStatusID": 10,
                        "EmployeeNumber":
                            int.parse(EmployeeProfile.getEmployeeNumber()),
                      }));
                  if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                    EasyLoading.dismiss();
                    Alerts.successAlert(context, "", "تم إلغاء الطلب")
                        .show()
                        .then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    Alerts.errorAlert(context, "خطأ",
                            jsonDecode(reponse.body)["ErrorMessage"])
                        .show();
                  }
                });
              })),
      ],
    );
  }

  findDateDifrince() {
    DateTime dt = DateTime.parse(widget.vehicle["WithdrawnDate"]);
    final date2 = DateTime.now();
    final difference = date2.difference(dt).inDays;
    return difference;
  }
}
