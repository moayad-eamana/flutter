import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';

class VacationRequest extends StatelessWidget {
  const VacationRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarW.appBarW("طلب إجازة", context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("فضلاً أدخل بيانات طلب إجازة"),
                Text("الرقم الوظيفي"),
              ],
            ),
          ),
        ));
  }
}
