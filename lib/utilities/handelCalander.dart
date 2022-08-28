import 'package:device_calendar/device_calendar.dart' as calendar;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class handelCalander {
  static Future<dynamic> pusToCalander(
      String Startdate,
      String endDate,
      String? StartTime,
      String? endTime,
      String description,
      String title) async {
    try {
      var permissionsGranted =
          await calendar.DeviceCalendarPlugin.private().hasPermissions();
      if (permissionsGranted.isSuccess) {
        permissionsGranted =
            await calendar.DeviceCalendarPlugin.private().requestPermissions();
        if (!permissionsGranted.isSuccess) {
          return;
        }
      }
    } catch (e) {
      print(e);
    }

    tz.Location _currentLocation = tz.getLocation("Asia/Riyadh");
    try {
      var availableCalendars =
          await calendar.DeviceCalendarPlugin.private().retrieveCalendars();
      var defaultCalendarId = availableCalendars.data?[0].id;

      final calendarEvent = await calendar.DeviceCalendarPlugin.private()
          .createOrUpdateEvent(calendar.Event(
        defaultCalendarId,

        start: tz.TZDateTime.from(
            DateTime(
                int.parse(Startdate.split("-")[0]),
                int.parse(Startdate.split("-")[1]),
                int.parse(Startdate.split("-")[2]),
                (StartTime != null) ? int.parse(StartTime.split(":")[0]) : 1,
                (StartTime != null) ? int.parse(StartTime.split(":")[1]) : 01),
            _currentLocation),
        description: description,
        title: title,
        end: tz.TZDateTime.from(
            DateTime(
                int.parse(endDate.split("-")[0]),
                int.parse(endDate.split("-")[1]),
                int.parse(endDate.split("-")[2]),
                (endTime != null) ? int.parse(endTime.split(":")[0]) : 1,
                (endTime != null) ? int.parse(endTime.split(":")[1]) + 30 : 01),
            _currentLocation),
        // eventId: "moayad",
        allDay: StartTime == null ? true : false,
        location: 'أمانة الشرقية',
      ));
      return calendarEvent;
    } catch (e) {}
  }

  static Future<void> deletFromCalander(String eventID) async {
    var availableCalendars =
        await calendar.DeviceCalendarPlugin.private().retrieveCalendars();
    var defaultCalendarId = availableCalendars.data?[0].id;
    await calendar.DeviceCalendarPlugin.private()
        .deleteEvent(defaultCalendarId, eventID);
    sharedPref.remove(eventID);
  }
}
