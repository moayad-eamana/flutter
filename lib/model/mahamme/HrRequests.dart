class HrRequests {
  double RequestNumber;
  String RequestType;
  double RequesterEmployeeNumber;
  double ReplacementEmployeeNumber;
  String ReplacementEmployeeName;
  String RequesterName;
  String StartDateG;
  String EndDateG;
  String? Notes;
  double Days;
  int RequestTypeID;
  double OverTimeHours;
  String? Location;
  HrRequests(
      this.RequestNumber,
      this.RequestType,
      this.RequesterEmployeeNumber,
      this.ReplacementEmployeeNumber,
      this.ReplacementEmployeeName,
      this.RequesterName,
      this.StartDateG,
      this.EndDateG,
      this.Notes,
      this.Days,
      this.RequestTypeID,
      this.OverTimeHours,
      this.Location);

  factory HrRequests.fromJson(dynamic json) {
    return HrRequests(
      json["RequestNumber"],
      json["RequestType"],
      json["RequesterEmployeeNumber"],
      json["ReplacementEmployeeNumber"],
      json["ReplacementEmployeeName"],
      json["RequesterName"],
      json["StartDateG"],
      json["EndDateG"],
      json["Notes"],
      json["Days"],
      json["RequestTypeID"],
      json["OverTimeHours"] ?? 0.0,
      json["Location"] ?? "",
    );
  }
}
