class Mobashara {
  int EmployeeNumber;
  String StartDate;
  String TransactionDate;
  int ApprovalBy;
  String OldDepartmentName;
  String NewDepartmentName;
  int? OldClass;
  int? NewClass;
  int TransactionTypeID;
  int OrderTypeID;
  String OrderType;
  String EmployeeName;
  Mobashara(
      this.EmployeeNumber,
      this.StartDate,
      this.TransactionDate,
      this.ApprovalBy,
      this.OldDepartmentName,
      this.NewDepartmentName,
      this.OldClass,
      this.NewClass,
      this.TransactionTypeID,
      this.OrderType,
      this.OrderTypeID,
      this.EmployeeName);

  factory Mobashara.fromJson(dynamic json) {
    return Mobashara(
      json["EmployeeNumber"],
      json["StartDate"],
      json["TransactionDate"],
      json["ApprovalBy"],
      json["OldDepartmentName"],
      json["NewDepartmentName"],
      json["OldClass"],
      json["NewClass"],
      json["TransactionTypeID"],
      json["OrderType"],
      json["OrderTypeID"],
      json["EmployeeName"],
    );
  }
}
