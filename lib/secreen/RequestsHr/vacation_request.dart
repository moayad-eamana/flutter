import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class VacationRequest extends StatefulWidget {
  const VacationRequest({Key? key}) : super(key: key);

  @override
  State<VacationRequest> createState() => _VacationRequestState();
}

class _VacationRequestState extends State<VacationRequest> {
  final _formKey = GlobalKey<FormState>();

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
                height: 900,
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
                        Text(
                          "الرقم الوظيفي",
                          style: descTx1(secondryColorText),
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: formlabel,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Text(
                          "اسم الموظف",
                          style: descTx1(secondryColorText),
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: formlabel,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Text(
                          "عدد الايام",
                          style: descTx1(secondryColorText),
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: formlabel,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Text(
                          "تاريخ الإجازة",
                          style: descTx1(secondryColorText),
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.datetime,
                          maxLines: 1,
                          decoration: formlabel,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        Text(
                          "الموظف البديل",
                          style: descTx1(secondryColorText),
                        ),
                        DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "اختر",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: bordercolor),
                            ),
                          ),
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: ["نور الدين", "مؤيد", "محمد", 'شريف'],
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                        ),
                        Text(
                          "نوع الإجازة",
                          style: descTx1(secondryColorText),
                        ),
                        DropdownSearch<String>(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "اختر",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: bordercolor),
                            ),
                          ),
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: ["مرضية", "اعتيادية", "", ""],
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: print,
                        ),
                        Text(
                          "ملاحظات",
                          style: descTx1(secondryColorText),
                        ),
                        TextFormField(
                          //controller: _search,
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          decoration: formlabel,
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
