import 'package:eamanaapp/secreen/customerService/reserveForcustomer/getuserInfo.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("حجز الموعد للمستفيد", context, null),
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
