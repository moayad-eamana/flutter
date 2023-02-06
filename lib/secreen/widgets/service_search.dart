import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/utilities/ArryOfServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/searchX.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSearchDelegate extends SearchDelegateR {
  BuildContext context;
  dynamic id;
  bool fav;

  CustomSearchDelegate(this.context, this.id, this.fav);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
            showSuggestions(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> favs = sharedPref.getStringList("favs") ?? [];
    listOfServices obj = listOfServices(context);
    dynamic Services = obj.customerService() +
        obj.hrservices() +
        obj.Salarservices() +
        obj.attendanceService() +
        obj.questService() +
        obj.otherService();
    for (int i = 0; i < favs.length; i++) {
      for (int j = 0; j < Services.length; j++) {
        if (favs[i] == Services[j]["service_name"]) {
          var tmp = Services[j];

          Services.removeAt(j);
          Services.insert(0, tmp);
          // services2.removeAt(j + 1);

        }
      }
    }
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
            itemCount: Services.length,
            itemBuilder: (context, index) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                    trailing: GestureDetector(
                      onTap: () {
                        List<String> favs =
                            sharedPref.getStringList("favs") ?? [];

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.

                        if (!isFav(Services[index]["service_name"] as String)) {
                          if (favs.length == 0) {
                            // final snackBar = SnackBar(
                            //   content: Text("تم إضافة الخدمة الى مفضلتي"),
                            //   duration: Duration(seconds: 1),
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Fluttertoast.showToast(
                              msg: "تم إضافة الخدمة الى مفضلتي", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.CENTER, // location
                              timeInSecForIosWeb: 1, // duration
                              backgroundColor: BackGColor,
                              textColor: baseColorText,
                            );
                            favs.insert(
                                0, Services[index]["service_name"] as String);
                          } else {
                            // final snackBar = SnackBar(
                            //   content: Text("تم إضافة الخدمة الى مفضلتي"),
                            //   width: 10,
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            // print(MediaQuery.of(context).viewInsets.bottom != 0);
                            Fluttertoast.showToast(
                              msg: "تم إضافة الخدمة الى مفضلتي", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.CENTER, // location
                              timeInSecForIosWeb: 1, // duration
                              backgroundColor: BackGColor,
                              textColor: baseColorText,
                            );
                            favs.insert(favs.length - 1,
                                Services[index]["service_name"] as String);
                          }

                          sharedPref.setStringList("favs", favs);
                        } else {
                          for (int i = 0; i < favs.length; i++) {
                            if (Services[index]["service_name"] == favs[i]) {
                              favs.removeAt(i);
                              sharedPref.setStringList("favs", favs);
                            }
                          }
                          // final snackBar = SnackBar(
                          //   content: Text("تم حذف الخدمة من مفضلتي"),
                          // );
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // print(MediaQuery.of(context).viewInsets.bottom);
                          Fluttertoast.showToast(
                            msg: "تم حذف الخدمة من مفضلتي", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.CENTER, // location
                            timeInSecForIosWeb: 1, // duration
                            backgroundColor: BackGColor,
                            textColor: baseColorText,
                          );
                        }

                        print("object");
                        setState(() {});
                        //    buildSuggestions(context);
                      },
                      child: Icon(
                        Icons.star,
                        color: isFav(Services[index]["service_name"].toString())
                            ? secondryColor
                            : Colors.grey,
                      ),
                    ),
                    leading: SvgPicture.asset(
                      Services[index]["icon"],
                      width: responsiveMT(30, 35),
                    ),
                    title: Text(
                      Services[index]["service_name"],
                      style: descTx1(baseColorText),
                    ),
                    onTap: Services[index]["Action"]),
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> favs = sharedPref.getStringList("favs") ?? [];
    listOfServices obj = listOfServices(context);
    dynamic Services = obj.customerService() +
        obj.hrservices() +
        obj.Salarservices() +
        obj.attendanceService() +
        obj.questService() +
        obj.otherService();

    for (int i = 0; i < favs.length; i++) {
      for (int j = 0; j < Services.length; j++) {
        if (favs[i] == Services[j]["service_name"]) {
          var tmp = Services[j];

          Services.removeAt(j);
          Services.insert(0, tmp);
          // services2.removeAt(j + 1);

        }
      }
    }
    final suggestions = query.isEmpty
        ? Services // replaced with rescntservices
        : Services.where((s) {
            //   print(s["service_name"]);

            return s["service_name"].toString().contains(query);
          }).toList();

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                    trailing: GestureDetector(
                      onTap: () {
                        List<String> favs =
                            sharedPref.getStringList("favs") ?? [];

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.

                        if (!isFav(
                            suggestions[index]["service_name"] as String)) {
                          if (favs.length == 0) {
                            // final snackBar = SnackBar(
                            //   content: Text("تم إضافة الخدمة الى مفضلتي"),
                            //   duration: Duration(seconds: 1),
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Fluttertoast.showToast(
                              msg: "تم إضافة الخدمة الى مفضلتي", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.CENTER, // location
                              timeInSecForIosWeb: 1, // duration
                              backgroundColor: BackGColor,
                              textColor: baseColorText,
                            );
                            favs.insert(0,
                                suggestions[index]["service_name"] as String);
                          } else {
                            // final snackBar = SnackBar(
                            //   content: Text("تم إضافة الخدمة الى مفضلتي"),
                            //   width: 10,
                            // );
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            // print(MediaQuery.of(context).viewInsets.bottom != 0);
                            Fluttertoast.showToast(
                              msg: "تم إضافة الخدمة الى مفضلتي", // message
                              toastLength: Toast.LENGTH_SHORT, // length
                              gravity: ToastGravity.CENTER, // location
                              timeInSecForIosWeb: 1, // duration
                              backgroundColor: BackGColor,
                              textColor: baseColorText,
                            );
                            favs.insert(favs.length - 1,
                                suggestions[index]["service_name"] as String);
                          }

                          sharedPref.setStringList("favs", favs);
                        } else {
                          for (int i = 0; i < favs.length; i++) {
                            if (suggestions[index]["service_name"] == favs[i]) {
                              favs.removeAt(i);
                              sharedPref.setStringList("favs", favs);
                            }
                          }
                          // final snackBar = SnackBar(
                          //   content: Text("تم حذف الخدمة من مفضلتي"),
                          // );
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // print(MediaQuery.of(context).viewInsets.bottom);
                          Fluttertoast.showToast(
                            msg: "تم حذف الخدمة من مفضلتي", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.CENTER, // location
                            timeInSecForIosWeb: 1, // duration
                            backgroundColor: BackGColor,
                            textColor: baseColorText,
                          );
                        }

                        print("object");
                        setState(() {});
                        //    buildSuggestions(context);
                      },
                      child: Icon(
                        Icons.star,
                        color:
                            isFav(suggestions[index]["service_name"].toString())
                                ? secondryColor
                                : Colors.grey,
                      ),
                    ),
                    leading: SvgPicture.asset(
                      suggestions[index]["icon"],
                      width: responsiveMT(30, 35),
                    ),
                    title: Text(
                      suggestions[index]["service_name"],
                      style: descTx1(baseColorText),
                    ),
                    onTap: Services[index]["Action"]
                    // if (fav == false) {
                    //   bool fingerprint = sharedPref.getBool('fingerprint')!;

                    //   query = suggestions[index]["service_name"];

                    //   var navi = suggestions[index]["Navigation"]
                    //           .toString()
                    //           .isNotEmpty
                    //       ? suggestions[index]["Navigation"]
                    //       : '/home';

                    //   print(query == "تعريف بالراتب");

                    //   if (query == "رصيد إجازات") {
                    //     rseed();
                    //   } else if (query == "تعريف بالراتب") {
                    //     EasyLoading.show(
                    //       status: '... جاري المعالجة',
                    //       maskType: EasyLoadingMaskType.black,
                    //     );
                    //     var respons;
                    //     if ((sharedPref.getString("dumyuser") !=
                    //         "10284928492")) {
                    //       String emNo =
                    //           await EmployeeProfile.getEmployeeNumber();
                    //       respons = await getAction(
                    //           "HR/GetEmployeeSalaryReport/" + emNo);
                    //       EasyLoading.dismiss();
                    //       if (fingerprint == true) {
                    //         Navigator.pushNamed(context, "/auth_secreen")
                    //             .then((value) {
                    //           if (value == true) {
                    //             if (jsonDecode(respons.body)["salaryPdf"] !=
                    //                 null) {
                    //               ViewFile.open(
                    //                       jsonDecode(
                    //                           respons.body)["salaryPdf"],
                    //                       "pdf")
                    //                   .then((value) {
                    //                 close(this.context, null);
                    //               });
                    //             } else {
                    //               Alerts.warningAlert(context, "خطأ",
                    //                       "لا توجد بيانات للتعريف بالراتب")
                    //                   .show();
                    //             }
                    //           }
                    //         });
                    //       }
                    //     } else {
                    //       if ((sharedPref.getString("dumyuser") !=
                    //           "10284928492")) {
                    //         if (jsonDecode(respons.body)["salaryPdf"] !=
                    //             null) {
                    //           ViewFile.open(
                    //                   jsonDecode(respons.body)["salaryPdf"],
                    //                   "pdf")
                    //               .then((value) {
                    //             close(this.context, null);
                    //           });
                    //         } else {
                    //           Alerts.warningAlert(context, "خطأ",
                    //                   "لا توجد بيانات للتعريف بالراتب")
                    //               .show();
                    //         }
                    //       } else {
                    //         await Future.delayed(Duration(seconds: 1));
                    //         Alerts.warningAlert(context, "خطأ",
                    //                 "لا توجد بيانات للتعريف بالراتب")
                    //             .show();
                    //         EasyLoading.dismiss();
                    //       }
                    //     }
                    //     logApiModel logapiO = logApiModel();
                    //     logapiO.ControllerName = "SalaryController";
                    //     logapiO.ClassName = "SalaryController";
                    //     logapiO.ActionMethodName = "تعريف بالراتب";
                    //     logapiO.ActionMethodType = 1;
                    //     logapiO.StatusCode = 1;

                    //     logApi(logapiO);
                    //   } else if (query == "سجل الرواتب") {
                    //     if (fingerprint == true) {
                    //       Navigator.pushNamed(context, "/auth_secreen")
                    //           .then((value) {
                    //         if (value == true) {
                    //           Navigator.pushNamed(
                    //                   this.context, "/SalaryHistory")
                    //               .then((value) {
                    //             //   close(this.context, null);
                    //           });
                    //         }
                    //       });
                    //     } else {
                    //       Navigator.pushNamed(context, "/SalaryHistory")
                    //           .then((value) {
                    //         close(this.context, true);
                    //       });
                    //     }
                    //   } else {
                    //     navi.runtimeType == String
                    //         ? Navigator.pushNamed(context, navi)
                    //             .then((value) {
                    //             close(this.context, null);
                    //           })
                    //         : Navigator.push(context, navi).then((value) {
                    //             close(this.context, null);
                    //           });
                    //   }
                    // }
                    ),
              );
            });
      },
    );
  }

  isFav(String servName) {
    List<String> favs = sharedPref.getStringList("favs") ?? [];
    dynamic val = false;

    // favs = jsonDecode(favs);
    for (int j = 0; favs.length > j; j++) {
      if (favs[j] == servName) {
        return true;
      }
    }

    return val;
  }

  // Future<void> rseed() async {
  //   EasyLoading.show(
  //     status: '... جاري المعالجة',
  //     maskType: EasyLoadingMaskType.black,
  //   );

  //   dynamic respose;
  //   if ((sharedPref.getString("dumyuser") != "10284928492")) {
  //     String emNo = await EmployeeProfile.getEmployeeNumber();
  //     respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
  //     respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
  //   } else {
  //     await Future.delayed(Duration(seconds: 1));
  //     respose = "22";
  //   }
  //   logApiModel logapiO = logApiModel();
  //   logapiO.ControllerName = "VacationsController";
  //   logapiO.ClassName = "VacationsController";
  //   logapiO.ActionMethodName = "رصيد الاجازات";
  //   logapiO.ActionMethodType = 1;
  //   logapiO.StatusCode = 1;

  //   logApi(logapiO);

  //   EasyLoading.dismiss();
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Directionality(
  //       textDirection: TextDirection.rtl,
  //       child: AlertDialog(
  //         backgroundColor: BackGWhiteColor,
  //         title: Builder(builder: (context) {
  //           return Center(
  //             child: Text(
  //               'رصيد الاجازات',
  //               style: titleTx(baseColor),
  //             ),
  //           );
  //         }),
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               respose.toString(),
  //               style: TextStyle(
  //                   fontSize: 38,
  //                   fontWeight: FontWeight.bold,
  //                   color: secondryColor),
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               widgetsUni.actionbutton(
  //                 'طلب إجازة',
  //                 Icons.send,
  //                 () {
  //                   Navigator.pushNamed(context, "/VacationRequest")
  //                       .then((value) => Navigator.pop(context));
  //                 },
  //               ),
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context, 'OK'),
  //                 child: Text(
  //                   'إغلاق',
  //                   style: subtitleTx(baseColor),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ).then((value) => close(this.context, null));
  // }
}
