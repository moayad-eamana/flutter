import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/meeting/manageTime/ManageroutinTime.dart';
import 'package:eamanaapp/provider/meeting/manageTime/manegeMeetingTimeProvider.dart';
import 'package:eamanaapp/secreen/Meetings/manageTime/manageTimeBuDate.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'manageroutinTime.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class manegeMeetingTime extends StatefulWidget {
  @override
  State<manegeMeetingTime> createState() => _manegeMeetingTimeState();
}

class _manegeMeetingTimeState extends State<manegeMeetingTime> {
  manegeMeetingTimeProvider _provider = manegeMeetingTimeProvider();

  ManageroutinTime manageroutinTime = ManageroutinTime();
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    getInfoRoutin();
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "CRMController";
    logapiO.ClassName = "CRMController";
    logapiO.ActionMethodName = "إدارة المواعيد";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);
    super.initState();
  }

  getInfoRoutin() async {
    await manageroutinTime.getData();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              // backgroundColor: baseColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.rotate_left_outlined),
                  label: 'روتيني',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_week),
                  label: 'إسبوعي',
                ),
              ],
              currentIndex: index,
              // unselectedItemColor: Colors.white,
              selectedItemColor: secondryColor,
              onTap: (int index2) {
                index = index2;
                setState(() {});
              },
            ),
            appBar: AppBarW.appBarW(
                'إدارة المواعيد',
                context,
                null,
                index == 1
                    ? () async {
                        await _provider.insert(context);
                        setState(() {});
                      }
                    : null),
            body: Stack(
              children: [
                widgetsUni.bacgroundimage(),
                manageroutinTime.appointments_timelist.length == 0
                    ? Container()
                    : index == 1
                        ? manageTimeBuDate(_provider)
                        : manageroutinTimeView(manageroutinTime)
              ],
            )));
  }
}
