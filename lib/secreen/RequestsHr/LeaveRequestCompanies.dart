import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LeaveRequestCompanies extends StatefulWidget {
  const LeaveRequestCompanies({Key? key}) : super(key: key);

  @override
  State<LeaveRequestCompanies> createState() => _LeaveRequestCompaniesState();
}

class _LeaveRequestCompaniesState extends State<LeaveRequestCompanies> {
  TextEditingController _date = TextEditingController();
  TextEditingController _note = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var resBody;
  Future<void> getData() async {
    String empNo = await EmployeeProfile.getEmployeeNumber();

    var respose = await getAction(
        "HR/GetCompanyEmployeeReplacementList/" + empNo); // to test response
    print(respose);

    //resBody = jsonDecode(respose.body)["body"];
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          // backgroundColor: Colors.transparent,
          appBar: AppBarW.appBarW("تقدیم طلب استئذان", context, null),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              SingleChildScrollView(
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Builder(builder: (context) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "نحتاج بس البیانات التالیة لاستكمال طلب الاستئذان",
                                  style: descTx1(secondryColorText),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              StaggeredGrid.count(
                                  crossAxisCount: responsiveGrid(1, 2),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  children: [
                                    TextFormField(
                                      controller: _date,
                                      style: TextStyle(
                                        color: baseColorText,
                                      ),
                                      readOnly: true,
                                      // keyboardType: TextInputType.datetime,
                                      maxLines: 1,
                                      decoration: formlabel1("تاریخ الاستئذان"),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'فضلاً أدخل التاريخ  ';
                                        }
                                        return null;
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
                                          _date.text =
                                              date.toString().split(" ")[0];
                                          print('change $date');
                                        }, onConfirm: (date) {
                                          _date.text =
                                              date.toString().split(" ")[0];
                                          print('confirm $date');
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.ar);
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ]),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "نوع الاستئذان ",
                                      style: descTx1(baseColorText),
                                      maxLines: 3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  ToggleSwitch(
                                    radiusStyle: true,
                                    borderWidth: 1,
                                    borderColor: [bordercolor],
                                    inactiveBgColor: BackGColor,
                                    inactiveFgColor: baseColorText,
                                    activeBgColor: [baseColor],
                                    totalSwitches: 2,
                                    labels: ['حضوري', 'انصراف'],
                                    onToggle: (index) {
                                      int indexS = index as int;
                                      print('switched to: ');
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "الموظف البديل ",
                                      style: descTx1(baseColorText),
                                      maxLines: 3,
                                    ),
                                    //DROPDOWN LIST WITH SEARCH FUNCTION
                                  ),
                                ],
                              ),
                              TextFormField(
                                controller: _note,
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                style: TextStyle(color: baseColorText),
                                decoration: formlabel1("ملاحظات"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              widgetsUni.actionbutton(
                                'الطلبات السابقة',
                                Icons.history,
                                () {
                                  Navigator.pushNamed(context,
                                      "/vacation_old_request"); //TO BE CHANGED
                                },
                              ),
                              //
                              // widgetsUni.actionbutton(
                              //           'تنفيذ',
                              //           Icons.send,
                              //           () {
                              //             // Validate returns true if the form is valid, or false otherwise.
                              //             if (_SignatureApproval == null &&
                              //                 sharedPref.getInt("empTypeID") != 8) {
                              //               setState(() {
                              //                 errormessege = true;
                              //               });
                              //               Alerts.errorAlert(context, "خطأ",
                              //                       "يرجى الاختيار الرغبة بإعطاء الموظف البديل صلاحية")
                              //                   .show();
                              //             } else {
                              //               setState(() {
                              //                 errormessege = false;
                              //               });
                              //             }
                              //             ////
                              //             if (_ReplaceEmployeeNumber == null) {
                              //               setState(() {
                              //                 errormessege2 = true;
                              //               });
                              //             } else {
                              //               setState(() {
                              //                 errormessege2 = false;
                              //               });
                              //             }
                              //             if (_formKey.currentState!.validate() &&
                              //                 _SignatureApproval != null &&
                              //                 _ReplaceEmployeeNumber != null) {
                              //               // If the form is valid, display a snackbar. In the real world,
                              //               // you'd often call a server or save the information in a database.
                              //               InsertVacationRequest();
                              //             }
                              //             if (sharedPref.getInt("empTypeID") == 8 &&
                              //                 _ReplaceEmployeeNumber != null &&
                              //                 _formKey.currentState!.validate()) {
                              //               InsertVacationRequest();
                              //             }
                              //           },
                              //         ),
                              //
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
