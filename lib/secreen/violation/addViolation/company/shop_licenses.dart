import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class shopLicenses extends StatefulWidget {
  shopLicenses(this.nextPage, this.IndividualUserInfo);
  IndividualUserInfoModel IndividualUserInfo;
  Function nextPage;

  @override
  State<shopLicenses> createState() => _shopLicensesState();
}

class _shopLicensesState extends State<shopLicenses>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _shoplicenses = TextEditingController();
  TextEditingController _shopname = TextEditingController();
  TextEditingController _recordnumberorid = TextEditingController();
  TextEditingController _expirdate = TextEditingController();
  TextEditingController _shopespace = TextEditingController();
  TextEditingController _nshat = TextEditingController();
  bool checked = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _shoplicenses,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: formlabel1("رخصة محل"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم رخصة محل';
                }
                return null;
              },
            ),
            Row(
              children: [
                widgetsUni.actionbutton("تحقق", Icons.send, () {
                  if (checked == false) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        checked = true;
                      });
                    }
                  }
                }),
              ],
            ),
            siedBox(),
            if (checked == true)
              Column(
                children: [
                  TextFormField(
                    controller: _shopname,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("إسم المنشأة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: _recordnumberorid,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم السجل أو الهوية"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: _expirdate,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    readOnly: true,
                    // keyboardType: TextInputType.datetime,
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("تاریخ إنتهاء الرخصة"),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'فضلاً أدخل تاریخ إنتهاء الرخصة';
                    //   }
                    //   return null;
                    // },
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
                        _expirdate.text = date.toString().split(" ")[0];
                        print('change $date');
                      }, onConfirm: (date) {
                        _expirdate.text = date.toString().split(" ")[0];
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.ar);
                    },
                  ),
                  siedBox(),
                  TextFormField(
                    controller: _shopespace,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة المحل"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: _nshat,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("النشاط"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.mobile,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: formlabel1("رقم الجوال"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الجوال';
                      }
                      return null;
                    },
                  ),
                  ...TexTfields(false, widget.IndividualUserInfo),
                  Row(
                    children: [
                      widgetsUni.actionbutton("التالي", Icons.arrow_forward,
                          () {
                        if (_formKey.currentState!.validate()) {
                          widget.nextPage();
                        }
                        ;
                      }),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  SizedBox siedBox() {
    return SizedBox(
      height: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
