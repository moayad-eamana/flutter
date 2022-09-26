import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

import 'ListOfTextFieleds.dart';

class violationAdds extends StatefulWidget {
  Function nextPage;
  VaiolationModel vaiolationModel;
  violationAdds(this.nextPage, this.vaiolationModel);

  @override
  State<violationAdds> createState() => _violationAddsState();
}

class _violationAddsState extends State<violationAdds>
    with AutomaticKeepAliveClientMixin {
  get baseColorText => null;

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
              controller:
                  widget.vaiolationModel.violationAdds_model.baladeaname,
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
            sizeBox(),
            TextFormField(
              controller:
                  widget.vaiolationModel.violationAdds_model.advboardlicense,
              style: TextStyle(
                color: baseColorText,
              ),
              keyboardType: TextInputType.text,
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
                    controller: widget.vaiolationModel.violationAdds_model
                        .identityOrCommericalNumber,
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
                  sizeBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.violationAdds_model
                        .individualNameOrCompanyName,
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
                    controller: widget
                        .vaiolationModel.violationAdds_model.advboardDistance,
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
                    controller: widget
                        .vaiolationModel.violationAdds_model.LicenseExpirDate,
                    keyboardType: TextInputType.datetime,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("تاريخ إنتهاء الرخصة"),
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
