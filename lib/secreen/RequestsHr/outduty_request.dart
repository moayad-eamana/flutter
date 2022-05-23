import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class OutdutyRequest extends StatefulWidget {
  const OutdutyRequest({Key? key}) : super(key: key);

  @override
  State<OutdutyRequest> createState() => _OutdutyRequestState();
}

class _OutdutyRequestState extends State<OutdutyRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateFrom = TextEditingController();
  TextEditingController _dateTo = TextEditingController();
  TextEditingController _HoursNumber = TextEditingController();
  TextEditingController _note = TextEditingController();
  // TextEditingController _date = TextEditingController();
  // last update

  EmployeeProfile empinfo = new EmployeeProfile();

  double _HoursNumberC = 0.5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getuserinfo());
  }

  getuserinfo() async {
    EasyLoading.show(
      status: 'جاري المعالجة...',
      maskType: EasyLoadingMaskType.black,
    );
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
    EasyLoading.dismiss();
  }

  Future<void> InsertOutDutyRequest() async {
//rtyrtyer
    Map data = {
      "EmployeeNumber": empinfo.EmployeeNumber,
      "OutDutyHours": _HoursNumberC,
      "StartDate": _dateFrom.text,
      "EndDate": _dateTo.text,
      "DepartmentID": empinfo.DepartmentID,
      "Notes": _note.text,
      "UserNumber": empinfo.EmployeeNumber,
    };
    print(data);
    //encode Map to JSON

    var body = json.encode(data);

    Alerts.confirmAlrt(context, "تأكيد", "هل انت متأكد؟", "نعم")
        .show()
        .then((value) async {
      if (value == true) {
        EasyLoading.show(
          status: 'جاري إرسال الطلب...',
          maskType: EasyLoadingMaskType.black,
        );

        var respose = await postAction("HR/InsertOutDutyRequest/", body);
        print(jsonDecode(respose.body));
        if (jsonDecode(respose.body)["StatusCode"] != 400) {
          Alerts.errorAlert(
                  context, "خطأ", jsonDecode(respose.body)["ErrorMessage"])
              .show();
        } else {
          Alerts.successAlert(context, "", "تم ارسال الطلب").show();
        }

        EasyLoading.dismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarW.appBarW("طلب خارج الدوام", context, null),
          body: Container(
            height: 100.h,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    imageBG,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "فضلاً أدخل بيانات طلب خارج الدوام",
                                    style: titleTx(baseColor),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                StaggeredGrid.count(
                                    crossAxisCount: responsiveGrid(1, 2),
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    children: [
                                      Container(
                                        decoration: containerdecoration(
                                            BackGWhiteColor),
                                        child: SpinBox(
                                          max: 7,
                                          min: 0.5,
                                          value: 0.5,
                                          decimals: 1,
                                          readOnly: true,
                                          step: 0.5,
                                          decoration: InputDecoration(
                                            labelText: 'ادخل عدد الساعات',
                                          ),
                                          textStyle:
                                              subtitleTx(secondryColorText),
                                          incrementIcon: Icon(
                                            Icons.add_box_outlined,
                                            size: 30,
                                            color: baseColor,
                                          ),
                                          decrementIcon: Icon(
                                            Icons
                                                .indeterminate_check_box_outlined,
                                            size: 30,
                                            color: baseColor,
                                          ),
                                          onChanged: (value) {
                                            _HoursNumberC = value;
                                            print(_HoursNumberC);
                                          },
                                        ),
                                      ),
                                      // TextFormField(2
                                      //   //style: subtitleTx(Colors.white),
                                      //   controller: _HoursNumber,
                                      //   inputFormatters: <TextInputFormatter>[
                                      //     FilteringTextInputFormatter.digitsOnly
                                      //   ],
                                      //   keyboardType: TextInputType.number,
                                      //   maxLines: 1,
                                      //   decoration: formlabel1("عدد الساعات"),
                                      //   validator: (value) {
                                      //     if (value == null || value.isEmpty) {
                                      //       return 'يرجى إدخال عدد الساعات';
                                      //     }
                                      //     return null;
                                      //   },
                                      // ),
                                      TextFormField(
                                        controller: _dateFrom,
                                        style: TextStyle(color: baseColorText),
                                        readOnly: true,
                                        // keyboardType: TextInputType.datetime,
                                        maxLines: 1,
                                        decoration: formlabel1(
                                            "تاريخ بداية خارج الدوام"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إختيار تاريخ المحدد';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              theme: DatePickerTheme(
                                                backgroundColor:
                                                    BackGWhiteColor,
                                                itemStyle: TextStyle(
                                                  color: baseColorText,
                                                ),
                                              ),
                                              showTitleActions: true,
                                              minTime: DateTime(2021, 3, 5),
                                              onChanged: (date) {
                                            _dateFrom.text =
                                                date.toString().split(" ")[0];
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            _dateFrom.text =
                                                date.toString().split(" ")[0];
                                            print('confirm $date');
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.ar);
                                        },
                                      ),
                                      TextFormField(
                                        controller: _dateTo,
                                        style: TextStyle(color: baseColorText),
                                        readOnly: true,
                                        // keyboardType: TextInputType.datetime,
                                        maxLines: 1,
                                        decoration: formlabel1(
                                            "تاريخ نهاية خارج الدوام"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'يرجى إختيار تاريخ المحدد';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              theme: DatePickerTheme(
                                                backgroundColor:
                                                    BackGWhiteColor,
                                                itemStyle: TextStyle(
                                                  color: baseColorText,
                                                ),
                                              ),
                                              showTitleActions: true,
                                              minTime: DateTime(2021, 3, 5),
                                              onChanged: (date) {
                                            _dateTo.text =
                                                date.toString().split(" ")[0];
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            _dateTo.text =
                                                date.toString().split(" ")[0];
                                            print('confirm $date');
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.ar);
                                        },
                                      ),
                                    ]),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLength: 300,
                                  style: TextStyle(color: baseColorText),
                                  controller: _note,
                                  keyboardType: TextInputType.text,
                                  maxLines: 3,
                                  decoration: formlabel1("ملاحظات"),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يرجى كتابة ملاحظة';
                                    } else if (value.length < 15) {
                                      return 'الرجاء إدخال أكثر من ١٥ حرف';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // widgetsUni.actionbutton(
                                      //   "الطلبات السابقة",
                                      //   Icons.local_attraction_sharp,
                                      //   () {
                                      //     print("ee");
                                      //   },
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      widgetsUni.actionbutton(
                                        'الطلبات السابقة',
                                        Icons.history,
                                        () {
                                          Navigator.pushNamed(
                                              context, "/OutDuties_hostiry");
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      widgetsUni.actionbutton(
                                        'تنفيذ',
                                        Icons.send,
                                        () {
                                          // Validate returns true if the form is valid, or false otherwise.
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // If the form is valid, display a snackbar. In the real world,
                                            // you'd often call a server or save the information in a database.
                                            InsertOutDutyRequest();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
