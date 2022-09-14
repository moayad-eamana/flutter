import 'package:eamanaapp/secreen/violation/addViolation/companyinfo.dart';
import 'package:eamanaapp/secreen/violation/addViolation/individualUserInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';

class add_violation extends StatefulWidget {
  @override
  State<add_violation> createState() => _add_violationState();
}

class _add_violationState extends State<add_violation> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إضافة مخالفة", context, null),
        body: PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: controller,

          children: <Widget>[individualUserInfo(), companyinfo()],
        ),
      ),
    );
  }
}
