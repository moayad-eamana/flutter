import 'dart:convert';

import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportTypes.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class supportYourEmployees extends StatefulWidget {
  @override
  State<supportYourEmployees> createState() => _supportYourEmployeesState();
}

class _supportYourEmployeesState extends State<supportYourEmployees> {
  final PageController controller = PageController();
  List listOfmessages = [];
  List _employeesList = []; //var documents = await loadDocuments() as List;
  List _checkedEmployees = [];
  int index = 1;
  String title = "إختر موظف";

  @override
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;
    if (_employeesList.length <= 0) {
      getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(title, context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            PageView(
              controller: controller,
              children: [
                MyEmployees(_employeesList, _checkedEmployees, nextPage),
                supportTypes(
                    nextPage, backPage, listOfmessages, listOfEmployees),
                SupportMessages(listOfmessages), //backPage,
              ],
            ),
          ],
        ),
      ),
    );
  }

  listOfEmployees(List _employeesList2) {
    setState(() {
      _employeesList = _employeesList2;
    });
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)

    setState(() {});
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  backPage() {
    // controller.previousPage(duration: duration, curve: curve)();
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  //EMPLOYEES LIST:
  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await getAction("HR/GetAllEmployeesByManagerNumber/4261003");
//check if the response is valid
    if (jsonDecode(response.body)["StatusCode"] != 400) {
      // logapiO.StatusCode = 0;
      // logapiO.ErrorMessage = jsonDecode(respose.body)["ErrorMessage"];
      // logApi(logapiO);
      Alerts.errorAlert(
              context, "خطأ", jsonDecode(response.body)["ErrorMessage"])
          .show();
      return;
    } else {
      // logapiO.StatusCode = 1;
      // logApi(logapiO);
      ///
      // Alerts.successAlert(context, "", "test attendence").show().then((value) {
      //   Navigator.pop(context);

      setState(() {
        _employeesList = jsonDecode(response.body)['EmpInfo'];

        print(_employeesList);
      });
    }
    EasyLoading.dismiss();
  }
}
