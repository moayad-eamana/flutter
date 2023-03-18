import 'package:eamanaapp/secreen/services/EmployeeCard.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';

class AndroidWallet4 extends StatefulWidget {
  const AndroidWallet4({Key? key}) : super(key: key);

  @override
  State<AndroidWallet4> createState() => _AndroidWallet4State();
}

class _AndroidWallet4State extends State<AndroidWallet4> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(children: [
            widgetsUni.bacgroundimage(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )),
                  ),
                  EmployeeCard(null),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
