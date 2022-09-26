import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/violation/addViolation/attachment.dart';
import 'package:eamanaapp/secreen/violation/addViolation/bunud.dart';
import 'package:eamanaapp/secreen/violation/addViolation/Individuals/individualUserInfo.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import 'company/companyinfo.dart';

class add_violation extends StatefulWidget {
  int? page;
  add_violation(this.page);
  @override
  State<add_violation> createState() => _add_violationState();
}

class _add_violationState extends State<add_violation>
    with AutomaticKeepAliveClientMixin {
  VaiolationModel vaiolationModel = VaiolationModel();
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
      child: WillPopScope(
        onWillPop: () async {
          Alerts.confirmAlrt(
                  context, "خروج", "هل تريد الخروج النظام المخالفات", "نعم")
              .show()
              .then((value) async {
            if (value == true) {
              Navigator.pop(context);
            }
          });

          return false;
        },
        child: Scaffold(
          appBar: AppBarW.appBarW("إضافة مخالفة", context, null),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  imageBG,
                  fit: BoxFit.fill,
                ),
              ),
              PageView(
                controller: controller,
                // physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  if (widget.page == 1)
                    individualUserInfo(vaiolationModel, nextPage),
                  if (widget.page == 2) companyinfo(vaiolationModel, nextPage),
                  bunud(
                    next: nextPage,
                    back: backPag,
                    vaiolationModel: vaiolationModel,
                  ),
                  attachment(
                    back: backPag,
                    vaiolationModel: vaiolationModel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    FocusScope.of(context).unfocus();
  }

  backPag() {
    // controller.previousPage(duration: duration, curve: curve)();
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    FocusScope.of(context).unfocus();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
