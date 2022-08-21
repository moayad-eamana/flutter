import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
              if (function != null)
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
            ],
          ),
        ),
      ),
    );
  }
}
