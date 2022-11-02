import 'package:eamanaapp/provider/meeting/manageTime/ManageroutinTime.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class manageroutinTimeView extends StatefulWidget {
  ManageroutinTime manageroutinTime;
  manageroutinTimeView(this.manageroutinTime);
  @override
  State<manageroutinTimeView> createState() => _manageroutinTimeState();
}

class _manageroutinTimeState extends State<manageroutinTimeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(10),
      decoration: containerdecoration(BackGColor),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 10,
            children: [
              ...widget.manageroutinTime.appointments_timelist.map((e) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary:
                            e["color"] != null ? e["color"] : BackGWhiteColor,
                        onPrimary: baseColorText),
                    onPressed: () {
                      widget.manageroutinTime.genereateButonns(e);
                      setState(() {});
                    },
                    child: Text(e["day_str"]));
              }),
            ],
          ),
          widgetsUni.divider(),
          Text(
            "الأوقات",
            style: titleTx(baseColorText),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            children: [
              ...widget.manageroutinTime.Time.asMap().entries.map((e) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: e.value["isopen"] == true
                            ? Colors.green
                            : Colors.red[400],
                        onPrimary: Colors.black),
                    onPressed: () {
                      widget.manageroutinTime.openOrCloseTime(e);
                      setState(() {});
                    },
                    child: Text(e.value["time"]));
              })
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: baseColorText),
            decoration: formlabel1("عدد المستفيدين"),
            controller: widget.manageroutinTime.NoOfcustomer,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 120,
              child: widgetsUni.actionbutton("حفظ", Icons.send, () {
                widget.manageroutinTime.insert(context);
              }))
        ],
      ),
    );
  }
}
