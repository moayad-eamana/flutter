import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/notification/bagenotification.dart';
import 'package:eamanaapp/secreen/services/ListViewServices.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/SLL_pin.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/searchX.dart';
import 'package:eamanaapp/utilities/styles/CSS/CSS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

// print(udid);
class ServicesView extends StatefulWidget {
  @override
  _ServicesViewState createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  int id = 0;
  String empNo = "";
  TextEditingController _search = TextEditingController();
  List<int> insertExtensionRequestValid = [0, 6, 7];

  @override
  void initState() {
    // TODO: implement initState

    embId();
    hasPermission2();
    print("object");
    // notificationcont = 3;
    super.initState();
  }

  shownotfNub() async {
    await badgenotification.shownotfNub();
    setState(() {});
  }

  Future<void> hasPermission2() async {
    EmployeeProfile empinfo = await EmployeeProfile();
    if (sharedPref.getString("dumyuser") != "10284928492") {
      dynamic response = await getAction(
          "ViolatedCars/GetUserGroups/" + EmployeeProfile.getEmployeeNumber());
      response = jsonDecode(response.body)["data"];
      if (response != null) {
        sharedPref.setInt("GroupID", response[0]["GroupID"]);
        sharedPref.setBool("ViolatedCars", true);
        if (response[0]["GroupID"] == 1) {
          sharedPref.setBool("WarnViolatedCars", true);
        } else {
          sharedPref.setBool("WarnViolatedCars", false);
        }
      } else {
        sharedPref.setInt("GroupID", 00);
        sharedPref.setBool("ViolatedCars", false);
        sharedPref.setBool("WarnViolatedCars", false);
      }
      setState(() {});
      dynamic response2 = await getAction(
          "HR/IsManager/" + EmployeeProfile.getEmployeeNumber());
      if (jsonDecode(response2.body)["IsGeneralMaanger"] == 1) {
        sharedPref.setBool("IsGeneralManager", true);
      } else {
        sharedPref.setBool("IsGeneralManager", false);
      }
      setState(() {});
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
    listOfServices list = listOfServices(context);

    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("جميع الخدمات", context, false),
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
                    searchTX(),
                    SizedBox(
                      height: 20,
                    ),
                    StaggeredGrid.count(
                      crossAxisCount:
                          SizerUtil.deviceType == DeviceType.mobile ? 2 : 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      children: [
                        ...list.AllService().map((e) {
                          return StaggeredGridTileW(
                              1,
                              SizerUtil.deviceType == DeviceType.mobile
                                  ? 183
                                  : 140,
                              widgetsUni.servicebutton(
                                  e["service_name"],
                                  e["icon"],
                                  e["Action"] == null
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListViewServices(e["List"],
                                                        e["service_name"])),
                                          );
                                        }
                                      : e["Action"]));
                        }),
                      ],
                    ),
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

  searchTX() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          print("object");
          showSearchX(
                  context: context,
                  delegate: CustomSearchDelegate(context, id, false))
              .then((value) {
            setState(() {
              // listofFavs = listOfFavs(context);
            });
          });

          FocusScope.of(context).unfocus();
        },
        child: TextField(
          showCursor: false,
          enabled: false,
          readOnly: true,
          controller: _search,
          keyboardType: TextInputType.text,
          maxLines: 1,
          decoration: CSS.TextFieldDecoration("تبحث عن خدمة محددة؟",
              icon: Icon(Icons.search)),
          onTap: () {
            print("object");
            //FocusScope.of(context).unfocus();

            showSearchX(
                context: context,
                delegate: CustomSearchDelegate(context, id, false));
          },
        ),
      ),
    );
  }
}
