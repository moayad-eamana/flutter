class MeetingsTime {
  String date;
  String Time;
  String dow;
  MeetingsTime(this.date, this.Time, this.dow);

  factory MeetingsTime.fromJson(dynamic json) {
    return MeetingsTime(
      json["date"],
      json["Time"],
      json["dow"],
    );
  }
}
