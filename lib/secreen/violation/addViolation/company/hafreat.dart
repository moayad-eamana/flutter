import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import 'ListOfTextFieleds.dart';

class hafreat extends StatefulWidget {
  Function nextPage;
  IndividualUserInfoModel IndividualUserInfo;
  hafreat(this.nextPage, this.IndividualUserInfo);

  @override
  State<hafreat> createState() => _hafreatState();
}

class _hafreatState extends State<hafreat> with AutomaticKeepAliveClientMixin {
  //مخالفات الحفريات

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
              controller: widget.IndividualUserInfo.diggingLicense,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: formlabel1("رقم الطلب"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم الطلب';
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
                    controller:
                        widget.IndividualUserInfo.individualNameOrCompanyName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("إسم المنشأة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller:
                        widget.IndividualUserInfo.identityOrCommericalNumber,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم السجل"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.beneficiary,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("الجهة المستفيدة"),
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
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.diggingArea,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة الحفرة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.locOrPurposeDesc,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("وصف الموقع"),
                  ),
                  ...TexTfields(false, widget.IndividualUserInfo),
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

  SizedBox siedBox() {
    return SizedBox(
      height: 10,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
