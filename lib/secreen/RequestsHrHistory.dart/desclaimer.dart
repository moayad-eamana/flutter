import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class desclaimer extends StatefulWidget {
  const desclaimer({Key? key}) : super(key: key);

  @override
  State<desclaimer> createState() => _desclaimerState();
}

class _desclaimerState extends State<desclaimer> {
  List naif = [];
  @override
  void initState() {
    // TODO: implement initState
    getData1();
    super.initState();
  }

  getData1() async {
    var decodeNaif;
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (sharedPref.getString("dumyuser") != "10284928492") {
      decodeNaif = await getAction("HR/GetEmployeeEvacuations/" +
          sharedPref.getDouble("EmployeeNumber").toString().split(".")[0]);
      naif = jsonDecode(decodeNaif.body)["EvacuationList"] ?? [];
    } else {
      await Future.delayed(Duration(seconds: 1));
      naif = [];
    }

    setState(() {});
    EasyLoading.dismiss();
    print(naif);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إخلاء طرف", context, null),
        body: SingleChildScrollView(
          child: Container(
            height: 90.h,
            child: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                naif.length == 0
                    ? Center(
                        child: Text(
                          "لايوجد طلب",
                          style: titleTx(baseColor),
                        ),
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: naif.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: BackGColor,
                                elevation: 6,
                                child: ListTile(
                                  title: Text(
                                    " تاريخ الطلب:- " +
                                        naif[index]["RequestDate"]
                                            .toString()
                                            .split("T")[0],
                                    style: subtitleTx(baseColorText),
                                  ),
                                  subtitle: Text(
                                    naif[index]["Status"].toString() +
                                        " - " +
                                        naif[index]["Type"],
                                    style: subtitleTx(secondryColorText),
                                  ),
                                  leading: Text(
                                    naif[index]["RequestNumber"].toString(),
                                    style: titleTx(baseColor),
                                  ),
                                ),
                              );
                            }),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
