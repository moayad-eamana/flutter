class InboxHeader {
  int Count;
  String Title;
  int TypeID;
  int EmployeeNumber;

  InboxHeader(this.Count, this.Title, this.TypeID, this.EmployeeNumber);

  factory InboxHeader.fromJson(dynamic json) {
    return InboxHeader(
      json["Count"],
      json["Title"],
      json["TypeID"],
      json["EmployeeNumber"],
    );
  }
}
