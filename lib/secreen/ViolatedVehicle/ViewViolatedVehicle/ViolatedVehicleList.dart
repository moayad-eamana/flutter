import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/ViolatedVehiclepanels.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class ViolatedVehicleList extends StatefulWidget {
  int typeId;
  ViolatedVehicleList(this.typeId);
  @override
  State<ViolatedVehicleList> createState() => _ViolatedVehicleListState();
}

class _ViolatedVehicleListState extends State<ViolatedVehicleList> {
  List VehicleList = [];
  bool isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    getData("0");
    super.initState();
  }

  getData(String statuseID) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var resbonse;
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "GetViolatedCarsRequests";
    logapiO.ClassName = "GetViolatedCarsRequests";
    logapiO.ActionMethodName = "إستعلام السيارات المسحوبة";
    logapiO.EmployeeNumber = int.parse(EmployeeProfile.getEmployeeNumber());
    logapiO.ActionMethodType = 1;
    if (widget.typeId == -1) {
      resbonse =
          await getAction("ViolatedCars/GetViolatedCarsRequests/" + statuseID);
    } else {
      resbonse = await getAction("Inbox/GetViolatedVehiclesRequests/" +
          EmployeeProfile.getEmployeeNumber());
    }
    logapiO.StatusCode = 1;
    logApi(logapiO);
    isloading = false;
    VehicleList = jsonDecode(resbonse.body)["data"] ?? [];
    //VehicleList = VehicleList.reversed.toList();
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            appBar: widget.typeId == -1
                ? AppBar(
                    bottom: TabBar(
                      labelColor: baseColor,
                      onTap: (value) {
                        print(value);
                        if (value == 1) {
                          value = 10;
                        } else if (value == 2) {
                          value = 7;
                        } else {
                          value = 0;
                        }
                        getData(value.toString());
                      },
                      tabs: [
                        Tab(
                          child: Text("تحت الإجراء"),
                        ),
                        Tab(
                          child: Text("منتهية"),
                        ),
                        Tab(
                          child: Text("متلفة"),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    title: Text(
                      'السيارات المسحوبة',
                      style: titleTx(secondryColor),
                    ),
                  )
                : AppBarW.appBarW("السيارات المسحوبة", context, null),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Stack(
                  children: [
                    widgetsUni.bacgroundimage(),
                    VehicleList.length == 0 && isloading == false
                        ? Container(
                            height: 100.h,
                            child: Center(
                              child: Text(
                                "لايوجد بيانات",
                                style: titleTx(baseColor),
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: VehicleList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      // ignore: prefer_const_constructors
                                      builder: (BuildContext context) {
                                        return ViolatedVehichleDetails(
                                            VehicleList[index], widget.typeId);
                                      },
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Container(
                                    decoration:
                                        containerdecoration(Colors.white),
                                    child: ListTile(
                                      title: Text(
                                        VehicleList[index]["StatusName"],
                                        style: subtitleTx(baseColor),
                                      ),
                                      leading: Text(
                                        VehicleList[index]["RequestID"]
                                            .toString(),
                                        style: subtitleTx(secondryColor),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            "نوع السيارة:  " +
                                                VehicleList[index]
                                                    ["VehicleType"] +
                                                " - ",
                                            style: descTx1(baseColorText),
                                          ),
                                          Text(
                                            "التاريخ: " +
                                                VehicleList[index]
                                                        ["RequestDate"]
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
                            })
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
