import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
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
  int index = 0;
  String title = "إختر موظف";
  TextEditingController customeMsg = TextEditingController();
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
        floatingActionButton: index == 1
            ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: FloatingActionButton(
                    onPressed: () {
                      // Add your onPressed code here!
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              height: 300,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextField(
                                        controller: customeMsg,
                                        decoration: formlabel1("نص الرسالة"),
                                        maxLines: 3,
                                      ),
                                    ),
                                    sizeBox(),
                                    Container(
                                      width: 80,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            side: BorderSide(
                                              width: 1,
                                              color: bordercolor,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            primary: baseColor, // background
                                            onPrimary:
                                                Colors.white, // foreground

                                            elevation: 2),
                                        child: Text('إرسال'),
                                        onPressed: () async {
                                          //  Navigator.pop(context);
                                          EasyLoading.show(
                                            status: '... جاري المعالجة',
                                            maskType: EasyLoadingMaskType.black,
                                          );
                                          await postAction(
                                              "Notifications/SendFCMNotification",
                                              jsonEncode({
                                                "Employees": _checkedEmployees,
                                                "notification": {
                                                  "body": customeMsg.text,
                                                  "title": sharedPref
                                                          .getString(
                                                              "FirstName")
                                                          .toString() +
                                                      "  " +
                                                      sharedPref
                                                          .getString("LastName")
                                                          .toString() +
                                                      " يساندك ",
                                                  "image": "sample string 3"
                                                },
                                                "data": {
                                                  "module_id": "6",
                                                  "request_id": "0",
                                                  "module_name": "Support",
                                                  "image": "sample string 4",
                                                  "body": customeMsg.text,
                                                  "title": sharedPref
                                                          .getString(
                                                              "FirstName")
                                                          .toString() +
                                                      "  " +
                                                      sharedPref
                                                          .getString("LastName")
                                                          .toString() +
                                                      " يساندك "
                                                },
                                                "ApplicationID": 2
                                              }));
                                          EasyLoading.dismiss();
                                          Alerts.successAlert(context, "",
                                                  "تم إرسال الرسالة")
                                              .show()
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    backgroundColor: baseColor,
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            : Container(),
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
                ], _checkedEmployees), //backPage,
              ],
            ),
          ],
        ),
      ),
    );
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
    setState(() {});
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
