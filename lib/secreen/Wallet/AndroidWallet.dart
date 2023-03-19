import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/secreen/Wallet/AndroidWallet3.dart';
import 'package:eamanaapp/secreen/Wallet/AndroidWallet4.dart';
import 'package:eamanaapp/secreen/Wallet/EmployeeCard.dart';
import 'package:eamanaapp/secreen/Wallet/businesscardw.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'AndroidWallet2.dart';

class AndroidWallet extends StatefulWidget {
  @override
  State<AndroidWallet> createState() => _AndroidWalletState();
}

//test
//get employee's data: الاسم-الوظيفة-الجوال-الرقم الوظيفي

class _AndroidWalletState extends State<AndroidWallet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded))),
                ),
                sizeBox(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "المحفظة",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(overflow: Overflow.visible, children: [
                  widgetsUni.bacgroundimage(),
                  //---- English Card -----
                  // Positioned(
                  //     width: 100.w,
                  //     child: businesscardw(() {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   AndroidWallet2(businesscardw(null, "en"))));
                  //     }, "en")),
                  //---- Arabic Card ----
                  Positioned(
                      // top: 190,
                      width: 100.w,
                      child: businesscardw(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AndroidWallet3(
                                    businesscardw(null, "AR"),
                                    businesscardw(null, "en"))));
                      }, "AR")),
                  // ---- بطاقة الموظف ----
                  Positioned(
                      top: 250,
                      // right: 10,
                      width: 100.w,
                      child: EmployeeCard(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AndroidWallet4()));
                      })),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String jobNameOrTitleEnOrAr(String lang) {
    if (lang == "en") {
      return sharedPref.getString("TitleEN").toString() == ""
          ? sharedPref.getString("JobName").toString()
          : sharedPref.getString("TitleEN").toString();
    } else {
      return sharedPref.getString("Title").toString() == ""
          ? sharedPref.getString("JobName").toString()
          : sharedPref.getString("Title").toString();
    }
  }
} //
