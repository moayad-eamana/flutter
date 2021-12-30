class HrRequests {
  double RequestNumber;
  String RequestType;
  double RequesterEmployeeNumber;
  double ReplacementEmployeeNumber;
  String RequesterName;
  String StartDateG;
  String EndDateG;
  String? Notes;
  double Days;
  int RequestTypeID;

  HrRequests(
      this.RequestNumber,
      this.RequestType,
      this.RequesterEmployeeNumber,
      this.ReplacementEmployeeNumber,
      this.RequesterName,
      this.StartDateG,
      this.EndDateG,
      this.Notes,
      this.Days,
      this.RequestTypeID);

  factory HrRequests.fromJson(dynamic json) {
    return HrRequests(
      json["RequestNumber"],
      json["RequestType"],
      json["RequesterEmployeeNumber"],
      json["ReplacementEmployeeNumber"],
      json["RequesterName"],
      json["StartDateG"],
      json["EndDateG"],
      json["Notes"],
      json["Days"],
      json["RequestTypeID"],
    );
  }
}
