import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/violation/addViolation/Individuals/individualUserInfo.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class buildinglicense extends StatefulWidget {
  buildinglicense(this.nextPage, this.IndividualUserInfo);
  IndividualUserInfoModel IndividualUserInfo;
  Function nextPage;

  @override
  State<buildinglicense> createState() => _buildinglicenseState();
}

class _buildinglicenseState extends State<buildinglicense>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  //مخالفة رخصة البناء
  bool checked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.IndividualUserInfo.settestdata();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: widget.IndividualUserInfo.licensenumber,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: formlabel1("رقم الرخصة"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رقم رخصة';
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
                    decoration: formlabel1("إسم المالك"),
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
                    decoration: formlabel1("رقم الهوية / سجل"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.companyEngName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("اسم المكتب الهندسي"),
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
                    controller: widget.IndividualUserInfo.space,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.IndividualUserInfo.licensetype,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("نوع الرخصة"),
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
