import 'dart:convert';
import 'package:eamanaapp/model/meetings.dart';
import 'package:eamanaapp/model/meetingsTime.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MettingsProvider extends ChangeNotifier {
  String url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";

  late List<Meetings> _meetings = [];
  Future<void> fetchMeetings() async {
    notifyListeners();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/getAppointmentsByEmail.php"),
        body: jsonEncode(
            {"token": "RETTErhyty45ythTRH45y45y", "username": "akubaish"}));
    _meetings = (jsonDecode(respose.body) as List)
        .map(((e) => Meetings.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<Meetings> get meetingList {
    return List.from(_meetings);
  }

  late List<MeetingsTime> _meetingsTime = [];
  Future<void> fetchMeetingsTime() async {
    notifyListeners();
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/getAppointmentsToken.php"),
        body: jsonEncode(
            {"token": "RETTErhyty45ythTRH45y45y", "username": "akubaish"}));
    _meetingsTime = (jsonDecode(respose.body) as List)
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
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/editAppointment.php"),
        body: jsonEncode({
          "token": "RETTErhyty45ythTRH45y45y",
          "username": "akubaish",
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
    _meetings[index].Date = appDate;
    _meetings[index].Appwith = app_with;
    _meetings[index].Appwithmobile = mobile;
    _meetings[index].MeetingDetails = "حضوري";
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
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/createAppointments.php"),
        body: jsonEncode({
          "token": "RETTErhyty45ythTRH45y45y",
          "username": "akubaish",
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
    meetings.Id = "55555";
    _meetings.insert(0, meetings);
    notifyListeners();
  }

  deletan(int index) {
    _meetings.removeAt(index);
    notifyListeners();
  }

  Future<void> deletApp(int id) async {
    var respose = await http.post(
        Uri.parse(
            "https://crm.eamana.gov.sa/agenda_dev/api/api-mobile/deleteAppointments.php"),
        body: jsonEncode({
          "token": "RETTErhyty45ythTRH45y45y",
          "username": "akubaish",
          "app_id": id
        }));

    // _meetings.removeWhere((element) => element.Id == id.toString());
    //notifyListeners();
  }
}

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
