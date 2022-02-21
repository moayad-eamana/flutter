import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class VacationRequest extends StatefulWidget {
  const VacationRequest({Key? key}) : super(key: key);

  @override
  State<VacationRequest> createState() => _VacationRequestState();
}

class _VacationRequestState extends State<VacationRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _date = TextEditingController();
  TextEditingController _daysNumber = TextEditingController();
  TextEditingController _note = TextEditingController();
  // TextEditingController _date = TextEditingController();

  DropdownSearchW drop1 = new DropdownSearchW();

  List<Map<dynamic, dynamic>> items = [
    {"tt": "محمد", "id": "11"},
    {"tt": "مؤيد", "id": "11"},
    {"tt": "نور الدين", "id": "11"},
    {"tt": "شريف", "id": "26"}
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("طلب إجازة", context),
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
                            "فضلاً أدخل بيانات طلب إجازة",
                            style: titleTx(baseColor),
                          ),
                        ),
                        StaggeredGrid.count(
                            crossAxisCount: responsiveGrid(1, 2),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: [
                              TextFormField(
                                controller: _daysNumber,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                decoration: formlabel1("عدد الايام"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _date,
                                readOnly: true,
                                // keyboardType: TextInputType.datetime,
                                maxLines: 1,
                                decoration: formlabel1("تاريخ الإجازة"),
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
                                    _date.text = date.toString();
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    _date.text = date.toString().split(" ")[0];
                                    print('confirm $date');
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar);
                                },
                              ),
                              drop1.drop(items, "الموظف البديل", context),
                              DropdownSearch<String>(
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "الموظف البديل",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(color: bordercolor),
                                  ),
                                ),
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: ["نور الدين", "مؤيد", "محمد", 'شريف'],
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                onChanged: print,
                              ),
                              DropdownSearch<String>(
                                validator: (v) =>
                                    v == null ? "required field" : null,
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "نوع الإجازة",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(color: bordercolor),
                                  ),
                                ),
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: [
                                  "إجازة اضطرارية",
                                  "إجازة اعتيادية",
                                  "تمديد إجازة اعتيادية",
                                ],
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                onChanged: print,
                              ),
                            ]),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _note,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: formlabel1("ملاحظات"),
                        ),
                        SizedBox(
                          height: 10,
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
