import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class shopLicenses extends StatefulWidget {
  shopLicenses(this.nextPage, this.vaiolationModel);

  VaiolationModel vaiolationModel;
  Function nextPage;

  @override
  State<shopLicenses> createState() => _shopLicensesState();
}

class _shopLicensesState extends State<shopLicenses>
    with AutomaticKeepAliveClientMixin {
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
              controller:
                  widget.vaiolationModel.shop_licenses_model.shoplicenses,
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
            siedBox(),
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
                    controller: widget.vaiolationModel.shop_licenses_model
                        .individualNameOrCompanyName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("إسم المنشأة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.shop_licenses_model
                        .identityOrCommericalNumber,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم السجل أو الهوية"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.shop_licenses_model.licenseExpirDate,
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
                          // theme: DatePickerThemeData(
                          //   backgroundColor: BackGWhiteColor,
                          //   // itemStyle: TextStyle(
                          //   //   color: baseColorText,
                          //   // ),
                          // ),
                          showTitleActions: true,
                          minTime: DateTime(2021, 3, 5), onChanged: (date) {
                        widget
                            .vaiolationModel
                            .shop_licenses_model
                            .licenseExpirDate
                            .text = date.toString().split(" ")[0];
                        print('change $date');
                      }, onConfirm: (date) {
                        widget
                            .vaiolationModel
                            .shop_licenses_model
                            .licenseExpirDate
                            .text = date.toString().split(" ")[0];
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.ar);
                    },
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.shop_licenses_model.storeDistance,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة المحل"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller:
                        widget.vaiolationModel.shop_licenses_model.activity,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("النشاط"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.comment.mobile,
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
                  ...TexTfields(false, widget.vaiolationModel),
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
