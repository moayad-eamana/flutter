import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class AndroidWallet2 extends StatelessWidget {
  Widget cardW;
  AndroidWallet2(this.cardW);

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
                          Navigator.pop(context);
                        },
                      )),
                ),
                Stack(children: [
                  widgetsUni.bacgroundimage(),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
