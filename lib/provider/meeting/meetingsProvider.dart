import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/meeting/meetings.dart';
import 'package:eamanaapp/model/meeting/meetingsTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MettingsProvider extends ChangeNotifier {
  late List<Meetings> _meetings = [];
  Future<void> fetchMeetings() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/getAppointmentsByEmail.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "username": employeeProfile.Email
        }));

    print((jsonDecode(respose.body)));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetings = (jsonDecode(respose.body)["data"] as List)
        .map(((e) => Meetings.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<Meetings> get meetingList {
    return List.from(_meetings);
  }

  late List<MeetingsTime> _meetingsTime = [];
  Future<void> fetchMeetingsTime() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/getAppointmentsToken.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "username": employeeProfile.Email
        }));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetingsTime = (jsonDecode(respose.body)["data"] as List)
        .map(((e) => MeetingsTime.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<MeetingsTime> get getMeetingsTimeList {
    return List.from(_meetingsTime);
  }

  Future<bool> putappoit(
      int index,
      int app_id,
      String appDate,
      String appDow,
      String appTime,
      String app_with,
      String mobile,
      String subject,
      String notes,
      String mtype,
      String meeting_url,
      String meeting_id,
      String meeting_pswd) async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/editAppointment.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "username": employeeProfile.Email,
          "app_id": app_id,
          "appDate": appDate,
          "appDow": appDow,
          "appTime": appTime,
          "app_with": app_with,
          "mobile": mobile,
          "subject": subject,
          "notes": notes,
          "mtype": mtype,
          "meeting_url": meeting_url,
          "meeting_id": meeting_id,
          "meeting_pswd": meeting_pswd
        }));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return false;
    }
    _meetings[index].Date = appDate;
    _meetings[index].Appwith = app_with;
    _meetings[index].Appwithmobile = mobile;
    _meetings[index].MeetingDetails = appDow == "p" ? "حضوري" : "إفتراضي";
    _meetings[index].Notes = notes;
    _meetings[index].Subject = subject;
    _meetings[index].Meeting_url = meeting_url;
    _meetings[index].Meeting_pswd = meeting_pswd;
    _meetings[index].Meeting_id = meeting_id;
    notifyListeners();

    print(respose.body);
    return true;
  }

  Future<void> addApp(Meetings meetings, String p) async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/createAppointments.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "username": employeeProfile.Email,
          "appDate": meetings.Date,
          "hdate": "1443-5-20",
          "appDow": p,
          "appTime": meetings.Time,
          "app_with": meetings.Appwith,
          "mobile": meetings.Appwithmobile,
          "subject": meetings.Subject,
          "notes": meetings.Notes,
          "mtype": meetings.MeetingDetails,
          "meeting_url": meetings.Meeting_url,
          "meeting_id": meetings.Meeting_id,
          "meeting_pswd": meetings.Meeting_pswd
        }));
    print(respose.body);
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    var lastid = jsonDecode(respose.body)["message"];
    print(lastid);
    meetings.Id = lastid.toString();
    meetings.MeetingDetails =
        meetings.MeetingDetails == "p" ? "حضوري" : "إفتراضي";
    switch (p) {
      case "0":
        {
          meetings.Day = "الأحد";
        }
        break;
      case "1":
        {
          meetings.Day = "الاثنين";
        }
        break;
      case "2":
        {
          meetings.Day = "الثلاثاء";
        }
        break;
      case "3":
        {
          meetings.Day = "الأربعاء";
        }
        break;
      case "4":
        {
          meetings.Day = "الخميس";
        }
        break;
      case "5":
        {
          meetings.Day = "الجمعة";
        }
        break;
      case "6":
        {
          meetings.Day = "السبت";
        }
        break;
    }
    _meetings.insert(0, meetings);
    //local notification for Appointments
    //datetime d
    var datetime = meetings.Date.split("-");
    print(datetime[0]);
    var time = meetings.Time.split(":");
    print(time[0]);
    String body =
        "موعد مع " + meetings.Appwith + " - بخصوص " + meetings.Subject;
    print(body);

    ///
    flutterLocalNotificationsPlugin.schedule(
      lastid,
      "تذكير موعد",
      body,
      DateTime(int.parse(datetime[0]), int.parse(datetime[1]),
          int.parse(datetime[2]), int.parse(time[0]), int.parse(time[1])),
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            visibility: NotificationVisibility.public,
            color: Colors.blue,
            icon: '@mipmap/launcher_icon',
          ),
          iOS: IOSNotificationDetails(
              // subtitle: " test",
              )),
    );

    notifyListeners();
  }

  deletan(int index) {
    _meetings.removeAt(index);
    notifyListeners();
  }

  Future<void> deletApp(int id) async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/deleteAppointments.php"),
        body: jsonEncode({
          "token": sharedPref.getString("AccessToken"),
          "username": employeeProfile.Email,
          "app_id": id
        }));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetings.removeWhere((element) => element.Id == id.toString());
    notifyListeners();
  }
}
