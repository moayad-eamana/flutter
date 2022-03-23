class PurchaseRequestsmodel {
  int RequestNumber;
  String RequestDate;
  int RequestStatusID;
  String RequestStatus;
  int RequestTypeID;
  String RequestType;
  String SendFlag;
  String SendFlagDescription;
  int EmployeeNumber;
  String EmployeeName;
  String MobileNumber;
  String ItemName;
  String Subject;
  int TransactionTypeID;
  String Department;

  PurchaseRequestsmodel(
      this.RequestNumber,
      this.RequestDate,
      this.RequestStatusID,
      this.RequestStatus,
      this.RequestTypeID,
      this.RequestType,
      this.SendFlag,
      this.SendFlagDescription,
      this.EmployeeNumber,
      this.EmployeeName,
      this.MobileNumber,
      this.ItemName,
      this.Subject,
      this.TransactionTypeID,
      this.Department);
  factory PurchaseRequestsmodel.fromJson(dynamic json) {
    return PurchaseRequestsmodel(
      json["RequestNumber"],
      json["RequestDate"],
      json["RequestStatusID"],
      json["RequestStatus"],
      json["RequestTypeID"],
      json["RequestType"],
      json["SendFlag"],
      json["SendFlagDescription"],
      json["EmployeeNumber"],
      json["EmployeeName"],
      json["MobileNumber"],
      json["ItemName"],
      json["Subject"],
      json["TransactionTypeID"],
      json["Department"],
    );
  }
}
