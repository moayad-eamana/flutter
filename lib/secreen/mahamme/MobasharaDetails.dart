import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/MobasharaProvider.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class MobasharaDetails extends StatefulWidget {
  int TypeID;
  int index;
  MobasharaDetails(this.index, this.TypeID);
  @override
  State<MobasharaDetails> createState() => _MobasharaDetailsState();
}

class _MobasharaDetailsState extends State<MobasharaDetails> {
  TextEditingController _date = TextEditingController();
  TextEditingController _Note = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _mobasharaList =
        Provider.of<MobasharaProvider>(context, listen: false).MobasharaList;
    var _provider = Provider.of<MobasharaProvider>(context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("تفاصيل الطلب", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        elevation: 1,
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 100.w,
                          height: 100,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                _mobasharaList[widget.index].EmployeeName,
                                style: subtitleTx(baseColorText),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text.rich(TextSpan(
                                      text: "الرقم الوظيفي: ",
                                      style: descTx2(secondryColorText),
                                      children: [
                                        TextSpan(
                                            style: descTx1(baseColorText),
                                            text: _mobasharaList[widget.index]
                                                .EmployeeNumber
                                                .toString())
                                      ])),
                                  Text.rich(TextSpan(
                                      text: "تاريخ الحركة: ",
                                      style: descTx2(secondryColorText),
                                      children: [
                                        TextSpan(
                                            style: descTx1(baseColorText),
                                            text: _mobasharaList[widget.index]
                                                .StartDate
                                                .split("T")[0]
                                                .toString())
                                      ])),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 100.w,
                          height: 90,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "نوع الحركة",
                                style: subtitleTx(baseColorText),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(_mobasharaList[widget.index].OrderType,
                                      style: descTx2(secondryColorText))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 100.w,

                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "الإدارة القديمة",
                                style: subtitleTx(baseColorText),
                              ),
                              Text(
                                  _mobasharaList[widget.index]
                                      .OldDepartmentName,
                                  style: descTx2(secondryColorText),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: 100.w,

                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "الإدارة الجديدة",
                                style: subtitleTx(baseColorText),
                              ),
                              Text(
                                  _mobasharaList[widget.index]
                                      .NewDepartmentName,
                                  style: descTx2(secondryColorText),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ),
                      _mobasharaList[widget.index].OrderTypeID == 4
                          ? Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 1,
                                    child: Container(
                                      // margin: EdgeInsets.symmetric(horizontal: 20),

                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "المرتبة القديمة",
                                            style: subtitleTx(baseColorText),
                                          ),
                                          Text(
                                              _mobasharaList[widget.index]
                                                  .OldClass
                                                  .toString(),
                                              style: descTx2(secondryColorText),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 1,
                                    child: Container(
                                      // margin: EdgeInsets.symmetric(horizontal: 20),

                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "المرتبة الجديدة",
                                            style: subtitleTx(baseColorText),
                                          ),
                                          Text(
                                              _mobasharaList[widget.index]
                                                  .NewClass
                                                  .toString(),
                                              style: descTx2(secondryColorText),
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.TypeID != 132)
                        if (_mobasharaList[widget.index].TransactionTypeID ==
                                39 &&
                            _mobasharaList[widget.index].OrderTypeID == 3)
                          Card(
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                maxLines: 1,
                                controller: _date,
                                decoration:
                                    formlabel1("فضلا أدخل تاريخ المباشرة"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "فضلا أدخل تاريخ المباشرة";
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      theme: DatePickerTheme(
                                        backgroundColor: BackGWhiteColor,
                                        itemStyle: TextStyle(
                                          color: baseColorText,
                                        ),
                                      ),
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    //  print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      _date.text =
                                          date.toString().split(" ")[0];
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                            ),
                          ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        minLines: 3,
                        controller: _Note,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: widgetsUni.actionbutton(
                              " رفض الطلب",
                              Icons.check,
                              () async {
                                if (_formKey.currentState!.validate()) {
                                  Alerts.confirmAlrt(context, "",
                                          "هل انت متأكد من الرفض", "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      String emNo = await EmployeeProfile
                                          .getEmployeeNumber();
                                      var response = await _provider
                                          .ApproveStartWorkRequest({
                                        "EmployeeNumber":
                                            _mobasharaList[widget.index]
                                                .EmployeeNumber,
                                        "StartDate": widget.TypeID == 132
                                            ? null
                                            : _date.text,
                                        "TransactionDate":
                                            _mobasharaList[widget.index]
                                                .StartDate,
                                        "ApprovalBy": int.parse(emNo),
                                        "TransactionTypeID":
                                            _mobasharaList[widget.index]
                                                .TransactionTypeID,
                                        "Notes": _Note,
                                        "Flag": "R"
                                      }, widget.index, widget.TypeID);
                                      EasyLoading.dismiss();

                                      if (response == true) {
                                        Alerts.successAlert(
                                                context, "", "تمت الموافقة ")
                                            .show()
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        EasyLoading.dismiss();
                                        Alerts.errorAlert(
                                                context, "خطأ", response)
                                            .show();
                                      }
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: widgetsUni.actionbutton(
                              "موافقة على الطلب",
                              Icons.check,
                              () async {
                                if (_formKey.currentState!.validate()) {
                                  Alerts.confirmAlrt(context, "",
                                          "هل انت متأكد من الموافقة", "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      String emNo = await EmployeeProfile
                                          .getEmployeeNumber();
                                      var response = await _provider
                                          .ApproveStartWorkRequest({
                                        "EmployeeNumber":
                                            _mobasharaList[widget.index]
                                                .EmployeeNumber,
                                        "StartDate": widget.TypeID == 132
                                            ? null
                                            : _date.text,
                                        "TransactionDate":
                                            _mobasharaList[widget.index]
                                                .StartDate,
                                        "ApprovalBy": int.parse(emNo),
                                        "TransactionTypeID":
                                            _mobasharaList[widget.index]
                                                .TransactionTypeID,
                                        "Notes": _Note,
                                        "Flag": "A"
                                      }, widget.index, widget.TypeID);
                                      EasyLoading.dismiss();

                                      if (response == true) {
                                        Alerts.successAlert(
                                                context, "", "تمت الموافقة ")
                                            .show()
                                            .then((value) {
                                          Navigator.pop(context);
                                        });
                                      } else {
                                        EasyLoading.dismiss();
                                        Alerts.errorAlert(
                                                context, "خطأ", response)
                                            .show();
                                      }
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
