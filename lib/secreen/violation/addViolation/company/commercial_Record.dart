import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class commercialRecord extends StatefulWidget {
  commercialRecord(this.nextPage, this.IndividualUserInfo);
  IndividualUserInfoModel IndividualUserInfo;
  Function nextPage;

  @override
  State<commercialRecord> createState() => _commercialRecordState();
}

class _commercialRecordState extends State<commercialRecord>
    with AutomaticKeepAliveClientMixin {
  //مخالفة لسجل تجاري
  //سجل تجاري

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
              controller: widget.IndividualUserInfo.identityOrCommericalNumber,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: formlabel1("سجل تجاري"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم سجل تجاري';
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
                        widget.IndividualUserInfo.IndividualNameOrCompanyName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("إسم المؤسسة /الشركة"),
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
                  ...TexTfields(true, widget.IndividualUserInfo),
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
