import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class manegeMeetingTimeProvider {
  List sendTime2 = [];
  List appointments_timelist2 = [];
  int selecetedindex = 0;
  String Meetingsurl = CRMURL + "LeaderAppointment_dashboard/";
  getData(var startDate) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(Meetingsurl + "get_appointments_time_with_date.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "email": "akubaish",
          "startdate": startDate
        }));

    sendTime2.clear();
    appointments_timelist2 = jsonDecode(respose.body);
    EasyLoading.dismiss();
  }

  openAndCloseAll(dynamic index, dynamic e) {
    for (int i = 0; i < appointments_timelist2[e.key]["Time"].length; i++) {
      if (index == 0) {
        e.value["ischeckd"] = 0;
        appointments_timelist2[e.key]["Time"][i]["isopen"] = "y";
        bool found = false;
        for (int j = 0; j < sendTime2.length; j++) {
          if (sendTime2[j]["time"] ==
                  appointments_timelist2[e.key]["Time"][i]["time"] &&
              sendTime2[j]["date"] == appointments_timelist2[e.key]["date"]) {
            sendTime2[i]["isopen"] = "y";
            found = true;
          }
        }
        if (found == false) {
          sendTime2.add({
            "day_id": int.parse(appointments_timelist2[e.key]["day_id"]),
            "time": jsonDecode(
                jsonEncode(appointments_timelist2[e.key]["Time"][i]["time"])),
            "isopen": "y",
            "date": e.value["date"]
          });
        }
      } else {
        e.value["ischeckd"] = 1;
        appointments_timelist2[e.key]["Time"][i]["isopen"] = "n";
        bool found = false;
        for (int j = 0; j < sendTime2.length; j++) {
          if (sendTime2[j]["time"] ==
                  appointments_timelist2[e.key]["Time"][i]["time"] &&
              sendTime2[j]["date"] == appointments_timelist2[e.key]["date"]) {
            sendTime2[j]["isopen"] = "n";
            found = true;
          }
        }
        if (found == false) {
          sendTime2.add({
            "day_id": int.parse(appointments_timelist2[e.key]["day_id"]),
            "time": jsonDecode(
                jsonEncode(appointments_timelist2[e.key]["Time"][i]["time"])),
            "isopen": "n",
            "date": e.value["date"]
          });
        }
      }
    }
  }

  openOrCloseTime(selecetedindex, e, item) {
    selecetedindex = int.parse(e.value["day_id"]);
    bool found = false;
    if (item.value["isopen"] == "y") {
      item.value["isopen"] = "n";
    } else {
      item.value["isopen"] = "y";
    }

    if (sendTime2.length == 0) {
      sendTime2.add({
        "day_id": selecetedindex,
        "time": jsonDecode(jsonEncode(item.value["time"])),
        "isopen": item.value["isopen"],
        "date": e.value["date"]
      });
    } else {
      for (int i = 0; i <= sendTime2.length - 1; i++) {
        print(i);
        if (selecetedindex == sendTime2[i]["day_id"] &&
            item.value["time"] == sendTime2[i]["time"]) {
          found = true;
          print("remove");
          sendTime2[i]["isopen"] = (sendTime2[i]["isopen"] == "y" ? "n" : "y");
          break;
        }
      }

      if (found == false) {
        sendTime2.add({
          "day_id": selecetedindex,
          "time": jsonDecode(jsonEncode(item.value["time"])),
          "isopen": item.value["isopen"],
          "date": e.value["date"]
        });
      }
    }

    print(sendTime2);
  }

  insert(context) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await http.post(
        Uri.parse(Meetingsurl + "set_appointments_time_with_date.php"),
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
  }
}
