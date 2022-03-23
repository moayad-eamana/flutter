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
            children: [
              Container(
                decoration: BoxDecoration(color: BackGWhiteColor),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Image.asset(
                          'assets/image/rakamy-logo-21.png',
                          width: 80,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(color: baseColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
