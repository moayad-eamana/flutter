import 'dart:convert';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

class ManageroutinTime {
  int selecetedindex = 0;
  String Meetingsurl =
      "https://crm.eamana.gov.sa/agenda_dev/api/LeaderAppointment_dashboard/";
  List appointments_timelist = [];
  List Time = [];
  List sendTime = [];
  TextEditingController NoOfcustomer = TextEditingController();

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
    print(respose);
  }

  genereateButonns(e) {
    for (int i = 0; i <= appointments_timelist.length - 1; i++) {
      appointments_timelist[i]["color"] = BackGWhiteColor;
    }
    Time = e["Time"];
    e["color"] = secondryColor;
    selecetedindex = e["day_id"];
  }

  openOrCloseTime(e) {
    bool found = false;
    if (e.value["isopen"] == true) {
      Time[e.key]["isopen"] = false;
    } else {
      Time[e.key]["isopen"] = true;
    }

    if (sendTime.length == 0) {
      sendTime.add({
        "day_id": selecetedindex,
        "time": jsonDecode(jsonEncode(e.value["time"]))
      });
    } else {
      for (int i = 0; i <= sendTime.length - 1; i++) {
        if (selecetedindex == sendTime[i]["day_id"] &&
            e.value["time"] == sendTime[i]["time"]) {
          found = true;

          sendTime.removeAt(i);
          break;
        }
      }

      if (found == false) {
        sendTime.add({
          "day_id": selecetedindex,
          "time": jsonDecode(jsonEncode(e.value["time"]))
        });
      }
    }
    print(sendTime);
  }

  insert(context) async {
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
