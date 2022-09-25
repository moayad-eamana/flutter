import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class ViolationSkn extends StatefulWidget {
  ViolationSkn(this.nextPage, this.vaiolationModel);
  Function nextPage;
  VaiolationModel vaiolationModel;

  @override
  State<ViolationSkn> createState() => _ViolationSknState();
}

class _ViolationSknState extends State<ViolationSkn>
    with AutomaticKeepAliveClientMixin {
  //مخالفة سكن جماعي

  bool checked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller:
                  widget.vaiolationModel.violation_skn_mohdel.dormitoryLicense,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: formlabel1("رخصة سكن جماعي"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رخصة سكن جماعي';
                }
                return null;
              },
            ),
            sizeBox(),
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
            sizeBox(),
            if (checked == true)
              Column(
                children: [
                  TextFormField(
                    controller: widget.vaiolationModel.violation_skn_mohdel
                        .individualNameOrCompanyName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("اسم المنشأة"),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'رقم السجل أو الهوية';
                    //   }
                    //   return null;
                    // },
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.violation_skn_mohdel
                        .identityOrCommericalNumber,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم السجل أو الهوية"),
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.violation_skn_mohdel
                        .dormitoryLicenseExpireDate,
                    keyboardType: TextInputType.datetime,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("تاريخ إنتهاء الرخصة"),
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.violation_skn_mohdel.dormitoryArea,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة"),
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.violation_skn_mohdel.dormitoryType,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("نوع العقار"),
                  ),
                  sizeBox(),
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      widgetsUni.actionbutton("التالي", Icons.arrow_forward,
                          () {
                        if (_formKey.currentState!.validate()) {
                          widget.nextPage();
                        }
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

  sizeBox() {
    return SizedBox(
      height: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
