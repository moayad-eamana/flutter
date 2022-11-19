import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

//NEW
class AppBarHome {
  static PreferredSize appBarW(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
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
              if (sharedPref.getString("dumyuser") != "10284928492")
                Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/image/GiddamLogo.png",
                    fit: BoxFit.fill,
                  ),
                ),
              // Container(
              //   margin: EdgeInsets.only(right: 25),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
