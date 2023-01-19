import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/customerService/reserveForcustomer/getuserInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class reserveForcustomer extends StatefulWidget {
  @override
  State<reserveForcustomer> createState() => _reserveForcustomerState();
}

class _reserveForcustomerState extends State<reserveForcustomer> {
  final PageController controller = PageController();
  void initState() {
    // TODO: implement initState
    controller.initialPage;
    controller.keepPage;

    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "CRMController";
    logapiO.ClassName = "CRMController";
    logapiO.ActionMethodName = "حجز الموعد للمستفيد";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
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
        appBar: AppBarW.appBarW("حجز الموعد للمستفيد", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            PageView(
              controller: controller,
              children: <Widget>[
                getusrtInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
