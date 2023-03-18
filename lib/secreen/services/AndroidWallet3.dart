import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sizer/sizer.dart';

class AndroidWallet3 extends StatefulWidget {
  Widget cardW;
  Widget cardW2;

  AndroidWallet3(this.cardW, this.cardW2);

  @override
  State<AndroidWallet3> createState() => _AndroidWallet3State();
}

class _AndroidWallet3State extends State<AndroidWallet3> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Container(
          child: SingleChildScrollView(
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
                          print("object");
                          Navigator.pop(context);
                        },
                      )),
                ),
                Stack(children: [
                  widgetsUni.bacgroundimage(),
                  Column(
                    children: [
                      Container(
                        height: 580,
                        child: PageView(
                          onPageChanged: (value) {
                            print(value);
                            index = value;
                            setState(() {});
                          },
                          // shrinkWrap: true,
                          dragStartBehavior: DragStartBehavior.down,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            widget.cardW,
                            widget.cardW2,
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabPageSelectorIndicator(
                            backgroundColor:
                                index == 0 ? secondryColorText : baseColor,
                            borderColor: secondryColorText,
                            size: 10,
                          ),
                          TabPageSelectorIndicator(
                            backgroundColor:
                                index == 0 ? baseColor : secondryColorText,
                            borderColor: baseColor,
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
