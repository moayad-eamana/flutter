import 'dart:convert';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class AndroidWallet extends StatefulWidget {
  @override
  State<AndroidWallet> createState() => _AndroidWalletState();
}

//get employee's data: الاسم-الوظيفة-الجوال-الرقم الوظيفي
var name = "نور ناجي عبدالله السعود";
var position = "";
var jobNo = 56493820;
var mobileNo = 0505050505;

class _AndroidWalletState extends State<AndroidWallet> {
  var empInfo;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    var response = await getAction(
        "HR/GetEmployeeDataByEmpNo/" + EmployeeProfile.getEmployeeNumber());
    empInfo = jsonDecode(response.body)["EmpInfo"];
    print(empInfo);
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "profile";
    logapiO.ClassName = "profile";
    logapiO.ActionMethodName = "معلوماتي";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //     child: Column(
        //   children: [
        //     Container(child: Text(EmployeeProfile.getEmployeeNumber())),
        //     Text(empInfo['EmployeeName']),
        //     Text(empInfo['MobileNumber']),
        //     Text(EmployeeProfile.getEmployeeNumber())
        //   ],
        // ));
        Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(children: [
        widgetsUni.bacgroundimage(),
        Container(
          child: Column(
            children: [
              Card(
                  margin: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "أمانة المنطقة الشرقية",
                            style: TextStyle(
                                color: baseColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Image(
                            image: NetworkImage(
                                'https://www.my.gov.sa/wps/wcm/connect/b47400fd-a90d-4d7a-bad6-1b195ac28372/%D8%A3%D9%85%D8%A7%D9%86%D8%A9-%D8%A7%D9%84%D9%85%D9%86%D8%B7%D9%82%D8%A9-%D8%A7%D9%84%D8%B4%D8%B1%D9%82%D9%8A%D8%A9.png?MOD=AJPERES&CACHEID=ROOTWORKSPACE-b47400fd-a90d-4d7a-bad6-1b195ac28372-oluw37v'),
                            height: 60,
                            width: 60,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "الاسم",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
