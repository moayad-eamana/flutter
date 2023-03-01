import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportTypes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
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
            widgetsUni.bacgroundimage(),
            PageView(
              controller: controller,
              children: [
                MyEmployees(
                    _employeesList, _checkedEmployees, nextPage),
                supportTypes(
                    nextPage, backPage, listOfmessages, listOfmessagesfn),
                SupportMessages(listOfmessages), //backPage,
              ],
            ),
            // Positioned(
            //   bottom: 60.0,
            //   left: 10,
            //   child: OutlinedButton(

            //       onPressed: nextPage,
            //       style: ElevatedButton.styleFrom(
            //           // side: BorderSide(color: secondryColor),
            //           shape: CircleBorder(),
            //           padding: EdgeInsets.all(10),
            //           onPrimary: Colors.white),
            //       child: Container(
            //         child: Icon(Icons.arrow_forward_ios),
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: secondryColor, shape: BoxShape.circle),
            //       ))
            //       ),
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

  backPage() {
    // controller.previousPage(duration: duration, curve: curve)();
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
