import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';

class ViolatedVehicleList extends StatefulWidget {
  @override
  State<ViolatedVehicleList> createState() => _ViolatedVehicleListState();
}

class _ViolatedVehicleListState extends State<ViolatedVehicleList> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("السيارات المسحوبة", context, null),
          body: Container()),
    );
  }
}
