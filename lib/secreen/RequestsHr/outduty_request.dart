import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OutdutyRequest extends StatefulWidget {
  const OutdutyRequest({Key? key}) : super(key: key);

  @override
  State<OutdutyRequest> createState() => _OutdutyRequestState();
}

class _OutdutyRequestState extends State<OutdutyRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateFrom = TextEditingController();
  TextEditingController _dateTo = TextEditingController();
  TextEditingController _daysNumber = TextEditingController();
  TextEditingController _note = TextEditingController();
  // TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("طلب خارج الدوام", context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.amber,
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "فضلاً أدخل بيانات طلب خارج الدوام",
                            style: titleTx(baseColor),
                          ),
                        ),
                        StaggeredGrid.count(
                            crossAxisCount: responsiveGrid(1, 2),
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 10,
                            children: [
                              TextFormField(
                                controller: _daysNumber,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: formlabel1("عدد الساعات"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _dateFrom,
                                readOnly: true,
                                // keyboardType: TextInputType.datetime,
                                maxLines: 1,
                                decoration:
                                    formlabel1("تاريخ بداية خارج الدوام"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    _dateFrom.text = date.toString();
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    _dateFrom.text = date.toString();
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                              TextFormField(
                                controller: _dateTo,
                                readOnly: true,
                                // keyboardType: TextInputType.datetime,
                                maxLines: 1,
                                decoration:
                                    formlabel1("تاريخ نهاية خارج الدوام"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    _dateTo.text = date.toString();
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    _dateTo.text = date.toString();
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _note,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: formlabel1("ملاحظات"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              widgetsUni.actionbutton(
                                "الطلبات السابقة",
                                Icons.local_attraction_sharp,
                                () {
                                  print("ee");
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              widgetsUni.actionbutton(
                                'تنفيذ',
                                Icons.send,
                                () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
