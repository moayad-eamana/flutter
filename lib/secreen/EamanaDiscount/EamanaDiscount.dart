import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EamanaDiscount extends StatefulWidget {
  @override
  _EamanaDiscountState createState() => _EamanaDiscountState();
}

class _EamanaDiscountState extends State<EamanaDiscount> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("عروض الموظفين", context),
        body: Container(
          height: 100,
          decoration: containerdecoration(Colors.white),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 100.w <= 375 ? 100 : 120,
                        child: Stack(
                          fit: StackFit.loose,
                          overflow: Overflow.visible,
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Container(
                              height: 45,
                              decoration: containerdecoration(baseColor),
                              child: Row(
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "70%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "خصم",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: -9,
                              left: 0.2,
                              child: Container(
                                height: 25,
                                width: 60,
                                decoration: containerdecoration(secondryColor),
                                child: Center(
                                    child: Text(
                                  "ترفيهي",
                                  style: descTx1(Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "العرض ساري حتى تاريخ  2020/02/12",
                        style:
                            TextStyle(fontSize: 10, color: secondryColorText),
                      )
                    ],
                  ),
                  Text(
                    "شركة مؤيد العوفي",
                    style: subtitleTx(baseColorText),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.download,
                    size: 30,
                    color: secondryColor,
                  ),
                  Text(
                    "إستعراض",
                    style: TextStyle(fontSize: 10, color: secondryColorText),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
