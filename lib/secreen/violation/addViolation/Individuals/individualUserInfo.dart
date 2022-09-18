import 'package:eamanaapp/model/violation/violation.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class individualUserInfo extends StatefulWidget {
  IndividualUserInfoModel IndividualUserInfo;
  Function function;
  individualUserInfo(this.IndividualUserInfo, this.function);
  @override
  State<individualUserInfo> createState() => _individualUserInfoState();
}

class _individualUserInfoState extends State<individualUserInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
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
          child: Column(
            children: [
              TextFormField(
                controller: widget.IndividualUserInfo.NID,
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
                    setState(() {
                      widget.IndividualUserInfo.Name.text = "مؤيد العوفي";
                      widget.IndividualUserInfo.mobile.text = "0567442031";
                      widget.IndividualUserInfo.baldea.text = "بلدية الخبر";
                      widget.IndividualUserInfo.Neighborhoodname.text =
                          "حي الخبر الشمالية";
                      widget.IndividualUserInfo.Streetname.text =
                          "بلدية الخبر الشمالية";
                    });
                  }),
                ],
              ),
              ...fields(),
              sizebox(),
              Row(
                children: [
                  widgetsUni.actionbutton("التالي", Icons.arrow_forward, () {
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
        controller: widget.IndividualUserInfo.Name,
        style: TextStyle(
          color: baseColorText,
        ),
        enabled: false,
        maxLines: 1,
        decoration: formlabel1("إسم الفرد"),
      ),
      sizebox(),
      TextFormField(
        controller: widget.IndividualUserInfo.mobile,
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
        controller: widget.IndividualUserInfo.baldea,
        style: TextStyle(
          color: baseColorText,
        ),
        enabled: false,
        maxLines: 1,
        decoration: formlabel1("البلدية التابعة"),
      ),
      sizebox(),
      TextFormField(
        controller: widget.IndividualUserInfo.Neighborhoodname,
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
        controller: widget.IndividualUserInfo.Streetname,
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
        controller: widget.IndividualUserInfo.ShortDescription,
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
        controller: widget.IndividualUserInfo.EmployeeDescription,
        style: TextStyle(
          color: baseColorText,
        ),
        maxLines: 3,
        decoration: formlabel1("ملاحظات الموظف"),
      ),
    ];
  }
}
