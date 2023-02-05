import 'dart:convert';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/services/hrServices.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/SLL_pin.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:eamanaapp/secreen/services/salaryServices.dart';
import 'package:eamanaapp/secreen/services/customerService.dart';
import 'package:eamanaapp/secreen/services/questService.dart';
import 'package:eamanaapp/secreen/services/otherServices.dart';
import 'package:eamanaapp/secreen/services/attendanceService.dart';

// print(udid);
class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int id = 0;
  String empNo = "";
  List<int> insertExtensionRequestValid = [0, 6, 7];

  @override
  void initState() {
    // TODO: implement initState
    shownotfNub();
    embId();
    hasPermission2();
    print("object");
    // notificationcont = 3;
    super.initState();
  }

  shownotfNub() async {
    var response = await getAction("Hr/GetNotReadNotificationsCount/" +
        EmployeeProfile.getEmployeeNumber());
    notificationcont = jsonDecode(response.body)["ReturnResult"] == null ||
            jsonDecode(response.body)["ReturnResult"] == 0
        ? null
        : jsonDecode(response.body)["ReturnResult"];
    setState(() {});
  }

  Future<void> hasPermission2() async {
    EmployeeProfile empinfo = await EmployeeProfile();

    empinfo = await empinfo.getEmployeeProfile();
    if (await checkSSL(
        "https://crm.eamana.gov.sa/agenda/api/api-mobile/getAppointmentsPermission.php")) {
      try {
        var respose = await http.post(
            Uri.parse(CRMURL + "api-mobile/getAppointmentsPermission.php"),
            body: jsonEncode({
              "token": sharedPref.getString("AccessToken"),
              "username": empinfo.Email
            }));
        hasePerm = jsonDecode(respose.body)["message"];
        sharedPref.setBool(
            "permissionforCRM", jsonDecode(respose.body)["permissionforCRM"]);
        sharedPref.setString(
            "deptid", jsonDecode(respose.body)["deptid"] ?? "");
        sharedPref.setString(
            "leadid", jsonDecode(respose.body)["leadid"] ?? "");
        sharedPref.setBool("permissionforAppManege3",
            jsonDecode(respose.body)["permissionforAppManege"]);
        sharedPref.setBool("permissionforAppReq",
            jsonDecode(respose.body)["permissionforAppReq"]);
        setState(() {});
      } catch (e) {}
    } else {
      return;
    }

    //hasePerm = hasePerm;
    print("rr == " + hasePerm.toString());
    //SharedPreferences? sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("hasePerm", hasePerm.toString());
    hasePerm = hasePerm.toString();
    setState(() {});
  }

  embId() async {
    id = await EmployeeProfile.getEmplPerm();
    empNo = await EmployeeProfile.getEmployeeNumber();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    hrServicesWidget obj = hrServicesWidget(context);
    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar:
            AppBarHome.appBarW("جميع الخدمات", context, true, notificationcont),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                margin:
                    EdgeInsets.only(left: 18, right: 18, bottom: 15.h, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شؤون الموظفين
                    ...obj.hrServices(),
                    ...salaryWidgets.salaryWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    ...attendanceService.attendanceWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    ...questServices.questWidget(context),
                    SizedBox(
                      height: 10,
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),

                    // Text(
                    //   "المخالفات الإلكترونية",
                    //   style: subtitleTx(baseColor),
                    // ),

                    // widgetsUni.divider(),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // violation(),

                    if (sharedPref.getBool("permissionforCRM") == true)
                      ...customerService.customerServiceWidget(context),
                    SizedBox(
                      height: 5,
                    ),

                    ...otherServices.otherWidget(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  violation() {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 20),
      child: StaggeredGrid.count(
        crossAxisCount: SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
        mainAxisSpacing: 6,
        crossAxisSpacing: 10,
        children: [
          StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: hi,
              child: ElevatedButton(
                  style: cardServiece,
                  onPressed: () {
                    Navigator.pushNamed(context, "/ViolationHome");
                  },
                  child: widgetsUni.cardcontentService(
                      'assets/SVGs/violation.svg', "إنشاء مخالفة"))),
        ],
      ),
    );
  }
}
