class LoansRequest {
  int BdgLoc;
  int RequestNumber;
  String EmployeeName;
  int EmployeeNumber;
  String RequestDateG;
  String RequestDateH;
  int RequestTypeID;
  String RequestTypeName;
  String LocationName;
  String LocationCode;
  String FinancialName;
  int StatusID;
  String StatusName;
  String LoanReasons;
  int LetterNumber;
  String LetterDateH;
  String FromDateH;
  String ToDateH;
  String Reasons;
  String Recommendations;
  String EmployeeDepartmentName;
  int EmployeeDepartmentID;
  String ActualJobName;
  String DurationName;
  String DurationCode;

  LoansRequest(
      this.BdgLoc,
      this.RequestNumber,
      this.EmployeeName,
      this.EmployeeNumber,
      this.RequestDateG,
      this.RequestDateH,
      this.RequestTypeID,
      this.RequestTypeName,
      this.LocationName,
      this.LocationCode,
      this.FinancialName,
      this.StatusID,
      this.StatusName,
      this.LoanReasons,
      this.LetterNumber,
      this.LetterDateH,
      this.FromDateH,
      this.ToDateH,
      this.Reasons,
      this.Recommendations,
      this.EmployeeDepartmentName,
      this.EmployeeDepartmentID,
      this.ActualJobName,
      this.DurationName,
      this.DurationCode);

  factory LoansRequest.fromJson(dynamic json) {
    return LoansRequest(
      json["BdgLoc"],
      json["RequestNumber"],
      json["EmployeeName"],
      json["EmployeeNumber"],
      json["RequestDateG"],
      json["RequestDateH"],
      json["RequestTypeID"],
      json["RequestTypeName"],
      json["LocationName"],
      json["LocationCode"],
      json["FinancialName"],
      json["StatusID"],
      json["StatusName"],
      json["LoanReasons"],
      json["LetterNumber"],
      json["LetterDateH"],
      json["FromDateH"],
      json["ToDateH"],
      json["Reasons"],
      json["Recommendations"],
      json["EmployeeDepartmentName"],
      json["EmployeeDepartmentID"],
      json["ActualJobName"],
      json["DurationName"],
      json["DurationCode"],
    );
  }
}
