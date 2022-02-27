import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class AppBarW {
  static PreferredSize appBarW(
      String title, BuildContext context, bool? showBack) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/rakamy-logo-21.png',
                        width: 80,
                      ),
                      Text(
                        title,
                        style: TextStyle(color: baseColor, fontSize: 18),
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
                              color: Colors.black,
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
                                child: Text("رجوع")),
                          ),
                        ],
                      ),
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
