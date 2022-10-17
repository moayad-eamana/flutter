import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class manegeMeetingTime extends StatefulWidget {
  @override
  State<manegeMeetingTime> createState() => _manegeMeetingTimeState();
}

class _manegeMeetingTimeState extends State<manegeMeetingTime> {
  List appointments_timelist = [];
  String Meetingsurl =
      "https://crm.eamana.gov.sa/agenda_dev/api/LeaderAppointment_dashboard/";
  int selecetedindex = 0;
  List Time = [];
  List sendTime = [];
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
    NoOfcustomer.text = jsonDecode(respose.body)["num_of_ppl"];
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
                    : Container(
                        width: 90.w,
                        margin: EdgeInsets.all(25),
                        padding: EdgeInsets.all(10),
                        decoration: containerdecoration(Colors.white),
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
                                              : Colors.white,
                                          onPrimary: Colors.black),
                                      onPressed: () {
                                        for (int i = 0;
                                            i <=
                                                appointments_timelist.length -
                                                    1;
                                            i++) {
                                          appointments_timelist[i]["color"] =
                                              Colors.white;
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
                                              "time": jsonDecode(
                                                  jsonEncode(e.value["time"]))
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
    sendTime.clear();
    EasyLoading.dismiss();
  }
}
