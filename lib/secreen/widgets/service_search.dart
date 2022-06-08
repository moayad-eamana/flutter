import 'dart:convert';

import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/provider/mahamme/eatemadatProvider.dart';
import 'package:eamanaapp/provider/meeting/meetingsProvider.dart';
import 'package:eamanaapp/secreen/EmpInfo/EmpInfoView.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/Meetings/meetingsView.dart';
import 'package:eamanaapp/secreen/mahamme/InboxHedersView.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/secreen/old/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class CustomSearchDelegate extends SearchDelegate {
  BuildContext context;
  dynamic id;
  CustomSearchDelegate(this.context, this.id);
  final services1 = [
    ////شؤون الموظفين
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/ejaza.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/kharejdawam.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "",
      "icon": 'assets/SVGs/ejaza.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/entdab.svg',
    },
    {
      "service_name": "العهد", /////////
      "Navigation": "/auhad",
      "icon": 'assets/SVGs/3ohad.svg',
    },
    //الرواتب
    {
      "service_name": "سجل الرواتب",
      "Navigation": "/SalaryHistory",
      "icon": 'assets/SVGs/sejelalrawatb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
    //مهامي
    {
      "service_name": "إعتماداتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EatemadatProvider(),
          // ignore: prefer_const_constructors
          child: InboxHedersView(),
        ),
      ),
      "icon": 'assets/SVGs/e3tmadaty.svg',
    },
    if (hasePerm == "true")
      {
        "service_name": "مواعيدي",
        "Navigation": MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MettingsProvider(),
            // ignore: prefer_const_constructors
            child: MeetingView(),
          ),
        ),
        "icon": 'assets/SVGs/mawa3idi.svg',
      },
    //خدمات أخرى
    // {
    //   "service_name": "الفعاليات",
    //   "Navigation": "",
    //   "icon": 'assets/SVGs/events.svg',
    // },
    // {
    //   "service_name": "عروض الموظفين",
    //   "Navigation": "/EamanaDiscount",
    //   "icon": 'assets/SVGs/offers.svg',
    // },
    {
      "service_name": "دليل الموظفين",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpInfoView(null),
        ),
      ),
      "icon": 'assets/SVGs/dalelalmowzafen.svg',
    },
    {
      "service_name": "معلوماتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

  final services2 = [
    ////شؤون الموظفين
    {
      "service_name": "طلب إجازة",
      "Navigation": "/VacationRequest",
      "icon": 'assets/SVGs/ejaza.svg',
    },
    {
      "service_name": "طلب خارج دوام",
      "Navigation": "/OutdutyRequest",
      "icon": 'assets/SVGs/kharejdawam.svg',
    },
    {
      "service_name": "رصيد إجازات",
      "Navigation": "",
      "icon": 'assets/SVGs/ejaza.svg'
    },
    {
      "service_name": "طلب إنتداب",
      "Navigation": "/entedab",
      "icon": 'assets/SVGs/entdab.svg',
    },
    {
      "service_name": "العهد", /////////
      "Navigation": "/auhad",
      "icon": 'assets/SVGs/3ohad.svg',
    },

    //الرواتب
    {
      "service_name": "سجل الرواتب",
      "Navigation": "/SalaryHistory",
      "icon": 'assets/SVGs/sejelalrawatb.svg',
    },
    {
      "service_name": "تعريف بالراتب",
      "Navigation": "/auth_secreen",
      "icon": 'assets/SVGs/ta3refalratb.svg',
    },
    //مهامي
    {
      "service_name": "إعتماداتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EatemadatProvider(),
          // ignore: prefer_const_constructors
          child: InboxHedersView(),
        ),
      ),
      "icon": 'assets/SVGs/e3tmadaty.svg',
    },
    if (hasePerm == "true")
      {
        "service_name": "مواعيدي",
        "Navigation": MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MettingsProvider(),
            // ignore: prefer_const_constructors
            child: MeetingView(),
          ),
        ),
        "icon": 'assets/SVGs/mawa3idi.svg',
      },
    //خدمات أخرى
    // {
    //   "service_name": "الفعاليات",
    //   "Navigation": "",
    //   "icon": 'assets/SVGs/events.svg',
    // },
    // {
    //   "service_name": "عروض",
    //   "Navigation": "/EamanaDiscount",
    //   "icon": 'assets/SVGs/offers.svg',
    // },
    {
      "service_name": "دليل الموظفين",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpInfoView(null),
        ),
      ),
      "icon": 'assets/SVGs/dalelalmowzafen.svg',
    },
    {
      "service_name": "معلوماتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

  //did't use
  final rescntservices = [
    {
      "service_name": "معلوماتي",
      "Navigation": MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => EmpInfoProvider(),
          // ignore: prefer_const_constructors
          child: EmpProfile(null),
        ),
      ),
      "icon": 'assets/SVGs/baynaty.svg',
    },
  ];

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var services = hasePerm == "true" ? services2 : services1;
    final suggestions = query.isEmpty
        ? services // replaced with rescntservices
        : services.where((s) {
            //   print(s["service_name"]);

            return s["service_name"].toString().contains(query);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) {
    List<String> favs = sharedPref.getStringList("favs") ?? [];

    for (int i = 0; i < favs.length; i++) {
      for (int j = 0; j < services2.length; j++) {
        if (favs[i] == services2[j]["service_name"]) {
          var tmp = services2[j];
          services1.removeAt(j);
          services1.insert(0, tmp);
          services2.removeAt(j);
          services2.insert(0, tmp);
          // services2.removeAt(j + 1);

        }
      }
    }
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

                      if (!isFav(services2[index]["service_name"] as String)) {
                        if (favs.length == 0) {
                          final snackBar = SnackBar(
                            content: Text("تم إضافة الخدمة الى مفضلتي"),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          favs.insert(
                              0, services2[index]["service_name"] as String);
                        } else {
                          final snackBar = SnackBar(
                            content: Text("تم إضافة الخدمة الى مفضلتي"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          favs.insert(favs.length - 1,
                              services2[index]["service_name"] as String);
                        }

                        sharedPref.setStringList("favs", favs);
                      } else {
                        for (int i = 0; i < favs.length; i++) {
                          if (services2[index]["service_name"] == favs[i]) {
                            favs.removeAt(i);
                            sharedPref.setStringList("favs", favs);
                          }
                        }
                        final snackBar = SnackBar(
                          content: Text("تم حذف الخدمة من مفضلتي"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      print("object");
                      setState(() {});
                      //    buildSuggestions(context);
                    },
                    child: Icon(
                      Icons.star,
                      color: isFav(services2[index]["service_name"].toString())
                          ? secondryColor
                          : Colors.grey,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    suggestions[index]["icon"],
                    width: responsiveMT(30, 35),
                  ),
                  // Icon(
                  //   suggestions[index]["icon"],
                  //   color: baseColor,
                  // ),
                  title: Text(
                    suggestions[index]["service_name"],
                    style: descTx1(baseColorText),
                  ),

                  onTap: () async {
                    //final fingerprintSP = await SharedPreferences.getInstance();
                    bool fingerprint = sharedPref.getBool('fingerprint')!;
                    // if (fingerprint == true) {
                    //   Navigator.pushNamed(context, "/auth_secreen").then((value) {
                    //     if (value == true) {
                    //       Navigator.pushNamed(context, "/SalaryHistory");
                    //     }
                    //   });
                    // } else {
                    //   Navigator.pushNamed(context, "/SalaryHistory");
                    // }

                    query = suggestions[index]["service_name"];

                    var navi =
                        suggestions[index]["Navigation"].toString().isNotEmpty
                            ? suggestions[index]["Navigation"]
                            : '/home';

                    print(query == "تعريف بالراتب");

                    if (query == "رصيد إجازات") {
                      rseed();
                    } else if (query == "تعريف بالراتب") {
                      EasyLoading.show(
                        status: '... جاري المعالجة',
                        maskType: EasyLoadingMaskType.black,
                      );
                      String emNo = await EmployeeProfile.getEmployeeNumber();
                      var respons =
                          await getAction("HR/GetEmployeeSalaryReport/" + emNo);
                      EasyLoading.dismiss();
                      fingerprint == true
                          ? Navigator.pushNamed(context, "/auth_secreen")
                              .then((value) {
                              if (value == true) {
                                ViewFile.open(
                                        jsonDecode(respons.body)["salaryPdf"],
                                        "pdf")
                                    .then((value) {
                                  close(this.context, null);
                                });
                              }
                            })
                          : ViewFile.open(
                                  jsonDecode(respons.body)["salaryPdf"], "pdf")
                              .then((value) {
                              close(this.context, null);
                            });
                    } else if (query == "سجل الرواتب") {
                      if (fingerprint == true) {
                        Navigator.pushNamed(context, "/auth_secreen")
                            .then((value) {
                          if (value == true) {
                            Navigator.pushNamed(this.context, "/SalaryHistory")
                                .then((value) {
                              //   close(this.context, null);
                            });
                          }
                        });
                      } else {
                        Navigator.pushNamed(context, "/SalaryHistory")
                            .then((value) {
                          close(this.context, true);
                        });
                      }
                    } else {
                      navi.runtimeType == String
                          ? Navigator.pushNamed(context, navi).then((value) {
                              close(this.context, null);
                            })
                          : Navigator.push(context, navi).then((value) {
                              close(this.context, null);
                            });
                    }

                    // query == "رصيد إجازات"
                    //     ? rseed()
                    //     : query == "تعريف بالراتب"
                    //         ? fingerprint == true
                    //             ? Navigator.pushNamed(context, "/auth_secreen")
                    //                 .then((value) {
                    //                 if (value == true) {
                    //                   ViewFile.open(testbase64Pfd, "pdf")
                    //                       .then((value) {
                    //                     close(this.context, null);
                    //                   });
                    //                 }
                    //               })
                    //             : ViewFile.open(testbase64Pfd, "pdf").then((value) {
                    //                 close(this.context, null);
                    //               })
                    //         : query == "سجل الرواتب"
                    //             ? fingerprint == true
                    //                 ? Navigator.pushNamed(context, "/auth_secreen")
                    //                     .then((value) {
                    //                     if (value == true) {
                    //                       Navigator.pushNamed(context, navi)
                    //                           .then((value) {
                    //                         close(this.context, null);
                    //                       });
                    //                     }
                    //                   })
                    //                 : Navigator.pushNamed(context, navi)
                    //                     .then((value) {
                    //                     close(this.context, null);
                    //                   })
                    //             : navi.runtimeType == String
                    //                 ? Navigator.pushNamed(context, navi)
                    //                     .then((value) {
                    //                     close(this.context, null);
                    //                   })
                    //                 : Navigator.push(context, navi).then((value) {
                    //                     close(this.context, null);
                    //                   });
                  },
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

  Future<void> rseed() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    String emNo = await EmployeeProfile.getEmployeeNumber();
    dynamic respose = await getAction("HR/GetEmployeeDataByEmpNo/" + emNo);
    respose = jsonDecode(respose.body)["EmpInfo"]["VacationBalance"];
    EasyLoading.dismiss();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: BackGWhiteColor,
          title: Builder(builder: (context) {
            return Center(
              child: Text(
                'رصيد الاجازات',
                style: titleTx(baseColor),
              ),
            );
          }),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                respose.toString(),
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: secondryColor),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widgetsUni.actionbutton(
                  'طلب إجازة',
                  Icons.send,
                  () {
                    Navigator.pushNamed(context, "/VacationRequest")
                        .then((value) => Navigator.pop(context));
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'إغلاق',
                    style: subtitleTx(baseColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ).then((value) => close(this.context, null));
  }
}
