import 'package:eamanaapp/provider/meeting/manageTime/manegeMeetingTimeProvider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class manageTimeBuDate extends StatefulWidget {
  manegeMeetingTimeProvider _provider;
  manageTimeBuDate(this._provider);
  @override
  State<manageTimeBuDate> createState() => _manageTimeBuDateState();
}

class _manageTimeBuDateState extends State<manageTimeBuDate> {
  List ListOfpanal = [];
  TextEditingController startDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 100.w,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: containerdecoration(BackGColor),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: startDate,
              decoration: formlabel1("الرجاء إدخال تاريخ البداية"),
              style: TextStyle(color: baseColorText),
              readOnly: true,
              onTap: () async {
                var date = await showDatePicker(
                  locale: Locale('en', ''),
                  context: context,
                  initialDatePickerMode: DatePickerMode.year,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1700),
                  lastDate: DateTime(2040),
                );
                print(date);
                startDate.text = date.toString().split(" ")[0];
                await widget._provider.getData(startDate.text);
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {},
              children: [
                ...widget._provider.appointments_timelist2
                    .asMap()
                    .entries
                    .map((e) {
                  return ExpansionPanel(
                    backgroundColor: BackGColor,
                    canTapOnHeader: true,
                    isExpanded: e.value["isExpanded"] ?? false,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        onTap: () {
                          // print("object");
                          e.value["isExpanded"] = (!isExpanded);
                          setState(() {});
                        },
                        trailing: ToggleSwitch(
                          radiusStyle: true,
                          borderWidth: 1,
                          borderColor: [bordercolor],
                          inactiveBgColor: BackGColor,
                          inactiveFgColor: baseColorText,
                          minWidth: 45.0,
                          minHeight: 35,
                          initialLabelIndex: e.value["ischeckd"] ?? null,
                          activeBgColor: [baseColor],
                          totalSwitches: 2,
                          fontSize: 10,
                          labels: ['فتح', 'إغلاق'],
                          onToggle: (index) {
                            //  int indexS = index as int;
                            widget._provider.openAndCloseAll(index, e);
                            setState(() {});
                          },
                        ),
                        contentPadding: EdgeInsets.only(right: 7),
                        title: Text(
                            e.value["date"] + " - " + e.value["day_str"],
                            style: subtitleTx(baseColor)),
                      );
                    },
                    body: Column(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            ...widget
                                ._provider.appointments_timelist2[e.key]["Time"]
                                .asMap()
                                .entries
                                .map((item) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: item.value["isopen"] == "y"
                                          ? Colors.green
                                          : Colors.red[400],
                                      onPrimary: Colors.black),
                                  onPressed: () {
                                    widget._provider.openOrCloseTime(
                                        widget._provider.selecetedindex,
                                        e,
                                        item);
                                    setState(() {});
                                  },
                                  child: Text(item.value["time"]));
                            })
                          ],
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget._provider.sendTime2.isEmpty
                ? Container()
                : widgetsUni.actionbutton("حقظ", Icons.send, () async {
                    await widget._provider.insert(context);
                    setState(() {});
                  })
          ],
        ),
      ),
    );
    ;
  }
}
