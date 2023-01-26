import 'package:eamanaapp/main.dart';

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

  EmployeeProfile getEmployeeProfile() {
    EmployeeProfile employeeProfile = new EmployeeProfile();
    // SharedPreferences _pref = await SharedPreferences.getInstance();
    employeeProfile.EmployeeNumber = sharedPref.getDouble("EmployeeNumber");
    employeeProfile.EmployeeName =
        sharedPref.getString("EmployeeName").toString();
    employeeProfile.FirstName = sharedPref.getString("FirstName");
    employeeProfile.SecondName = sharedPref.getString("SecondName");
    employeeProfile.ThirdName = sharedPref.getString("ThirdName");
    employeeProfile.LastName = sharedPref.getString("LastName");
    employeeProfile.DepartmentID = sharedPref.getInt("DepartmentID");
    employeeProfile.DepartmentName = sharedPref.getString("DepartmentName");
    employeeProfile.Email = sharedPref.getString("Email");

    employeeProfile.empTypeID = sharedPref.getInt("empTypeID");
    employeeProfile.empTypeName = sharedPref.getString("empTypeName");
    employeeProfile.StatusName = sharedPref.getString("StatusName");
    employeeProfile.UserIdentityNumber =
        sharedPref.getString("UserIdentityNumber");
    employeeProfile.MobileNumber = sharedPref.getString("MobileNumber");
    employeeProfile.UserTypeID = sharedPref.getInt("UserTypeID");
    employeeProfile.VacationBalance = sharedPref.getInt("VacationBalance");

    employeeProfile.JobName = sharedPref.getString("JobName");
    employeeProfile.ImageURL = sharedPref.getString("ImageURL");
    employeeProfile.Title = sharedPref.getString("Title");
    employeeProfile.DirectManagerName =
        sharedPref.getString("DirectManagerName");

    employeeProfile.DirectManagerEmployeeNumber =
        sharedPref.getInt("DirectManagerEmployeeNumber");

    employeeProfile.GeneralManagerEmployeeNumber =
        sharedPref.getInt("GeneralManagerEmployeeNumber");
    employeeProfile.MainDepartmentID = sharedPref.getInt("MainDepartmentID");
    employeeProfile.MainDepartmentName =
        sharedPref.getString("MainDepartmentName");
    employeeProfile.Extension = sharedPref.getInt("Extension");
    employeeProfile.GenderID = sharedPref.getInt("GenderID");

    //notifyListeners();
    return employeeProfile;
  }

  static String getEmployeeNumber() {
    // EmployeeProfile employeeProfile = new EmployeeProfile();
    // SharedPreferences _pref = await SharedPreferences.getInstance();
    if (sharedPref.getDouble("EmployeeNumber") == null) {
      return "0";
    }
    return (sharedPref.getDouble("EmployeeNumber")).toString().split(".")[0];
  }

  static Future<double> getEmployeeNumberasDouble() async {
    // EmployeeProfile employeeProfile = new EmployeeProfile();
    // SharedPreferences _pref = await SharedPreferences.getInstance();

    return sharedPref.getDouble("EmployeeNumber") ?? 2.22;
  }

  static Future<int> getDepartmentID() async {
    // EmployeeProfile employeeProfile = new EmployeeProfile();
    // SharedPreferences _pref = await SharedPreferences.getInstance();

    return sharedPref.getInt("DepartmentID") ?? 0;
  }

  static Future<int> getEmplPerm() async {
    // EmployeeProfile employeeProfile = new EmployeeProfile();
    // SharedPreferences _pref = await SharedPreferences.getInstance();

    return (sharedPref.getInt("empTypeID") ?? 0);
  }
}
