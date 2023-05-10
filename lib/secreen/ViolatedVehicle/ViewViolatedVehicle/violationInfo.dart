import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/provider/ViolatedVehicle/violationInfoP.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class violationInfo extends StatefulWidget {
  int typId;
  dynamic vehicle;

  violationInfo(this.vehicle, this.typId);

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
        if (statusID == 4 && widget.typId != -1) e3tmadbutton(),

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
            violationInfoP.approveViolation(
                context, widget.vehicle["RequestID"]);
          }),
        ],
      ),
    );
  }

  Widget e5tmadbutton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.vehicle["IsPaid"] == false &&
            findDateDifrince() > 90 &&
            widget.typId != -1)
          Container(
              width: 150,
              child: widgetsUni.actionbutton("تحويل الطلب", Icons.send, () {
                if (attac == null) {
                  Alerts.errorAlert(context, "خطأ", "يجب إدراج صورة السيارة")
                      .show();
                  return;
                }
                violationInfoP.transfareToManager(
                    context,
                    widget.vehicle["RequestID"],
                    widget.vehicle["ArcSerial"],
                    attac);
              })),
        SizedBox(
          width: 10,
        ),
        if (widget.vehicle["IsPaid"] == true && widget.typId != -1)
          Container(
              width: 150,
              child: widgetsUni.actionbutton("تم تسليم السيارة", Icons.send,
                  () async {
                violationInfoP.cancel5Request(
                    context, widget.vehicle["RequestID"]);
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
