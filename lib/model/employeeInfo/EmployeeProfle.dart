import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfile {
  double? EmployeeNumber;
  String? EmployeeName;
  String? FirstName;
  String? SecondName;
  String? ThirdName;
  String? LastName;
  int? DepartmentID;
  String? DepartmentName;
  String? Email;
  int? empTypeID;
  String? empTypeName;

  String? StatusName;
  String? UserIdentityNumber;
  String? MobileNumber;
  int? UserTypeID;
  int? VacationBalance;
  String? JobName;
  String? ImageURL;
  String? Title;
  String? DirectManagerName;
  int? DirectManagerEmployeeNumber;
  String? GeneralManagerName;
  int? GeneralManagerEmployeeNumber;
  int? MainDepartmentID;
  String? MainDepartmentName;
  int? Extension;
  int? GenderID;

  Future<EmployeeProfile> getEmployeeProfile() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    employeeProfile.EmployeeNumber = _pref.getDouble("EmployeeNumber");
    employeeProfile.EmployeeName = _pref.getString("EmployeeName").toString();
    employeeProfile.FirstName = _pref.getString("FirstName");
    employeeProfile.SecondName = _pref.getString("SecondName");
    employeeProfile.ThirdName = _pref.getString("ThirdName");
    employeeProfile.LastName = _pref.getString("LastName");
    employeeProfile.DepartmentID = _pref.getInt("DepartmentID");
    employeeProfile.DepartmentName = _pref.getString("DepartmentName");
    employeeProfile.Email = _pref.getString("Email");

    employeeProfile.empTypeID = _pref.getInt("empTypeID");
    employeeProfile.empTypeName = _pref.getString("empTypeName");
    employeeProfile.StatusName = _pref.getString("StatusName");
    employeeProfile.UserIdentityNumber = _pref.getString("UserIdentityNumber");
    employeeProfile.MobileNumber = _pref.getString("MobileNumber");
    employeeProfile.UserTypeID = _pref.getInt("UserTypeID");
    employeeProfile.VacationBalance = _pref.getInt("VacationBalance");

    employeeProfile.JobName = _pref.getString("JobName");
    employeeProfile.ImageURL = _pref.getString("ImageURL");
    employeeProfile.Title = _pref.getString("Title");
    employeeProfile.DirectManagerName = _pref.getString("DirectManagerName");

    employeeProfile.DirectManagerEmployeeNumber =
        _pref.getInt("DirectManagerEmployeeNumber");

    employeeProfile.GeneralManagerEmployeeNumber =
        _pref.getInt("GeneralManagerEmployeeNumber");
    employeeProfile.MainDepartmentID = _pref.getInt("MainDepartmentID");
    employeeProfile.MainDepartmentName = _pref.getString("MainDepartmentName");
    employeeProfile.Extension = _pref.getInt("Extension");
    employeeProfile.GenderID = _pref.getInt("GenderID");

    //notifyListeners();
    return employeeProfile;
  }

  static Future<String> getEmployeeNumber() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    SharedPreferences _pref = await SharedPreferences.getInstance();

    return (_pref.getDouble("EmployeeNumber")).toString().split(".")[0];
  }

  static Future<double> getEmployeeNumberasDouble() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    SharedPreferences _pref = await SharedPreferences.getInstance();

    return _pref.getDouble("EmployeeNumber") ?? 2.22;
  }

  static Future<int> getDepartmentID() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    SharedPreferences _pref = await SharedPreferences.getInstance();

    return _pref.getInt("DepartmentID") ?? 0;
  }

  static Future<int> getEmplPerm() async {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    SharedPreferences _pref = await SharedPreferences.getInstance();

    return (_pref.getInt("empTypeID") ?? 0);
  }
}
