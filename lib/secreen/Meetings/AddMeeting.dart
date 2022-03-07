import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/meeting/meetings.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddMeeting extends StatefulWidget {
  const AddMeeting({Key? key}) : super(key: key);

  @override
  _AddMeetingState createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  final key = GlobalKey<AnimatedListState>();
  List<TextEditingController> error = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  TextEditingController _appWith = TextEditingController();
  TextEditingController _subject = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _Time = TextEditingController();
  TextEditingController _tpeApp = TextEditingController();
  TextEditingController _url = TextEditingController();
  TextEditingController _meetingId = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _notes = TextEditingController();
  List<String> TimsAvilable = [];

  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (Provider.of<MettingsProvider>(context, listen: false)
              .getMeetingsTimeList
              .length ==
          0) {
        EasyLoading.show(
          status: 'جاري المعالجة...',
          maskType: EasyLoadingMaskType.black,
        );
        await Provider.of<MettingsProvider>(context, listen: false)
            .fetchMeetingsTime();
        EasyLoading.dismiss();
        fetchMeetinsTime(Provider.of<MettingsProvider>(context, listen: false)
            .getMeetingsTimeList);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MettingsProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("إضافة موعد", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: BackGWhiteColor,
                    border: Border.all(color: bordercolor)),
                child: Column(
                  children: [
                    Container(
                      color: BackGWhiteColor,
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: StaggeredGrid.count(
                        crossAxisCount: responsiveGrid(1, 2),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,

                        //  shrinkWrap: true,

                        children: [
                          TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _appWith,
                            decoration: decoration("الموعد مع", 0),
                            onChanged: (String val) {
                              if (val == "") {
                                setState(() {
                                  error[0].text = errorTx(0);
                                });
                              } else {
                                setState(() {
                                  error[0].text = "";
                                });
                              }
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _mobile,
                            decoration: decoration("رقم الجوال", 6),
                            onChanged: (String val) {
                              if (val == "") {
                                setState(() {
                                  error[6].text = errorTx(6);
                                });
                              } else {
                                setState(() {
                                  error[6].text = "";
                                });
                              }
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _subject,
                            decoration: decoration("الموضوع", 1),
                            onChanged: (String val) {
                              if (val == "") {
                                setState(() {
                                  error[1].text = errorTx(1);
                                });
                              } else {
                                setState(() {
                                  error[1].text = "";
                                });
                              }
                            },
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            controller: _date,
                            decoration: decoration("التاريخ", 2),
                            onChanged: (String val) {
                              if (val == "") {
                                setState(() {
                                  error[2].text = errorTx(2);
                                });
                              } else {
                                setState(() {
                                  error[2].text = "";
                                });
                              }
                            },
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 3, 5),
                                  onChanged: (date) {
                                _date.text = date.toString().split(" ")[0];
                                print('change $date');
                              }, onConfirm: (date) {
                                _date.text = date.toString().split(" ")[0];

                                error[1].text = "";

                                fetchMeetinsTime(_provider.getMeetingsTimeList);
                                print('confirm $date');
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.ar);
                            },
                          ),
                          DropdownSearch<String>(
                            items: TimsAvilable.length == 0 ? [] : TimsAvilable,
                            //maxHeight: 300,
                            selectedItem: _Time.text,
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: true,
                            showAsSuffixIcons: true,

                            dropdownSearchDecoration:
                                decoration("الاوقات المتاحة", 7),
                            showSearchBox: true,
                            onChanged: (String? v) {
                              if (v == "") {
                                setState(() {
                                  error[7].text = errorTx(7);
                                });
                              } else {
                                setState(() {
                                  error[7].text = "";
                                });
                              }
                              _Time.text = v ?? "";
                            },

                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'الاوقات المتاحة',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          DropdownSearch<String>(
                            items: ["حضوري", "إفتراضي"],
                            //maxHeight: 300,
                            selectedItem:
                                _tpeApp.text == "" ? "" : _tpeApp.text,
                            mode: Mode.BOTTOM_SHEET,
                            showClearButton: true,
                            showAsSuffixIcons: true,
                            dropdownSearchDecoration:
                                decoration("نوع الإجتماع", 8),

                            showSearchBox: true,

                            onChanged: (String? v) {
                              v = v ?? "";

                              setState(() {
                                _tpeApp.text = v ?? "";
                              });
                              if (v == "") {
                                setState(() {
                                  error[8].text = errorTx(8);
                                });
                              } else {
                                setState(() {
                                  error[8].text = "";
                                });
                              }
                            },

                            popupTitle: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'نوع الاجتماع',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            popupShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          if (_tpeApp.text == "إفتراضي")
                            TextField(
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              controller: _url,
                              decoration: decoration("رابط الإجتماع", 3),
                              onChanged: (String val) {
                                if (_tpeApp.text == "إفتراضي") {
                                  if (val == "") {
                                    setState(() {
                                      error[3].text = errorTx(3);
                                    });
                                  } else {
                                    setState(() {
                                      error[3].text = "";
                                    });
                                  }
                                }
                              },
                            ),
                          if (_tpeApp.text == "إفتراضي")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _meetingId,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    decoration: decoration("الرقم المعرف", 4),
                                    onChanged: (String val) {
                                      if (_tpeApp.text == "إفتراضي") {
                                        if (val == "") {
                                          setState(() {
                                            error[4].text = errorTx(4);
                                          });
                                        } else {
                                          setState(() {
                                            error[4].text = "";
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    controller: _pass,
                                    decoration: decoration("كلمة السر", 5),
                                    onChanged: (String val) {
                                      if (_tpeApp.text == "إفتراضي") {
                                        if (val == "") {
                                          setState(() {
                                            error[5].text = errorTx(5);
                                          });
                                        } else {
                                          setState(() {
                                            error[5].text = "";
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: _notes,
                            maxLines: 3,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: responsiveMT(12, 30),
                                  horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(color: bordercolor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bordercolor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bordercolor),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "ملاحظات",
                              alignLabelWithHint: true,
                            ),
                            onChanged: (String val) {
                              if (val == "") {
                                setState(() {
                                  error[1].text = "الرجاء إدخال التاريخ";
                                });
                              } else {
                                setState(() {
                                  error[1].text = "";
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: responsiveMT(20, 40)),
                      child: ElevatedButton(
                        style: mainbtn,
                        onPressed: () {
                          bool isFalse = checkInputs();
                          if (isFalse) {
                            return;
                          }
                          bool rej = true;
                          late Meetings meetings = Meetings(
                              "",
                              _date.text,
                              _meetingId.text,
                              _Time.text,
                              _appWith.text,
                              _mobile.text,
                              _subject.text,
                              _notes.text,
                              _tpeApp.text == "حضوري" ? "p" : "v",
                              _url.text ?? "",
                              _meetingId.text,
                              _pass.text);

                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "",
                            desc: "تأكيد إضافة الموعد",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "نعم",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                  rej = false;

                                  Navigator.pop(context);
                                },
                                width: 120,
                              ),
                              DialogButton(
                                child: const Text(
                                  "إلغاء",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show().then((value) async {
                            if (!rej) {
                              EasyLoading.show(
                                status: 'جاري المعالجة...',
                                maskType: EasyLoadingMaskType.black,
                              );
                              await _provider.addApp(meetings, p);
                              EasyLoading.dismiss();
                              Alerts.successAlert(
                                      context, "", "تم إضافة الموعد")
                                  .show()
                                  .then((value) => Navigator.pop(context));
                            }
                          });
                        },
                        child: const Text('إضافة موعد'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  decoration(String val, int i) {
    return InputDecoration(
      errorText: error[i].text == "" ? null : error[i].text,
      contentPadding: EdgeInsets.symmetric(
          vertical: responsiveMT(12, 30), horizontal: 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: bordercolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bordercolor),
        borderRadius: BorderRadius.circular(4),
      ),
      filled: true,
      fillColor: Colors.white,
      labelText: val,
      alignLabelWithHint: true,
    );
  }

  String p = "";
  fetchMeetinsTime(var pro) {
    var s = _date.text;
    TimsAvilable = [];

    for (int i = 0; i < pro.length; i++) {
      if (pro[i].date == s) {
        TimsAvilable.add(pro[i].Time);
        p = pro[i].dow;
      }
    }
    setState(() {
      TimsAvilable = TimsAvilable;
    });

    print(TimsAvilable);
  }

  bool checkInputs() {
    bool isFalse = false;
    if (_appWith.text == "") {
      isFalse = true;
      setState(() {
        error[0].text = errorTx(0);
      });
    }
    if (_subject.text == "") {
      isFalse = true;
      setState(() {
        error[1].text = errorTx(1);
      });
    }
    if (_date.text == "") {
      isFalse = true;
      setState(() {
        error[2].text = errorTx(2);
      });
    }
    if (_tpeApp.text == "") {
      isFalse = true;
      setState(() {
        error[8].text = errorTx(8);
      });
    }
    if (_tpeApp.text == "إفتراضي") {
      if (_url.text == "") {
        isFalse = true;
        setState(() {
          error[3].text = errorTx(3);
        });
      }

      if (_meetingId.text == "") {
        isFalse = true;
        setState(() {
          error[4].text = errorTx(4);
        });
      }
      if (_pass.text == "") {
        isFalse = true;
        setState(() {
          error[5].text = errorTx(5);
        });
      }
    }

    if (_mobile.text == "") {
      isFalse = true;
      setState(() {
        error[6].text = errorTx(6);
      });
    }

    if (_Time.text == "") {
      isFalse = true;
      setState(() {
        error[7].text = errorTx(7);
      });
    }
    if (_tpeApp.text == "") {
      error[8].text = errorTx(8);
    }
    return isFalse;
  }

  String errorTx(int index) {
    String errorTx = "";
    if (index == 0) {
      errorTx = "الرجاء إدحال الاسم";
    } else if (index == 1) {
      errorTx = "الرجاء إدحال الموضوع";
    } else if (index == 2) {
      errorTx = "الرجاء إدحال التاريخ";
    }
    if (_tpeApp.text == "إفتراضي") {
      if (index == 3) {
        errorTx = "الرجاء إدحال رابط الاجتماع";
      }
      if (index == 4) {
        errorTx = "الرجاء إدحال الرقم المعرف";
      }
      if (index == 5) {
        errorTx = "الرجاء إدحال كلمة السر ";
      }
    }
    if (index == 6) {
      errorTx = "الرجاء إدخال رقم الجوال";
    }
    if (index == 7) {
      errorTx = "الرجاء إدخال الوقت";
    }
    if (index == 8) {
      errorTx = "الرجاء إددخال نوع الاجتماع";
    }

    return errorTx;
  }
}
