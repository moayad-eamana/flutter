import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Auhad extends StatefulWidget {
  Auhad({Key? key}) : super(key: key);

  @override
  State<Auhad> createState() => _AuhadState();
}

class _AuhadState extends State<Auhad> {
  dynamic _GetEmployeeCustodies = [];
  var ItemsCount = 0;
  EmployeeProfile empinfo = new EmployeeProfile();

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
  }

  getdata() async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    await getuserinfo();

    // print(empinfo.EmployeeNumber..toString().split(".")[0]);

    var respose = await getAction("HR/GetEmployeeCustodies/" +
        empinfo.EmployeeNumber.toString().split(".")[0]);

    setState(() {
      _GetEmployeeCustodies = (jsonDecode(respose.body)["CustodiesList"]);
      ItemsCount = (jsonDecode(respose.body)["ItemsCount"]);
      // print(_GetEmployeeCustodies);
      // print(ItemsCount);
    });
    EasyLoading.dismiss();
  }

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
                      "العهد",
                      style: titleTx(baseColor),
                    ),
                    Text(
                      "اجمالي العهد : " + ItemsCount.toString(),
                      style: titleTx(secondryColorText),
                    ),
                  ],
                ),
                _GetEmployeeCustodies == null
                    ? Center(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "لا يوجد عهد",
                                style: subtitleTx(secondryColorText),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(children: [
                        ..._GetEmployeeCustodies.map((e) => Container(
                              height: 115,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: containerdecoration(Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "رقم العهدة : " + e["ItemCode"],
                                            style: subtitleTx(baseColor),
                                          ),
                                          Text(
                                            "الكمية : " +
                                                e["Balance"].toString(),
                                            style: subtitleTx(baseColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 2,
                                        // margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                        child: Divider(
                                          color: baseColorText,
                                          height: 10,
                                          thickness: 1,
                                          indent: 5,
                                          endIndent: 5,
                                        )),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      e["Title"],
                                      style: subtitleTx(secondryColorText),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            )).toList()
                      ]),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
