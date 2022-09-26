import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class individualUserInfo extends StatefulWidget {
  VaiolationModel vaiolationModel;
  Function function;
  individualUserInfo(this.vaiolationModel, this.function);
  @override
  State<individualUserInfo> createState() => _individualUserInfoState();
}

class _individualUserInfoState extends State<individualUserInfo> {
  final _formKey = GlobalKey<FormState>();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: BackGWhiteColor,
            border: Border.all(
              color: bordercolor,
            ),
            //color: baseColor,
            borderRadius: BorderRadius.all(
              new Radius.circular(4),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  // Text(
                  //   "تحقق",
                  //   style: titleTx(baseColor),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: widget.vaiolationModel.individualUserInfoModel
                        .identityOrCommericalNumber,
                    style: TextStyle(
                      color: baseColorText,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    decoration: formlabel1("رقم الهوية"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الهوية';
                      }
                      return null;
                    },
                  ),
                  sizebox(),
                  Row(
                    children: [
                      widgetsUni.actionbutton("تحقق", Icons.send, () {
                        if (checked == true) {
                          setState(() {
                            widget
                                .vaiolationModel
                                .individualUserInfoModel
                                .individualNameOrCompanyName
                                .text = "مؤيد العوفي";
                            widget.vaiolationModel.comment.mobile.text =
                                "0567442031";
                            widget.vaiolationModel.comment.baldea.text =
                                "بلدية الخبر";
                            widget.vaiolationModel.comment.neighborhoodname
                                .text = "حي الخبر الشمالية";
                            widget.vaiolationModel.comment.streetname.text =
                                "بلدية الخبر الشمالية";
                          });
                        }
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
                  if (checked == true) ...fields(),
                  if (checked == true) sizebox(),
                  if (checked == true)
                    Row(
                      children: [
                        widgetsUni.actionbutton("التالي", Icons.arrow_forward,
                            () {
                          if (_formKey.currentState!.validate()) {
                            widget.function();
                          }
                        }),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sizebox() {
    return SizedBox(
      height: 10,
    );
  }

  List<Widget> fields() {
    return [
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.individualUserInfoModel
            .individualNameOrCompanyName,
        style: TextStyle(
          color: baseColorText,
        ),
        enabled: false,
        maxLines: 1,
        decoration: formlabel1("إسم الفرد"),
      ),
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.mobile,
        style: TextStyle(
          color: baseColorText,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
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
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.baldea,
        style: TextStyle(
          color: baseColorText,
        ),
        enabled: false,
        maxLines: 1,
        decoration: formlabel1("البلدية التابعة"),
      ),
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.neighborhoodname,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 1,
        decoration: formlabel1("إسم الحي"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال إسم الحي';
          }
          return null;
        },
      ),
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.streetname,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 1,
        decoration: formlabel1("إسم الشارع"),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال إسم الشارع';
          }
          return null;
        },
      ),
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.shortDescription,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 1,
        decoration: formlabel1("الوصف المختصر"),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'الرجاء إدخال وصف المختصر';
        //   }
        //   return null;
        // },
      ),
      sizebox(),
      TextFormField(
        controller: widget.vaiolationModel.comment.employeeDescription,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 3,
        decoration: formlabel1("ملاحظات الموظف"),
      ),
    ];
  }
}
