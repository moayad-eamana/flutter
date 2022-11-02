import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/Meetings/manageTime/manageMettingTime.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/customerService/customerServiceActions/customerServiceRequests.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class meettingsType extends StatefulWidget {
  const meettingsType({Key? key}) : super(key: key);

  @override
  State<meettingsType> createState() => _meettingsTypeState();
}

class _meettingsTypeState extends State<meettingsType> {
  @override
  Widget build(BuildContext context) {
    double hi = SizerUtil.deviceType == DeviceType.mobile ? 100 : 140;
    print(SizerUtil.deviceType == DeviceType.mobile);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إدارة المواعيد", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 120,
                              child: ElevatedButton(
                                  style: cardServiece,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                          create: (context) =>
                                              MettingsProvider(),
                                          // ignore: prefer_const_constructors
                                          child: MeetingView(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: widgetsUni.cardcontentService(
                                      'assets/SVGs/mawa3idi.svg', "مواعيدي")),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              height: 120,
                              child: ElevatedButton(
                                  style: cardServiece,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              customerServiceRrequests(
                                                  "LeaderAppointment_dashboard")),
                                    );
                                  },
                                  child: widgetsUni.cardcontentService(
                                      'assets/SVGs/mawa3idi-mustafeed.svg',
                                      "مواعيد المستفيد")),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (sharedPref.getBool("permissionforAppManege3") == true)
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 120,
                                child: ElevatedButton(
                                    style: cardServiece,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                manegeMeetingTime()),
                                      );
                                    },
                                    child: widgetsUni.cardcontentService(
                                        'assets/SVGs/edit_calendar.svg',
                                        "إدارة المواعيد")),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Container(
                              height: 120,
                            ))
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
