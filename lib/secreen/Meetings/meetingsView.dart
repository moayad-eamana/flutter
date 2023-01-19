import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/handelCalander.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_calendar/device_calendar.dart' as calendar;
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class MeetingView extends StatefulWidget {
  MeetingView({Key? key}) : super(key: key);

  @override
  _MeetingViewState createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final s = ElevatedButton.styleFrom(
    side: BorderSide(
      width: 1,
      color: bordercolor,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    primary: Colors.white, // background
    onPrimary: baseColor, // foreground
  );
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: '... جاري المعالجة',
        maskType: EasyLoadingMaskType.black,
      );
      if (hasePerm == "true") {
        await Provider.of<MettingsProvider>(context, listen: false)
            .fetchMeetings();
      } else {
        await Provider.of<MettingsProvider>(context, listen: false)
            .getAppointmentsByLeader();
      }

      EasyLoading.dismiss();
    });
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "CRMController";
    logapiO.ClassName = "CRMController";
    logapiO.ActionMethodName = "مواعيدي";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;

    logApi(logapiO);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  Future<void> history1() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    if (hasePerm == "true") {
      await Provider.of<MettingsProvider>(context, listen: false)
          .fetchMeetingshistory();
    } else {
      await Provider.of<MettingsProvider>(context, listen: false)
          .getAppointmentsByLeaderHistory();
    }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MettingsProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("مواعيدي", context, null, history1),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            _provider.meetingList.length == 0
                ? Center(child: TextW("لايوجد لديك مواعيد"))
                : AnimationLimiter(
                    child: GridView.builder(
                        key: _key,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (width >= 768.0 ? 2 : 1),
                            mainAxisSpacing: 10,
                            mainAxisExtent: 300),
                        shrinkWrap: true,
                        itemCount: _provider.meetingList.length,
                        itemBuilder: (BuildContext context, index) {
                          var parsedDate = DateTime.parse("2012-02-27 " +
                              _provider.meetingList[index].Time.toString());

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider.value(
                                          value: _provider,
                                          child: EditMeetingView(index)),
                                ),
                              );
                            },
                            child: AnimationConfiguration.staggeredList(
                              position: index,
                              duration: Duration(milliseconds: 375),
                              child: ScaleAnimation(
                                //  verticalOffset: 50.0,
                                curve: Curves.easeInOut,

                                child: Container(
                                  //margin: EdgeInsets.symmetric(vertical: 250),
                                  height: 280,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 10),
                                  child: Card(
                                    elevation: 1,
                                    //shadowColor: Colors.white,

                                    color: BackGWhiteColor,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              _provider.meetingList[index]
                                                      .Appwith ??
                                                  "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: baseColor),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: bordercolor,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: bordercolor),
                                                        color: secondryColor,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .elliptical(
                                                                        5, 5))),
                                                    child: Text(
                                                      getmonth(_provider
                                                              .meetingList[
                                                                  index]
                                                              .Date ??
                                                          ""),
                                                      style: TextStyle(
                                                          fontFamily: "Cairo",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  TextW(DayText(_provider
                                                          .meetingList[index]
                                                          .Date ??
                                                      "")),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _provider.meetingList[index]
                                                            .Subject ??
                                                        "",
                                                    style: TextStyle(
                                                        color: baseColorText,
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.date_range,
                                                        color: baseColor,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      TextW("يوم " +
                                                          _provider
                                                              .meetingList[
                                                                  index]
                                                              .Day
                                                              .toString() +
                                                          " " +
                                                          _provider
                                                              .meetingList[
                                                                  index]
                                                              .Date
                                                              .toString()),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timelapse,
                                                        color: baseColor,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      TextW("الساعه من " +
                                                          _provider
                                                              .meetingList[
                                                                  index]
                                                              .Time
                                                              .toString()
                                                              .split(":")[0] +
                                                          ":" +
                                                          _provider
                                                              .meetingList[
                                                                  index]
                                                              .Time
                                                              .toString()
                                                              .split(":")[1] +
                                                          "إلى " +
                                                          (parsedDate
                                                                  .add(Duration(
                                                                      minutes:
                                                                          30))
                                                                  .toString())
                                                              .split(" ")[1]
                                                              .substring(0, 5)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.chair_alt_sharp,
                                                        color: baseColor,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      TextW(_provider
                                                              .meetingList[
                                                                  index]
                                                              .MeetingDetails
                                                              .toString() +
                                                          "-" +
                                                          (_provider
                                                                          .meetingList[
                                                                              index]
                                                                          .for_leader
                                                                          .toString() ==
                                                                      "null" ||
                                                                  _provider
                                                                          .meetingList[
                                                                              index]
                                                                          .for_leader
                                                                          .toString() ==
                                                                      "y"
                                                              ? "قيادي"
                                                              : "إدارة")),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            //color: Colors.white,
                                            child: Divider(
                                              thickness: 0.5,
                                              color: bordercolor,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: hasePerm ==
                                                    "true"
                                                ? MainAxisAlignment.spaceAround
                                                : MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      launch(
                                                          "https://wa.me/+966${_provider.meetingList[index].Appwithmobile}/?text=${Uri.parse("السلام عليكم ورحمة الله وبركاته")}");
                                                    },
                                                    icon: Icon(
                                                      FontAwesomeIcons.whatsapp,
                                                      color: baseColor,
                                                    ),
                                                  ),
                                                  TextW(_provider
                                                          .meetingList[index]
                                                          .Appwithmobile ??
                                                      ""),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  if (hasePerm == "true")
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child:
                                                          ElevatedButton.icon(
                                                        label: Text('حذف'),
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: pinkColor,
                                                          size: 24.0,
                                                        ),
                                                        style: mainbtn,
                                                        onPressed: () {
                                                          bool rej = true;
                                                          Alert(
                                                            context: context,
                                                            type: AlertType
                                                                .warning,
                                                            title: "",
                                                            desc: "تأكيد الحذف",
                                                            buttons: [
                                                              DialogButton(
                                                                child: Text(
                                                                  "حذف",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                onPressed: () {
                                                                  rej = false;
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                width: 120,
                                                              ),
                                                              DialogButton(
                                                                child: Text(
                                                                  "إلغاء",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                                width: 120,
                                                              )
                                                            ],
                                                          ).show().then(
                                                              (value) async {
                                                            if (!rej) {
                                                              EasyLoading.show(
                                                                status:
                                                                    '... جاري المعالجة',
                                                                maskType:
                                                                    EasyLoadingMaskType
                                                                        .black,
                                                              );
                                                              var availableCalendars =
                                                                  await calendar
                                                                              .DeviceCalendarPlugin
                                                                          .private()
                                                                      .retrieveCalendars();
                                                              var defaultCalendarId =
                                                                  availableCalendars
                                                                      .data?[0]
                                                                      .id;
                                                              await calendar
                                                                          .DeviceCalendarPlugin
                                                                      .private()
                                                                  .deleteEvent(
                                                                      defaultCalendarId,
                                                                      sharedPref.getString(_provider
                                                                          .meetingList[
                                                                              index]
                                                                          .Id
                                                                          .toString()));
                                                              sharedPref.remove(
                                                                  _provider
                                                                      .meetingList[
                                                                          index]
                                                                      .Id
                                                                      .toString());
                                                              await handelCalander.deletFromCalander(
                                                                  sharedPref.getString(_provider
                                                                          .meetingList[
                                                                              index]
                                                                          .Id
                                                                          .toString()) ??
                                                                      "dd");

                                                              await _provider.deletApp(
                                                                  int.parse(_provider
                                                                          .meetingList[
                                                                              index]
                                                                          .Id ??
                                                                      ""));
                                                              EasyLoading
                                                                  .dismiss();

                                                              Alert(
                                                                context:
                                                                    context,
                                                                type: AlertType
                                                                    .success,
                                                                title: "",
                                                                desc:
                                                                    "تم حذف الموعد",
                                                                buttons: [
                                                                  DialogButton(
                                                                    child: Text(
                                                                      "حسننا",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    width: 120,
                                                                  ),
                                                                ],
                                                              ).show().then(
                                                                  (value) {
                                                                if (!_provider
                                                                    .meetingList
                                                                    .isNotEmpty) {
                                                                  _key.currentState!.removeItem(
                                                                      index, (_,
                                                                          animation) {
                                                                    return SizeTransition(
                                                                      sizeFactor:
                                                                          animation,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            250,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    );
                                                                  },
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              600));
                                                                }

                                                                _provider
                                                                    .deletan(
                                                                        index);
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  if (hasePerm == "true")
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 10),
                                                      child:
                                                          ElevatedButton.icon(
                                                        label: Text('تعديل'),
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color: secondryColor,
                                                          size: 24.0,
                                                        ),
                                                        style: mainbtn,
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChangeNotifierProvider.value(
                                                                      value:
                                                                          _provider,
                                                                      child: EditMeetingView(
                                                                          index)),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            if (hasePerm == "true")
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  child: FloatingActionButton(
                    backgroundColor: baseColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                              value: _provider, child: AddMeeting()),
                        ),
                      );
                    },
                    // backgroundColor: Colors.green,
                    child: Icon(Icons.add),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget TextW(String v) {
    return Text(
      v,
      style: TextStyle(fontFamily: "Cairo", color: baseColorText),
    );
  }

  String DayText(String day) {
    day = day.split("-")[1];

    var Days = [
      {"no": "01", "day": "يناير"},
      {"no": "02", "day": "فبراير"},
      {"no": "03", "day": "مارس"},
      {"no": "04", "day": "إبريل"},
      {"no": "05", "day": "مايو"},
      {"no": "06", "day": "يونيو"},
      {"no": "07", "day": "يوليو"},
      {"no": "08", "day": "أغسطس"},
      {"no": "09", "day": "سبتمبر"},
      {"no": "10", "day": "أكتوبر"},
      {"no": "11", "day": "نوفمبر"},
      {"no": "12", "day": "ديسمبر"}
    ];
    for (int i = 0; i < Days.length; i++) {
      if (Days[i]["no"] == day) {
        day = Days[i]["day"] as String;
      }
    }
    return day;
  }

  String getmonth(String date) {
    return (date.split("-")[1]);
  }
}
