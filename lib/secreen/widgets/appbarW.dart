import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/searchX.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

dynamic id = EmployeeProfile.getEmplPerm();

class AppBarW {
  static PreferredSize appBarW(
      String title, BuildContext context, bool? showBack,
      [Function? function]) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: BackGWhiteColor),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Image.asset(
                          'assets/image/rakamy-logo-21.png',
                          width: 65,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: secondryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              if (showBack != null)
                if (sharedPref.getString("dumyuser") != "10284928492")
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/image/GiddamLogo.png",
                      fit: BoxFit.fill,
                    ),
                  ),
              if (showBack == null)
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: baseColorText,
                              onPressed: () async {
                                if (title == "إضافة مخالفة") {
                                  Alerts.confirmAlrt(
                                          context,
                                          "خروج",
                                          "هل تريد الخروج النظام المخالفات",
                                          "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      Navigator.pop(context);
                                    }
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (title == "إضافة مخالفة") {
                                Alerts.confirmAlrt(
                                        context,
                                        "خروج",
                                        "هل تريد الخروج النظام المخالفات",
                                        "نعم")
                                    .show()
                                    .then((value) async {
                                  if (value == true) {
                                    Navigator.pop(context);
                                  }
                                });
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 10, top: 30),
                                child: Text(
                                  "رجوع",
                                  style: TextStyle(color: baseColorText),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (title == "خدماتي المفضلة")
                Positioned(
                  left: 25,
                  top: 25,
                  child: GestureDetector(
                    onTap: () {
                      showSearchX(
                          context: context,
                          delegate: CustomSearchDelegate(context, id, true));
                      //     .then((value) {
                      //   setState(() {
                      //     listofFavs = listOfFavs(context);
                      //   });
                      // });
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_add_rounded,
                            color: baseColor,
                            size: 40,
                          ),
                          // Text(
                          //   "المفضلة",
                          //   style: TextStyle(color: baseColorText),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (title == "عرض الطلبات" && function != null)
                Positioned(
                  left: 25,
                  top: 25,
                  child: GestureDetector(
                    onTap: () {
                      function(context);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: baseColor,
                            size: 40,
                          ),
                          Text(
                            "",
                            style: TextStyle(color: baseColorText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (title == "عروض الموظفين" && function != null)
                Positioned(
                  left: 25,
                  top: 25,
                  child: GestureDetector(
                    onTap: () {
                      function(context);
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_list,
                            color: baseColor,
                            size: 40,
                          ),
                          Text(
                            "",
                            style: TextStyle(color: baseColorText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (function != null && title == "مواعيدي")
                Positioned(
                  left: 25,
                  top: 25,
                  child: GestureDetector(
                    onTap: () {
                      function();
                      print("object");
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: baseColor,
                            size: 40,
                          ),
                          Text(
                            "المواعيد السابقة",
                            style: TextStyle(color: baseColorText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (function != null && title == "الإحصائيات")
                Positioned(
                  left: 25,
                  top: 25,
                  child: GestureDetector(
                    onTap: () {
                      function();
                      print("object");
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: baseColor,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (function != null && title == "إدارة المواعيد")
                Positioned(
                  left: 25,
                  top: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: widgetsUni.actionbutton("حفظ", Icons.send, () {
                          function();
                        }),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
