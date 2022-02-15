import 'dart:io';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/utilities/globalcss.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "هل تريد الخروج من التطبيق",
                  textAlign: TextAlign.left,
                  style: descTx1(baseColorText),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("لا", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    )),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: Text("نعم"),
                        style: ElevatedButton.styleFrom(primary: baseColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
