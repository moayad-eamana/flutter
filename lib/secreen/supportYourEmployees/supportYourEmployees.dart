import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportTypes.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int index = 0;
  String title = "إختر موظف";

  @override
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;
    getData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(title, context, null, () {
          backPage();
        }),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            PageView(
              controller: controller,
              children: [
                MyEmployees(_employeesList, _checkedEmployees, nextPage),
                // supportTypes(
                //     nextPage, backPage, listOfmessages, listOfmessagesfn),
                SupportMessages([
                  "من الجيد أن يكون لديك موظف مستعد دائمًا لمواجهة التحدي!",
                  "أداؤك الممتاز هو مصدر إلهام للجميع. استمر في العمل العظيم!",
                  "الموظف الموثوق به هو أفضل هدية يمكن للقائد أن يطلبها. شكرا لكونك شخص يمكنني الاعتماد عليه",
                  "أنا معجب باستمرار  أدائك. شكرا لعملكم الشاق!",
                  "الإنتاجية هي القدرة على القيام بأشياء لم تكن قادرًا على القيام بها من قبل",
                  "لقد عملت بجد للوصول إلى ما أنت عليه الآن. تهانينا على مكافأتك التي حصلت عليها عن جدارة!",
                  "يسعدنا أن تظل جزءًا من فريقنا. إليكم مستقبل واعد في مؤسستنا!",
                  "شكرا",
                  "كفو",
                  "يعطيك العافية"
                ]), //backPage,
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
    index++;
    setState(() {});
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  backPage() {
    // controller.previousPage(duration: duration, curve: curve)();

    if (index == 0) {
      Navigator.pop(context);
    }
    index--;
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  listOfmessagesfn(List listOfmessages2) {
    listOfmessages = listOfmessages2;
    setState(() {});
  }

  //EMPLOYEES LIST:
  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await getAction("HR/GetAllEmployeesByManagerNumber/" +
        EmployeeProfile.getEmployeeNumber());
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
