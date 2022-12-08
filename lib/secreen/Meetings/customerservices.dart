import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class customerservicesmettings extends StatefulWidget {
  const customerservicesmettings({Key? key}) : super(key: key);

  @override
  State<customerservicesmettings> createState() =>
      _customerservicesmettingsState();
}

class _customerservicesmettingsState extends State<customerservicesmettings> {
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
        appBar: AppBarW.appBarW("طلبات المستفيد", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
