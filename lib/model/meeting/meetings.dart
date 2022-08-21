class Meetings {
  String? Id;
  String? Date;
  String? Day;
  String? Time;
  String? Appwith;
  String? Appwithmobile;
  String? Subject;
  String? Notes;
  String? MeetingDetails;
  String? Meeting_url;
  String? Meeting_id;
  String? Meeting_pswd;
  String? for_leader;
  Meetings(
      this.Id,
      this.Date,
      this.Day,
      this.Time,
      this.Appwith,
      this.Appwithmobile,
      this.Subject,
      this.Notes,
      this.MeetingDetails,
      this.Meeting_url,
      this.Meeting_id,
      this.Meeting_pswd,
      this.for_leader);

  factory Meetings.fromJson(dynamic json) {
    return Meetings(
        json["Id"],
        json["Date"] ?? "",
        json["Day"] ?? "",
        json["Time"] ?? "",
        json["Appwith"] ?? "",
        json["Appwithmobile"] ?? "",
        json["Subject"] ?? "",
        json["Notes"] ?? "",
        json["MeetingDetails"] ?? "",
        json["Meeting_url"] ?? "",
        json["Meeting_id"] ?? "",
        json["Meeting_pswd"] ?? "",
        json["for_leader"] ?? "");
  }
}
