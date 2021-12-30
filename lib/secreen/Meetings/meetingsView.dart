import 'package:eamanaapp/provider/meetingsProvider.dart';
import 'package:eamanaapp/secreen/Meetings/AddMeeting.dart';
import 'package:eamanaapp/secreen/Meetings/EditMeetingView.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingView extends StatefulWidget {
  const MeetingView({Key? key}) : super(key: key);

  @override
  _MeetingViewState createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final s = ElevatedButton.styleFrom(
    side: const BorderSide(
      width: 1,
      color: Color(0xFFDDDDDD),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    primary: Colors.white, // background
    onPrimary: Colors.blue, // foreground
  );
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: 'loading...',
      );
      await Provider.of<MettingsProvider>(context, listen: false)
          .fetchMeetings();
      EasyLoading.dismiss();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MettingsProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/SVGs/background.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          _provider.meetingList.length == 0
              ? Container()
              : AnimationLimiter(
                  child: AnimatedList(
                      key: _key,
                      initialItemCount: _provider.meetingList.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index, anination) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: ScaleAnimation(
                            //  verticalOffset: 50.0,
                            curve: Curves.linear,

                            child: SizeTransition(
                              key: UniqueKey(),
                              sizeFactor: anination,
                              child: Container(
                                //margin: EdgeInsets.symmetric(vertical: 250),
                                height: 280,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Card(
                                  elevation: 1,
                                  //shadowColor: Colors.white,

                                  color: Colors.white.withOpacity(1),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            _provider
                                                .meetingList[index].Appwith,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color(0xff1f9EB9)),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 0.5,
                                          color: Color(0xff1DDDDD),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xff1F9EB9)),
                                                      color: const Color(
                                                          0xff1F9EB9),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.elliptical(
                                                                  5, 5))),
                                                  child: Text(
                                                    getmonth(_provider
                                                        .meetingList[index]
                                                        .Date),
                                                    style: const TextStyle(
                                                        fontFamily: "Cairo",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextW(DayText(_provider
                                                    .meetingList[index].Date)),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _provider.meetingList[index]
                                                      .Subject,
                                                  style: const TextStyle(
                                                      fontFamily: "Cairo",
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.date_range,
                                                      color: baseColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextW("يوم " +
                                                        _provider
                                                            .meetingList[index]
                                                            .Day +
                                                        " " +
                                                        _provider
                                                            .meetingList[index]
                                                            .Date),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.timelapse,
                                                      color: baseColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextW("الساعه من " +
                                                        _provider
                                                            .meetingList[index]
                                                            .Time
                                                            .split(":")[0] +
                                                        ":" +
                                                        _provider
                                                            .meetingList[index]
                                                            .Time
                                                            .split(":")[1] +
                                                        "إلى " +
                                                        "10:00"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.chair_alt_sharp,
                                                      color: baseColor,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextW(_provider
                                                        .meetingList[index]
                                                        .MeetingDetails),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: const Divider(
                                            thickness: 0.5,
                                            color: Color(0xff1DDDDDD),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    launch(
                                                        "https://wa.me/+966${_provider.meetingList[index].Appwithmobile}/?text=${Uri.parse("السلام عليكم ورحمة الله وبركاته")}");
                                                  },
                                                  icon: const Icon(
                                                    Icons.phone_android,
                                                    color: Color(0xff1F9EB9),
                                                  ),
                                                ),
                                                TextW(_provider
                                                    .meetingList[index]
                                                    .Appwithmobile),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: ElevatedButton.icon(
                                                    label: const Text('حذف'),
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.pink,
                                                      size: 24.0,
                                                    ),
                                                    style: mainbtn,
                                                    onPressed: () {
                                                      bool rej = true;
                                                      Alert(
                                                        context: context,
                                                        type: AlertType.warning,
                                                        title: "",
                                                        desc:
                                                            "هل انت متاكد من حذف الموعد",
                                                        buttons: [
                                                          DialogButton(
                                                            child: const Text(
                                                              "حذف",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                            onPressed: () {
                                                              rej = false;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            width: 120,
                                                          ),
                                                          DialogButton(
                                                            child: const Text(
                                                              "إلغاء",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            width: 120,
                                                          )
                                                        ],
                                                      )
                                                          .show()
                                                          .then((value) async {
                                                        if (!rej) {
                                                          EasyLoading.show(
                                                            status:
                                                                'loading...',
                                                          );
                                                          await _provider.deletApp(
                                                              int.parse(_provider
                                                                  .meetingList[
                                                                      index]
                                                                  .Id));
                                                          EasyLoading.dismiss();

                                                          Alert(
                                                            context: context,
                                                            type: AlertType
                                                                .success,
                                                            title: "",
                                                            desc:
                                                                "تم حذف الموع",
                                                            buttons: [
                                                              DialogButton(
                                                                child:
                                                                    const Text(
                                                                  "حسننا",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                width: 120,
                                                              ),
                                                            ],
                                                          )
                                                              .show()
                                                              .then((value) {
                                                            _key.currentState!.removeItem(
                                                                index,
                                                                (_, animation) {
                                                              return SizeTransition(
                                                                sizeFactor:
                                                                    animation,
                                                                child:
                                                                    Container(
                                                                  height: 250,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              );
                                                            },
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        600));

                                                            _provider
                                                                .deletan(index);
                                                          });
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: ElevatedButton.icon(
                                                    label: const Text('تعديل'),
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      color: Color(0xff1F9EB9),
                                                      size: 24.0,
                                                    ),
                                                    style: mainbtn,
                                                    onPressed: () {
                                                      print("sssssssss");
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeNotifierProvider.value(
                                                                  value:
                                                                      _provider,
                                                                  child:
                                                                      EditMeetingView(
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
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 10),
              child: FloatingActionButton(
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
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TextW(String v) {
    return Text(
      v,
      style: TextStyle(fontFamily: "Cairo"),
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
