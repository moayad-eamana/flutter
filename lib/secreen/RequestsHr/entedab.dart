import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/DropdownSearchW.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                //color: Colors.amber,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFDDDDDD)),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "فضلا أدخل بيانات طلب الانتداب",
                        style: subtitleTx(secondryColorText),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: StaggeredGrid.count(
                            crossAxisCount: responsiveGrid(1, 2),
                            mainAxisSpacing: 10,
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
                                      minTime: DateTime(2021, 3, 5),
                                      onChanged: (date) {
                                    print('change $date');
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: responsiveMT(10, 20),
                                      horizontal: responsiveMT(10, 20)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(color: bordercolor),
                                  ),
                                ),
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: ["داخلي", "خارجي"],
                                showClearButton: true,
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                onChanged: print,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "الرجاء إدختيار نوع الانتداب";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              drop1.drop(["اليابان", "استراليا", "أمريكا"],
                                  "جهة الانتداب"),
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
                                  Alerts.confirmAlrt(context, "",
                                          "هل انت متأكد من طلب الانتداب", "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      //call api
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  });
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
            ),
          ],
        ),
      ),
    );
  }
}
