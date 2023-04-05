import 'package:eamanaapp/secreen/ViolatedVehicle/SendWarrningToViolatedVehicle/GetViolatedVehicleInfo.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/SendWarrningToViolatedVehicle/ViolatedVehicleLocation.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'ViolatedVehicleAttachment.dart';

class WarnViolatedVehiclePageView extends StatefulWidget {
  const WarnViolatedVehiclePageView({Key? key}) : super(key: key);

  @override
  State<WarnViolatedVehiclePageView> createState() =>
      _WarnViolatedVehiclePageViewState();
}

class _WarnViolatedVehiclePageViewState
    extends State<WarnViolatedVehiclePageView> {
  final PageController controller = PageController();
  ViolatedVehicle violatedVehicle = ViolatedVehicle();
  @override
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;
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
        appBar: AppBarW.appBarW("إنذار السيارة", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                GetViolationVehicleInfo(violatedVehicle, nextPage),
                ViolatedVehicleLocation(
                  violatedVehicle: violatedVehicle,
                  nextPage: nextPage,
                  backPage: backPage,
                ),
                ViolatedVehicleAttachment(violatedVehicle, backPage)
              ],
            )
          ],
        ),
      ),
    );
  }

  nextPage() {
    //  controller.nextPage(duration: Duration.zero, curve: curve)

    // setState(() {});
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
}

class ViolatedVehicle {
  dynamic carInfo;
  dynamic MuniciplaityInfo = {};
  List AttachementsInfo = [];
  dynamic sendwarning = {};
}
