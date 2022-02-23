class MainDepartmentEmployees {
  double EmployeeNumber;
  String Department;
  int DepartmentID;
  int VacationBalance;
  String JobName;
  String JoinDatehH;
  String EmployeeName;
  String JoinDateG;
  int MainDepartmentID;
  String MainDepartmentName;
  String Email;
  MainDepartmentEmployees(
      this.EmployeeNumber,
      this.Department,
      this.DepartmentID,
      this.VacationBalance,
      this.JobName,
      this.JoinDatehH,
      this.EmployeeName,
      this.JoinDateG,
      this.MainDepartmentID,
      this.MainDepartmentName,
      this.Email);

  factory MainDepartmentEmployees.fromJson(dynamic json) {
    return MainDepartmentEmployees(
      json["EmployeeNumber"],
      json["Department"] ?? "",
      json["DepartmentID"],
      json["VacationBalance"],
      json["JobName"],
      json["JoinDatehH"] ?? "",
      json["EmployeeName"],
      json["JoinDateG"],
      json["MainDepartmentID"],
      json["MainDepartmentName"] ?? "",
      json["Email"],
    );
  }
}
