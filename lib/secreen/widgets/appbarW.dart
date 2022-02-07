import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class AppBarW {
  static PreferredSize appBarW(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffDBF3FF),
                      Color(0xffE8FEFF),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/SVGs/header.png',
                        width: 120,
                      ),
                      Text(
                        title,
                        style: const TextStyle(color: baseColor),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 25),
                padding: EdgeInsets.all(0),
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
