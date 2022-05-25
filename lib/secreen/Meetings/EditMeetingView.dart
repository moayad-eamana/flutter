import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EditMeetingView extends StatefulWidget {
  int? index;
  EditMeetingView(this.index);

  @override
  _EditMeetingViewState createState() => _EditMeetingViewState();
}

class _EditMeetingViewState extends State<EditMeetingView> {
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
  String pp = "";
  bool isLoaded = false;
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      pp = (Provider.of<MettingsProvider>(context, listen: false)
                  .meetingList[widget.index ?? 0]
                  .MeetingDetails ==
              "إفتراضي"
          ? "v"
          : "p");
      if (Provider.of<MettingsProvider>(context, listen: false)
              .getMeetingsTimeList
              .length ==
          0) {
        EasyLoading.show(
          status: '... جاري المعالجة',
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
  void dispose() {
    // TODO: implement dispose
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<MettingsProvider>(context);

    if (_provider.getMeetingsTimeList.length < 0) {
      fetchMeetinsTime(_provider.getMeetingsTimeList);
    } else {
      if (!isLoaded) {
        _appWith.text = _provider.meetingList[widget.index ?? 0].Appwith;
        _subject.text = _provider.meetingList[widget.index ?? 0].Subject;
        _mobile.text = _provider.meetingList[widget.index ?? 0].Appwithmobile;
        _date.text = _provider.meetingList[widget.index ?? 0].Date;
        _Time.text = _provider.meetingList[widget.index ?? 0].Time;
        _tpeApp.text = _provider.meetingList[widget.index ?? 0].MeetingDetails;
        _url.text = _provider.meetingList[widget.index ?? 0].Meeting_url;
        _pass.text = _provider.meetingList[widget.index ?? 0].Meeting_pswd;
        _meetingId.text = _provider.meetingList[widget.index ?? 0].Meeting_id;
        _notes.text = _provider.meetingList[widget.index ?? 0].Notes;
        isLoaded = true;
      }
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarW.appBarW("تعديل موعد", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: BackGWhiteColor,
                  border: Border.all(
                    color: bordercolor,
                  ),
                  //color: baseColor,
                  borderRadius: BorderRadius.all(
                    new Radius.circular(4),
                  ),
                ),
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "بيانات الموعد",
                        style: subtitleTx(secondryColorText),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: baseColorText,
                        ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: baseColorText,
                        ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: baseColorText,
                        ),
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
                              theme: DatePickerTheme(
                                backgroundColor: BackGWhiteColor,
                                itemStyle: TextStyle(
                                  color: baseColorText,
                                ),
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2021, 3, 5), onChanged: (date) {
                            //  _date.text = date.toString().split(" ")[0];
                            print('change $date');
                          }, onConfirm: (date) {
                            _date.text = date.toString().split(" ")[0];

                            fetchMeetinsTime(_provider.getMeetingsTimeList);
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<String>(
                        popupBackgroundColor: BackGWhiteColor,
                        items: TimsAvilable.length == 0 ? [] : TimsAvilable,
                        //maxHeight: 300,
                        selectedItem: _Time.text,
                        mode: Mode.BOTTOM_SHEET,
                        showClearButton: true,
                        showAsSuffixIcons: true,
                        dropdownSearchDecoration:
                            decoration("الاوقات المتاحة", 3),
                        showSearchBox: true,
                        onChanged: (String? v) {
                          if (v == "") {
                            setState(() {
                              error[3].text = errorTx(3);
                            });
                          } else {
                            setState(() {
                              error[3].text = "";
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
                          child: Center(
                            child: Text(
                              'الاوقات المتاحة',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: baseColorText,
                              ),
                            ),
                          ),
                        ),
                        //added in last update
                        popupItemBuilder: (context, rr, isSelected) =>
                            (Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(rr, style: subtitleTx(baseColorText))
                            ],
                          ),
                        )),
                        dropdownBuilder: (context, selectedItem) => Container(
                          decoration: null,
                          child: selectedItem == null
                              ? null
                              : Text(
                                  selectedItem == null
                                      ? ""
                                      : selectedItem ?? "",
                                  style: TextStyle(
                                      fontSize: 16, color: baseColorText)),
                        ),
                        popupShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownSearch<String>(
                        popupBackgroundColor: BackGWhiteColor,
                        items: ["حضوري", "إفتراضي"],
                        //maxHeight: 300,
                        selectedItem: _tpeApp.text,
                        mode: Mode.BOTTOM_SHEET,
                        showClearButton: true,
                        showAsSuffixIcons: true,
                        dropdownSearchDecoration: decoration("نوع الإجتماع", 4),

                        showSearchBox: true,

                        onChanged: (String? v) {
                          v = v ?? "";

                          setState(() {
                            _tpeApp.text = v ?? "";
                          });
                          if (v == "") {
                            setState(() {
                              error[4].text = errorTx(4);
                            });
                          } else {
                            setState(() {
                              error[4].text = "";
                            });
                          }
                          if (v == "إفتراضي") {
                            pp = "v";
                          } else {
                            pp = "p";
                          }
                        },
                        popupItemBuilder: (context, rr, isSelected) =>
                            (Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(rr, style: subtitleTx(baseColorText))
                            ],
                          ),
                        )),

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
                        //added in last update
                        dropdownBuilder: (context, selectedItem) => Container(
                          decoration: null,
                          child: selectedItem == null
                              ? null
                              : Text(
                                  selectedItem == null
                                      ? ""
                                      : selectedItem ?? "",
                                  style: TextStyle(
                                      fontSize: 16, color: baseColorText)),
                        ),
                        popupShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _tpeApp.text == "حضوري"
                          ? Container()
                          : TextField(
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              controller: _url,
                              style: TextStyle(
                                color: baseColorText,
                              ),
                              decoration: decoration("رابط الإجتماع", 5),
                              onChanged: (String val) {
                                if (val == "") {
                                  setState(() {
                                    error[5].text = errorTx(5);
                                  });
                                } else {
                                  setState(() {
                                    error[5].text = "";
                                  });
                                }
                              },
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      _tpeApp.text == "حضوري"
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _meetingId,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: baseColorText,
                                    ),
                                    decoration: decoration("الرقم المعرف", 6),
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
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    controller: _pass,
                                    style: TextStyle(
                                      color: baseColorText,
                                    ),
                                    decoration: decoration("كلمة السر", 7),
                                    onChanged: (String val) {
                                      if (val == "") {
                                        setState(() {
                                          error[7].text = errorTx(7);
                                        });
                                      } else {
                                        setState(() {
                                          error[7].text = "";
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                      _tpeApp.text == "حضوري"
                          ? Container()
                          : const SizedBox(
                              height: 10,
                            ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: _notes,
                        maxLines: 3,
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        decoration: decoration("ملاحظات", 8),
                        onChanged: (String val) {
                          if (val == "") {
                            setState(() {
                              error[8].text = errorTx(8);
                            });
                          } else {
                            setState(() {
                              error[8].text = "";
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: baseColor, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (CheckValdation()) {
                            return;
                          }
                          bool rej = true;
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "",
                            desc: "تأكيد تعديل الموعد",
                            buttons: [
                              DialogButton(
                                child: const Text(
                                  "تعديل",
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
                                status: '... جاري المعالجة',
                                maskType: EasyLoadingMaskType.black,
                              );
                              await _provider.putappoit(
                                  widget.index ?? 0,
                                  int.parse(_provider
                                      .meetingList[widget.index ?? 0].Id),
                                  _date.text,
                                  p,
                                  _Time.text,
                                  _appWith.text,
                                  _mobile.text,
                                  _subject.text,
                                  _notes.text,
                                  pp,
                                  _url.text,
                                  _meetingId.text,
                                  _pass.text);

                              EasyLoading.dismiss();
                              Alerts.successAlert(
                                      context, "", "تم تعديل الموعد")
                                  .show()
                                  .then((value) => Navigator.pop(context));
                            }
                          });
                        },
                        child: const Text('تعديل'),
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

  decoration(String val, int i) {
    return InputDecoration(
      labelStyle: TextStyle(color: secondryColorText),
      errorStyle: TextStyle(color: redColor),

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
      //filled: true,
      //fillColor: Back,
      labelText: val,
      errorText: error[i].text == "" ? null : error[i].text,
      alignLabelWithHint: true,
    );
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
      if (index == 5) {
        errorTx = "الرجاء إدحال رابط الاجتماع";
      }
      if (index == 6) {
        errorTx = "الرجاء إدحال الرقم المعرف";
      }
      if (index == 7) {
        errorTx = "الرجاء إدحال كلمة السر ";
      }
    }

    if (index == 3) {
      errorTx = "الرجاء إدخال الوقت";
    }
    if (index == 4) {
      errorTx = "الرجاء إددخال نوع الاجتماع";
    }

    return errorTx;
  }

  bool CheckValdation() {
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

    if (_Time.text == "") {
      isFalse = true;
      setState(() {
        error[3].text = errorTx(3);
      });
    }
    if (_tpeApp.text == "") {
      error[4].text = errorTx(4);
    }
    if (_tpeApp.text == "إفتراضي") {
      if (_url.text == "") {
        isFalse = true;
        setState(() {
          error[5].text = errorTx(5);
        });
      }
      if (_meetingId.text == "") {
        isFalse = true;
        setState(() {
          error[6].text = errorTx(6);
        });
      }
      if (_pass.text == "") {
        isFalse = true;
        setState(() {
          error[7].text = errorTx(7);
        });
      }
    }

    return isFalse;
  }
}
