import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/meeting/meetings.dart';
import 'package:eamanaapp/model/meeting/meetingsTime.dart';
import 'package:eamanaapp/utilities/SLL_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MettingsProvider extends ChangeNotifier {
  String Meetingsurl = 'https://crm.eamana.gov.sa/agenda/api/api-mobile/';
  // String Meetingsurl = 'https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/';

  late List<Meetings> _meetings = [];
  Future<void> fetchMeetings() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(
          Uri.parse(Meetingsurl + "getAppointmentsByEmail.php"),
          body: jsonEncode({
            "token": sharedPref.getString("AccessToken"),
            "username": employeeProfile.Email
          }));
    }

    print((jsonDecode(respose.body)));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetings = (jsonDecode(respose.body)["data"] as List)
        .map(((e) => Meetings.fromJson(e)))
        .toList();
    _meetings = _meetings
        .where((element) =>
            DateTime.parse(element.Date.toString()).compareTo(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day)) >
            0)
        .toList();
    notifyListeners();
  }

  Future<void> fetchMeetingshistory() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(
          Uri.parse(Meetingsurl + "getAppointmentsByEmail.php"),
          body: jsonEncode({
            "token": sharedPref.getString("AccessToken"),
            "username": employeeProfile.Email
          }));
    }

    print((jsonDecode(respose.body)));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetings = (jsonDecode(respose.body)["data"] as List)
        .map(((e) => Meetings.fromJson(e)))
        .toList();
    _meetings = _meetings
        .where((element) =>
            DateTime.parse(element.Date.toString()).compareTo(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day)) <=
            0)
        .toList();
    notifyListeners();
  }

  Future<void> getAppointmentsByLeader() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(
          Uri.parse(Meetingsurl + "getAppointmentsByLeader.php"),
          body: jsonEncode({
            "token": sharedPref.getString("AccessToken"),
            "username": employeeProfile.Email
          }));
    }

    print((jsonDecode(respose.body)));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    try {
      _meetings = (jsonDecode(respose.body)["data"] as List)
          .map(((e) => Meetings.fromJson(e)))
          .toList();
      _meetings = _meetings
          .where((element) =>
              DateTime.parse(element.Date.toString()).compareTo(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day)) >
              0)
          .toList();
    } catch (e) {
      _meetings = [];
    }

    notifyListeners();
  }

  Future<void> getAppointmentsByLeaderHistory() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    notifyListeners();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(
          Uri.parse(Meetingsurl + "getAppointmentsByLeader.php"),
          body: jsonEncode({
            "token": sharedPref.getString("AccessToken"),
            "username": employeeProfile.Email
          }));
    }

    print((jsonDecode(respose.body)));
    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    _meetings = (jsonDecode(respose.body)["data"] as List)
        .map(((e) => Meetings.fromJson(e)))
        .toList();
    _meetings = _meetings
        .where((element) =>
            DateTime.parse(element.Date.toString()).compareTo(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day)) <=
            0)
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
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(
          Uri.parse(Meetingsurl + "getAppointmentsToken.php"),
          body: jsonEncode({
            "token": sharedPref.getString("AccessToken"),
            "username": employeeProfile.Email
          }));
    }

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
      String meeting_pswd,
      String folLader) async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose = await http.post(Uri.parse(Meetingsurl + "editAppointment.php"),
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
            "meeting_pswd": meeting_pswd,
            "for_leader": folLader == "قيادي" ? "y" : "n"
          }));
    }

    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return false;
    }
    _meetings[index].Date = appDate;
    _meetings[index].Appwith = app_with;
    _meetings[index].Appwithmobile = mobile;
    _meetings[index].MeetingDetails = mtype == "p" ? "حضوري" : "إفتراضي";
    _meetings[index].Notes = notes;
    _meetings[index].Subject = subject;
    _meetings[index].Meeting_url = meeting_url;
    _meetings[index].Meeting_pswd = meeting_pswd;
    _meetings[index].Meeting_id = meeting_id;
    _meetings[index].Time = appTime;
    _meetings[index].Day = appDow;
    _meetings[index].for_leader = folLader == "إدارة" ? "n" : "y";
    notifyListeners();
    //local notification

    flutterLocalNotificationsPlugin.cancel(app_id);

    String body = "موعد مع " + app_with + " - بخصوص " + subject;
    var datetime = appDate.split("-");
    // print(datetime[0]);
    var time = appTime.split(":");
    // print(time[0]);
    flutterLocalNotificationsPlugin.schedule(
      app_id,
      "تذكير موعد",
      body,
      DateTime(int.parse(datetime[0]), int.parse(datetime[1]),
              int.parse(datetime[2]), int.parse(time[0]), int.parse(time[1]))
          .subtract(Duration(minutes: 10)),
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            visibility: NotificationVisibility.public,
            color: Colors.blue,
            icon: '@mipmap/launcher_icon',
          ),
          iOS: DarwinNotificationDetails(
              // subtitle: " test",
              )),
    );

    notifyListeners();

    print(respose.body);
    return true;
  }

  Future<void> addApp(Meetings meetings, String p) async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    employeeProfile = employeeProfile.getEmployeeProfile();
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose =
          await http.post(Uri.parse(Meetingsurl + "createAppointments.php"),
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
                "meeting_pswd": meetings.Meeting_pswd,
                "for_leader": meetings.for_leader
              }));
    }

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

    var datetime = meetings.Date.toString().split("-");
    print(datetime[0]);
    var time = meetings.Time.toString().split(":");
    print(time[0]);
    String body = "موعد مع " +
        meetings.Appwith.toString() +
        " - بخصوص " +
        meetings.Subject.toString();
    print(body);

    ///
    flutterLocalNotificationsPlugin.schedule(
      lastid,
      "تذكير موعد",
      body,
      DateTime(int.parse(datetime[0]), int.parse(datetime[1]),
              int.parse(datetime[2]), int.parse(time[0]), int.parse(time[1]))
          .subtract(Duration(minutes: 10)),
      NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            visibility: NotificationVisibility.public,
            color: Colors.blue,
            icon: '@mipmap/launcher_icon',
          ),
          iOS: DarwinNotificationDetails(
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
    var respose;
    if (await checkSSL(Meetingsurl)) {
      respose =
          await http.post(Uri.parse(Meetingsurl + "deleteAppointments.php"),
              body: jsonEncode({
                "token": sharedPref.getString("AccessToken"),
                "username": employeeProfile.Email,
                "app_id": id
              }));
    }

    if (jsonDecode(respose.body)["httpcode"] == 401) {
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      return;
    }
    // _meetings.removeWhere((element) => element.Id == id.toString());

    //local notification
    flutterLocalNotificationsPlugin.cancel(id);

    notifyListeners();
  }
}
