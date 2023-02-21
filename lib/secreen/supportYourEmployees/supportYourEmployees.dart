import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportTypes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';

class supportYourEmployees extends StatefulWidget {
  @override
  State<supportYourEmployees> createState() => _supportYourEmployeesState();
}

class _supportYourEmployeesState extends State<supportYourEmployees> {
  final PageController controller = PageController();
  List listOfmessages = [];
  List _employeesList = [];
  List _checkedEmployees = [];
  int index = 1;
  String title = "إختر موظف";
  @override
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;

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
            // Row(
            //   children: [
            //     FlatButton(
            //       child: Text('التالي'),
            //       onPressed: () {
            //         nextPage();
            //       },
            //     ),
            //     FlatButton(
            //       child: Text('السابق'),
            //       onPressed: () {
            //         backPag();
            //       },
            //     ),
            //   ],
            // ),
            widgetsUni.bacgroundimage(),
            PageView(
              controller: controller,
              children: [
                MyEmployees(_employeesList, _checkedEmployees),
                supportTypes(nextPage, listOfmessages, listOfmessagesfn),
                SupportMessages(listOfmessages),
              ],
            )
          ],
        ),
      ),
    );
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)

    setState(() {});
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  listOfmessagesfn(List listOfmessages2) {
    listOfmessages = listOfmessages2;
    setState(() {});
  }

  backPag() {
    // controller.previousPage(duration: duration, curve: curve)();
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
