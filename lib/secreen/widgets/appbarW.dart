import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/searchX.dart';
import 'package:eamanaapp/secreen/widgets/service_search.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
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
        backgroundColor: Colors.white,
        flexibleSpace: Stack(
          children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(color: Color(0xffFFFFFF)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushReplacementNamed(context, "/home");
                      //   },
                      //   child: Image.asset(
                      //     'assets/image/rakamy-logo-21.png',
                      //     width: 65,
                      //   ),
                      // ),
                      // Text(
                      //   title,
                      //   style: TextStyle(
                      //       color: secondryColor,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 18),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            if (showBack == false)
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: fontsStyle.px20(
                            fontsStyle.SecondaryColor(), FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            if (showBack == null)
              Container(
                margin: EdgeInsets.only(right: 25, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_back_ios),
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
                                  if (function != null &&
                                      title == "إختر موظف") {
                                    function();
                                  } else {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                            showBack == null
                                ? Container(
                                    margin: EdgeInsets.only(right: 10, top: 30),
                                    child: Text(
                                      title,
                                      style: fontsStyle.px20(
                                          fontsStyle.SecondaryColor(),
                                          FontWeight.bold),
                                    ))
                                : Container(
                                    margin: EdgeInsets.only(right: 10, top: 30),
                                    child: Text(
                                      title,
                                      style: fontsStyle.px20(
                                          fontsStyle.SecondaryColor(),
                                          FontWeight.bold),
                                    )),
                          ],
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     if (title == "إضافة مخالفة") {
                        //       Alerts.confirmAlrt(context, "خروج",
                        //               "هل تريد الخروج النظام المخالفات", "نعم")
                        //           .show()
                        //           .then((value) async {
                        //         if (value == true) {
                        //           Navigator.pop(context);
                        //         }
                        //       });
                        //     }
                        //     if (function != null && title == "إختر موظف") {
                        //       function();
                        //     } else {
                        //       Navigator.pop(context);
                        //     }
                        //   },
                        //   child: Container(
                        //       color: Colors.amber,
                        //       margin: EdgeInsets.only(right: 10, top: 30),
                        //       child: Text(
                        //         "رجوع",
                        //         style: TextStyle(color: baseColorText),
                        //       )),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            if (title == "خدماتي المفضلة")
              Positioned(
                left: 25,
                // top: 30,
                bottom: 15,
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
            if ((title == "عرض الطلبات") && function != null)
              Positioned(
                left: 25,
                bottom: 0,
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
            if ((title == "عروض الموظفين" ||
                    title == "سجل الحضور و الإنصراف") &&
                function != null)
              Positioned(
                left: 25,
                bottom: 15,
                child: GestureDetector(
                  onTap: () {
                    title == "سجل الحضور و الإنصراف"
                        ? function()
                        : function(context);
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
                          title == "سجل الحضور و الإنصراف" ? "" : "تصنيفات",
                          style: TextStyle(color: baseColorText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (title == "تصنيفات العروض" && function != null)
              Positioned(
                left: 25,
                bottom: 15,
                child: GestureDetector(
                  onTap: () {
                    function();
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.clear_all,
                          color: baseColor,
                          size: 30,
                        ),
                        Text(
                          "مسح التصفية",
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
                bottom: 15,
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
            if (function != null && (title == "الإحصائيات"))
              Positioned(
                left: 25,
                bottom: 15,
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
                bottom: 15,
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
    );
  }
}
