import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class buildinglicense extends StatefulWidget {
  buildinglicense(this.nextPage, this.vaiolationModel);
  VaiolationModel vaiolationModel;
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
    // widget.building_license_model.settestdata();
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
                  widget.vaiolationModel.building_license_model.buildingLicense,
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
                    controller: widget.vaiolationModel.building_license_model
                        .individualNameOrCompanyName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("إسم المالك"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget.vaiolationModel.building_license_model
                        .identityOrCommericalNumber,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("رقم الهوية / سجل"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.building_license_model.companyEngName,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("اسم المكتب الهندسي"),
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
                  siedBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.building_license_model.areaBuildingLic,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("مساحة"),
                  ),
                  siedBox(),
                  TextFormField(
                    controller: widget
                        .vaiolationModel.building_license_model.licensetype,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    maxLines: 1,
                    enabled: false,
                    decoration: formlabel1("نوع الرخصة"),
                  ),
                  ...TexTfields(false, widget.vaiolationModel),
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
