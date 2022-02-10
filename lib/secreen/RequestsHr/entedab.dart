import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class Entedab extends StatefulWidget {
  const Entedab({Key? key}) : super(key: key);

  @override
  _EntedabState createState() => _EntedabState();
}

class _EntedabState extends State<Entedab> {
  TextEditingController _date = TextEditingController();
  TextEditingController _dayNumber = TextEditingController();
  TextEditingController _Note = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DropdownSearchW drop1 = new DropdownSearchW();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("طلب إنتداب", context),
        body: Container(
          //color: Colors.amber,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: StaggeredGrid.count(
                    crossAxisCount: responsiveGrid(1, 1),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: _date,
                        decoration: formlabel1("تاريخ الانتداب"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إختيار التاريخ";
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2021, 3, 5), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              _date.text = date.toString().split(" ")[0];
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.ar);
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        controller: _dayNumber,
                        decoration: formlabel1("عدد الايام"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدخال عدد الايام";
                          } else {
                            return null;
                          }
                        },
                      ),
                      DropdownSearch<String>(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "نوع الانتداب",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: bordercolor),
                          ),
                        ),
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: ["داخلي", "خارجي"],
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "الرجاء إدختيار نوع الانتداب";
                          } else {
                            return null;
                          }
                        },
                      ),
                      drop1.drop(
                          ["اليابان", "استراليا", "أمريكا"], "جهة الانتداب"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        controller: _Note,
                        decoration: formlabel1("ملاحظات"),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('إرسال'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
