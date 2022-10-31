import 'dart:convert';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';

import '../../main.dart';

class manegeMeetingTime extends StatefulWidget {
  @override
  State<manegeMeetingTime> createState() => _manegeMeetingTimeState();
}

class _manegeMeetingTimeState extends State<manegeMeetingTime> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  List appointments_timelist = [];
  List appointments_timelist2 = [];

  String Meetingsurl =
      "https://crm.eamana.gov.sa/agenda_dev/api/LeaderAppointment_dashboard/";
  int selecetedindex = 0;
  List Time = [];
  List Time2 = [];
  List sendTime = [];
  List sendTime2 = [];
  List ListOfpanal = [];
  int index = 0;
  TextEditingController NoOfcustomer = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose =
        await http.post(Uri.parse(Meetingsurl + "get_appointments_time.php"),
            body: jsonEncode({
              "token": sharedPref.getString("AccessToken"),
              "email": sharedPref.getString("Email"),
            }));
    appointments_timelist = jsonDecode(respose.body)["table"];
    NoOfcustomer.text = jsonDecode(respose.body)["num_of_ppl"] ?? "";
    appointments_timelist[0]["color"] = secondryColor;
    Time = appointments_timelist[0]["Time"];
    EasyLoading.dismiss();
    setState(() {});
    print(respose);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              // backgroundColor: baseColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.rotate_left_outlined),
                  label: 'روتيني',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_week),
                  label: 'إسبوعي',
                ),
              ],
              currentIndex: index,
              // unselectedItemColor: Colors.white,
              selectedItemColor: secondryColor,
              onTap: (int index2) {
                index = index2;
                setState(() {});
              },
            ),
            appBar: AppBarW.appBarW('إدارة المواعيد', context, null),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Image.asset(
                    imageBG,
                    fit: BoxFit.fill,
                  ),
                ),
                appointments_timelist.length == 0
                    ? Container()
                    : index == 1
                        ? byDate()
                        : Container(
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
                                    ...appointments_timelist.map((e) {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: e["color"] != null
                                                  ? e["color"]
                                                  : BackGWhiteColor,
                                              onPrimary: baseColorText),
                                          onPressed: () {
                                            for (int i = 0;
                                                i <=
                                                    appointments_timelist
                                                            .length -
                                                        1;
                                                i++) {
                                              appointments_timelist[i]
                                                  ["color"] = BackGWhiteColor;
                                            }
                                            Time = e["Time"];
                                            e["color"] = secondryColor;
                                            selecetedindex = e["day_id"];
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
                                    ...Time.asMap().entries.map((e) {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: e.value["isopen"] == true
                                                  ? Colors.green
                                                  : Colors.red[400],
                                              onPrimary: Colors.black),
                                          onPressed: () {
                                            bool found = false;
                                            if (e.value["isopen"] == true) {
                                              Time[e.key]["isopen"] = false;
                                            } else {
                                              Time[e.key]["isopen"] = true;
                                            }

                                            if (sendTime.length == 0) {
                                              sendTime.add({
                                                "day_id": selecetedindex,
                                                "time": jsonDecode(
                                                    jsonEncode(e.value["time"]))
                                              });
                                            } else {
                                              for (int i = 0;
                                                  i <= sendTime.length - 1;
                                                  i++) {
                                                if (selecetedindex ==
                                                        sendTime[i]["day_id"] &&
                                                    e.value["time"] ==
                                                        sendTime[i]["time"]) {
                                                  found = true;
                                                  print("remove");
                                                  sendTime.removeAt(i);
                                                  break;
                                                }
                                              }

                                              if (found == false) {
                                                sendTime.add({
                                                  "day_id": selecetedindex,
                                                  "time": jsonDecode(jsonEncode(
                                                      e.value["time"]))
                                                });
                                              }
                                            }

                                            print(sendTime);
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
                                  controller: NoOfcustomer,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    width: 120,
                                    child: widgetsUni
                                        .actionbutton("حفظ", Icons.send, () {
                                      insert();
                                    }))
                              ],
                            ),
                          )
              ],
            )));
  }

  Widget byDate() {
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
                EasyLoading.show(
                  status: '... جاري المعالجة',
                  maskType: EasyLoadingMaskType.black,
                );
                var respose = await http.post(
                    Uri.parse(
                        Meetingsurl + "get_appointments_time_with_date.php"),
                    body: jsonEncode({
                      "token": sharedPref.getString("AccessToken"),
                      "email": sharedPref.getString("Email"),
                      "startdate": startDate.text
                    }));
                sendTime2.clear();
                appointments_timelist2 = jsonDecode(respose.body);
                EasyLoading.dismiss();
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {},
              children: [
                ...appointments_timelist2.asMap().entries.map((e) {
                  return ExpansionPanel(
                    backgroundColor: BackGColor,
                    canTapOnHeader: true,
                    isExpanded: e.value["isExpanded"] ?? false,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        onTap: () {
                          print("fffff");
                          e.value["isExpanded"] = !isExpanded;
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
                            int indexS = index as int;
                            for (int i = 0;
                                i <
                                    appointments_timelist2[e.key]["Time"]
                                        .length;
                                i++) {
                              if (index == 0) {
                                e.value["ischeckd"] = 0;
                                appointments_timelist2[e.key]["Time"][i]
                                    ["isopen"] = "y";
                                bool found = false;
                                for (int j = 0; j < sendTime2.length; j++) {
                                  if (sendTime2[j]["time"] ==
                                          appointments_timelist2[e.key]["Time"]
                                              [i]["time"] &&
                                      sendTime2[j]["date"] ==
                                          appointments_timelist2[e.key]
                                              ["date"]) {
                                    sendTime2[i]["isopen"] = "y";
                                    found = true;
                                  }
                                }
                                if (found == false) {
                                  sendTime2.add({
                                    "day_id": int.parse(
                                        appointments_timelist2[e.key]
                                            ["day_id"]),
                                    "time": jsonDecode(jsonEncode(
                                        appointments_timelist2[e.key]["Time"][i]
                                            ["time"])),
                                    "isopen": "y",
                                    "date": e.value["date"]
                                  });
                                }

                                setState(() {});
                              } else {
                                e.value["ischeckd"] = 1;
                                appointments_timelist2[e.key]["Time"][i]
                                    ["isopen"] = "n";
                                bool found = false;
                                for (int j = 0; j < sendTime2.length; j++) {
                                  if (sendTime2[j]["time"] ==
                                          appointments_timelist2[e.key]["Time"]
                                              [i]["time"] &&
                                      sendTime2[j]["date"] ==
                                          appointments_timelist2[e.key]
                                              ["date"]) {
                                    sendTime2[j]["isopen"] = "n";
                                    found = true;
                                  }
                                }
                                if (found == false) {
                                  sendTime2.add({
                                    "day_id": int.parse(
                                        appointments_timelist2[e.key]
                                            ["day_id"]),
                                    "time": jsonDecode(jsonEncode(
                                        appointments_timelist2[e.key]["Time"][i]
                                            ["time"])),
                                    "isopen": "n",
                                    "date": e.value["date"]
                                  });
                                }
                                setState(() {});
                              }
                            }
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
                            ...appointments_timelist2[e.key]["Time"]
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
                                    selecetedindex =
                                        int.parse(e.value["day_id"]);
                                    bool found = false;
                                    if (item.value["isopen"] == "y") {
                                      item.value["isopen"] = "n";
                                    } else {
                                      item.value["isopen"] = "y";
                                    }

                                    if (sendTime2.length == 0) {
                                      sendTime2.add({
                                        "day_id": selecetedindex,
                                        "time": jsonDecode(
                                            jsonEncode(item.value["time"])),
                                        "isopen": item.value["isopen"],
                                        "date": e.value["date"]
                                      });
                                    } else {
                                      for (int i = 0;
                                          i <= sendTime2.length - 1;
                                          i++) {
                                        print(i);
                                        if (selecetedindex ==
                                                sendTime2[i]["day_id"] &&
                                            item.value["time"] ==
                                                sendTime2[i]["time"]) {
                                          found = true;
                                          print("remove");
                                          sendTime2[i]["isopen"] =
                                              (sendTime2[i]["isopen"] == "y"
                                                  ? "n"
                                                  : "y");
                                          break;
                                        }
                                      }

                                      if (found == false) {
                                        sendTime2.add({
                                          "day_id": selecetedindex,
                                          "time": jsonDecode(
                                              jsonEncode(item.value["time"])),
                                          "isopen": item.value["isopen"],
                                          "date": e.value["date"]
                                        });
                                      }
                                    }

                                    print(sendTime2);
                                    setState(() {});
                                  },
                                  child: Text(item.value["time"]));
                            })
                          ],
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
            SizedBox(
              height: 10,
            ),
            sendTime2.isEmpty
                ? Container()
                : widgetsUni.actionbutton("حقظ", Icons.send, () async {
                    EasyLoading.show(
                      status: '... جاري المعالجة',
                      maskType: EasyLoadingMaskType.black,
                    );
                    var respose = await http.post(
                        Uri.parse(Meetingsurl +
                            "set_appointments_time_with_date.php"),
                        body: jsonEncode({
                          "token": sharedPref.getString("AccessToken"),
                          "email": sharedPref.getString("Email"),
                          "appointment": sendTime2
                        }));
                    if (jsonDecode(respose.body)["status"] == true) {
                      Alerts.successAlert(context, "", "تم التعديل").show();
                    } else {
                      Alerts.errorAlert(context, "", "خطأ").show();
                    }
                    EasyLoading.dismiss();
                  })
          ],
        ),
      ),
    );
  }

  insert() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose =
        await http.post(Uri.parse(Meetingsurl + "set_appointments_time.php"),
            body: jsonEncode({
              "token": sharedPref.getString("AccessToken"),
              "email": sharedPref.getString("Email"),
              "num_of_ppl": NoOfcustomer.text,
              "appointment": sendTime
            }));
    if (jsonDecode(respose.body)["status"] == true) {
      Alerts.successAlert(context, "", "تم التعديل ").show();
    } else {
      Alerts.errorAlert(context, "خطأ", "").show();
    }
    sendTime.clear();
    EasyLoading.dismiss();
  }
}
