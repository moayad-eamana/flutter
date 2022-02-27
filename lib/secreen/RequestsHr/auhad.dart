import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class Auhad extends StatefulWidget {
  Auhad({Key? key}) : super(key: key);

  @override
  State<Auhad> createState() => _AuhadState();
}

class _AuhadState extends State<Auhad> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("العهد", context, null),
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.amber,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "االعهد",
                      style: titleTx(baseColor),
                    ),
                    Text(
                      "اجمالي العهد : " + "10",
                      style: titleTx(secondryColorText),
                    ),
                  ],
                ),
                // Expanded(
                //   child: Container(
                //       // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                //       child: Divider(
                //     color: baseColorText,
                //     height: 20,
                //     thickness: 1,
                //     indent: 5,
                //     endIndent: 5,
                //   )),
                // ),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: containerdecoration(Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "رقم العهدة : " + " 705",
                                style: subtitleTx(baseColor),
                              ),
                              Text(
                                "الكمية : " + "5",
                                style: subtitleTx(baseColor),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Divider(
                            color: baseColorText,
                            height: 20,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          )),
                        ),
                        Text(
                          "سيارة فورد صالون >> 1192 - ب ق ك 8467",
                          style: subtitleTx(secondryColorText),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
