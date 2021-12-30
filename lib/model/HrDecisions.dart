class HrDecisions {
  int EmplyeeNumber;
  String EmployeeName;
  int Seq;
  int TrnsactionTypeID;
  String TransactionName;
  int OldClass;
  int NewClass;
  int OldDepratmentID;
  String OldDepartmentName;
  int NewDepartmentID;
  String NewDepartmentName;

  String ExexutionDateG;
  String SignTypeID;
  String SignTypeName;
  int BossNumber;

  HrDecisions(
      this.EmplyeeNumber,
      this.EmployeeName,
      this.Seq,
      this.TrnsactionTypeID,
      this.TransactionName,
      this.OldClass,
      this.NewClass,
      this.OldDepratmentID,
      this.OldDepartmentName,
      this.NewDepartmentID,
      this.NewDepartmentName,
      this.ExexutionDateG,
      this.SignTypeID,
      this.SignTypeName,
      this.BossNumber);

  factory HrDecisions.fromJson(dynamic json) {
    return HrDecisions(
      json["EmplyeeNumber"],
      json["EmployeeName"],
      json["Seq"],
      json["TrnsactionTypeID"],
      json["TransactionName"],
      json["OldClass"],
      json["NewClass"],
      json["OldDepratmentID"],
      json["OldDepartmentName"],
      json["NewDepartmentID"],
      json["NewDepartmentName"],
      json["ExexutionDateG"],
      json["SignTypeID"],
      json["SignTypeName"],
      json["BossNumber"],
    );
  }
}
