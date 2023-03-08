import 'package:badges/badges.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/notification/notification.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/notification/bagenotification.dart';
import 'package:flutter_svg/svg.dart';

//NEW
class AppBarHome {
  static PreferredSize appBarW(String title, BuildContext context,
      [bool? shownotification, int? notificationcont]) {
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
              Positioned(
                  right: 25,
                  top: 25,
                  child: SvgPicture.asset(
                    "assets/SVGs/flag-of-saudi-arabia.svg",
                    width: 50,
                    height: 50,
                  )),
              // shownotification == true && shownotification != null
              //     ? Positioned(
              //         left: 25,
              //         top: 25,
              //         child: badgenotification.badgewidget(context))
              //     : Container(),
              // if (sharedPref.getString("dumyuser") != "10284928492")
              //   Align(
              //     alignment: Alignment.centerRight,
              //     child: Image.asset(
              //       "assets/image/GiddamLogo.png",
              //       fit: BoxFit.fill,
              //     ),
              //   ),
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
