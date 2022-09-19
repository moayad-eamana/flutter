import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import 'ListOfTextFieleds.dart';

class violationAdds extends StatefulWidget {
  Function nextPage;
  IndividualUserInfoModel IndividualUserInfo;
  violationAdds(this.nextPage, this.IndividualUserInfo);

  @override
  State<violationAdds> createState() => _violationAddsState();
}

class _violationAddsState extends State<violationAdds>
    with AutomaticKeepAliveClientMixin {
  get baseColorText => null;
//مخالفة رخص اللوحات الاعلانية
//اسم البلدية
  TextEditingController _baladeaname = TextEditingController();
  //رخصة لوحة إعلانية
  TextEditingController _addslicenses = TextEditingController();
  //رقم السجل أو الهوية
  TextEditingController _recordnumberorid = TextEditingController();
  //عنوان اللوحة
  TextEditingController _addslocation = TextEditingController();
  //مساحة اللوحة
  TextEditingController _addsspace = TextEditingController();
  //تاريخ إنتهاء الرخصة
  TextEditingController _expirdate = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool checked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.IndividualUserInfo.Neighborhoodname.text = "ddddd";
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
              controller: _baladeaname,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: formlabel1("إسم البلدية"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'إسم البلدية';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _addslicenses,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: formlabel1("رخصة لوحة إعلانية"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال رخصة لوحة إعلانية';
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
                    controller: _recordnumberorid,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم السجل أو الهوية"),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'رقم السجل أو الهوية';
                    //   }
                    //   return null;
                    // },
                  ),
                  sizeBox(),
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
                  sizeBox(),
                  TextFormField(
                    controller: _addslocation,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("عنوان اللوحة"),
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: _addsspace,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة اللوحة"),
                  ),
                  sizeBox(),
                  TextFormField(
                    controller: _expirdate,
                    keyboardType: TextInputType.datetime,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("تاريخ إنتهاء الرخصة"),
                  ),
                  ...TexTfields(false, widget.IndividualUserInfo),
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
