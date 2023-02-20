import 'package:eamanaapp/secreen/supportYourEmployees/MyEmployees.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/SupportMessages.dart';
import 'package:eamanaapp/secreen/supportYourEmployees/supportTypes.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';

class supportYourEmployees extends StatefulWidget {
  const supportYourEmployees({Key? key}) : super(key: key);

  @override
  State<supportYourEmployees> createState() => _supportYourEmployeesState();
}

class _supportYourEmployeesState extends State<supportYourEmployees> {
  final PageController controller = PageController();
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
              children: [
                MyEmployees(),
                supportTypes(),
                SupportMessages(
                  list: [],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  backPag() {
    // controller.previousPage(duration: duration, curve: curve)();
    FocusScope.of(context).unfocus();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
