import 'package:eamanaapp/provider/meeting/manageTime/ManageroutinTime.dart';
import 'package:eamanaapp/provider/meeting/manageTime/manegeMeetingTimeProvider.dart';
import 'package:eamanaapp/secreen/Meetings/manageTime/manageTimeBuDate.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'manageroutinTime.dart';

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
    super.initState();
  }

  getInfoRoutin() async {
    await manageroutinTime.getData();
    setState(() {});
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
            appBar: AppBarW.appBarW('إدارة المواعيد', context, null),
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Image.asset(
                    imageBG,
                    fit: BoxFit.fill,
                  ),
                ),
                manageroutinTime.appointments_timelist.length == 0
                    ? Container()
                    : index == 1
                        ? manageTimeBuDate(_provider)
                        : manageroutinTimeView(manageroutinTime)
              ],
            )));
  }
}
