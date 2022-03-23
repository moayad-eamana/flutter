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
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/image/rakamy-logo-21.png',
                        width: 65,
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
