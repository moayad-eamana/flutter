import 'dart:convert';

import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/ViolatedVehicleDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';

class ViolatedVehicleList extends StatefulWidget {
  @override
  State<ViolatedVehicleList> createState() => _ViolatedVehicleListState();
}

class _ViolatedVehicleListState extends State<ViolatedVehicleList> {
  List VehicleList = [];
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var resbonse = await getAction("ViolatedCars/GetViolatedCarsRequests/1");

    VehicleList = jsonDecode(resbonse.body)["data"];
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("السيارات المسحوبة", context, null),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: VehicleList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ignore: prefer_const_constructors
                                builder: (BuildContext context) {
                                  return ViolatedVehichleDetails(
                                      VehicleList[index]);
                                },
                              ),
                            );
                          },
                          child: Card(
                            child: Container(
                              decoration: containerdecoration(Colors.white),
                              child: ListTile(
                                title: Text(
                                  VehicleList[index]["StatusName"],
                                  style: subtitleTx(baseColor),
                                ),
                                leading: Text(
                                  VehicleList[index]["RequestID"].toString(),
                                  style: subtitleTx(secondryColor),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      "نوع السيارة:  " +
                                          VehicleList[index]["VehicleType"] +
                                          " - ",
                                      style: descTx1(baseColorText),
                                    ),
                                    Text(
                                      "التاريخ: " +
                                          VehicleList[index]["RequestDate"]
                                              .toString()
                                              .split("T")[0],
                                      style: descTx1(baseColorText),
                                    ),
                                  ],
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          )),
    );
  }
}
