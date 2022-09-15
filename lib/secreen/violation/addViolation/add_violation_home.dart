import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/violation/addViolation/attachment.dart';
import 'package:eamanaapp/secreen/violation/addViolation/bunud.dart';
import 'package:eamanaapp/secreen/violation/addViolation/individualUserInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';

import 'company/companyinfo.dart';

class add_violation extends StatefulWidget {
  int page;
  add_violation(this.page);
  @override
  State<add_violation> createState() => _add_violationState();
}

class _add_violationState extends State<add_violation>
    with AutomaticKeepAliveClientMixin {
  individualUserInfoModel IndividualUserInfo = individualUserInfoModel();
  final PageController controller = PageController();
  int index = 1;
  @override
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إضافة مخالفة", context, null),
        body: PageView(
          controller: controller,
          children: <Widget>[
            if (widget.page == 1)
              individualUserInfo(IndividualUserInfo, nextPage),
            if (widget.page == 2) companyinfo(nextPage),
            bunud(
              next: nextPage,
              back: backPag,
            ),
            attachment(
              back: backPag,
            ),
          ],
        ),
      ),
    );
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  backPag() {
    // controller.previousPage(duration: duration, curve: curve)();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
