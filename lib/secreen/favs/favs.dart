import 'dart:convert';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/Settings/settings%20copy.dart';
import 'package:eamanaapp/secreen/widgets/StaggeredGridTileW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/ActionOfServices.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class favoriot extends StatefulWidget {
  const favoriot({required this.context, Key? key}) : super(key: key);
  final BuildContext context;

  @override
  State<favoriot> createState() => _favoriotState();
}

class _favoriotState extends State<favoriot> {
  List<dynamic> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((val) {
      list = listOfFavs(context);
      setState(() {});
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("خدماتي المفضلة", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            list.isEmpty
                ? Center(
                    child: Text(
                      "لايوجد خدمات مفضلة",
                      style: titleTx(baseColorText),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                    margin: EdgeInsets.all(10),
                    child: StaggeredGrid.count(
                      crossAxisCount:
                          SizerUtil.deviceType == DeviceType.mobile ? 3 : 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      children: [
                        ...list.map((e) {
                          return ServiceButton(e, context);
                        }),
                      ],
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
