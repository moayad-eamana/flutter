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
  TextEditingController _commercialRecord = TextEditingController();
  TextEditingController _companyname = TextEditingController();

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
              controller: _commercialRecord,
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
                widgetsUni.actionbutton("تحقق", Icons.send, () {}),
              ],
            ),
            siedBox(),
            TextFormField(
              controller: _companyname,
              style: TextStyle(
                color: baseColorText,
              ),
              maxLines: 1,
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
                widgetsUni.actionbutton("التالي", Icons.arrow_forward, () {
                  widget.nextPage();
                }),
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
