import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class customerservicesmettings extends StatefulWidget {
  const customerservicesmettings({Key? key}) : super(key: key);

  @override
  State<customerservicesmettings> createState() =>
      _customerservicesmettingsState();
}

class _customerservicesmettingsState extends State<customerservicesmettings> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("طلبات المستفيد", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
