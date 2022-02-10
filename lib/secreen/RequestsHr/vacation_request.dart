import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class VacationRequest extends StatefulWidget {
  const VacationRequest({Key? key}) : super(key: key);

  @override
  State<VacationRequest> createState() => _VacationRequestState();
}

class _VacationRequestState extends State<VacationRequest> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _date = TextEditingController();

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
                height: 650,
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
                        TextFormField(
                          //controller: _search,
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
                        DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,
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
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                        ),
                        DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,
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
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: formlabel1("ملاحظات"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            onPressed: () {
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
                            child: const Text('Submit'),
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
