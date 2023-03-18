import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/services/AndroidWallet4.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class EmployeeCard extends StatelessWidget {
  Function? function;
  EmployeeCard(this.function);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: function == null
                ? null
                : () {
                    function!();
                  },
            child: Card(
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/ar/5/5a/%D8%B4%D8%B9%D8%A7%D8%B1_%D9%88%D8%B2%D8%A7%D8%B1%D8%A9_%D8%A7%D9%84%D8%B4%D8%A4%D9%88%D9%86_%D8%A7%D9%84%D8%A8%D9%84%D8%AF%D9%8A%D8%A9.png'),
                            height: 60,
                            width: 60,
                          ),
                          Column(
                            children: [
                              Text(
                                " أمانة المنطقة الشرقية ",
                                style: TextStyle(
                                    color: baseColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Eastern Province Municipality',
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/SVGs/amanah-v.png",
                            width: 60,
                            height: 60,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CachedNetworkImage(
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        imageUrl:
                            "https://archive.eamana.gov.sa/TransactFileUpload" +
                                sharedPref.getString("ImageURL").toString(),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/image/blank-profile.png",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          sharedPref.getString("EmployeeName") ?? "",
                          style: TextStyle(
                              color: baseColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          jobNameOrTitleEnOrAr("AR"),
                          style: TextStyle(
                              color: baseColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     "الجريسي لخدمات الكمبيوتر",
                      //     style: TextStyle(
                      //         color: baseColor,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("الجنسية: "),
                                  Text("سعودية"),
                                  // ,
                                  // ,
                                  //
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("رقم الهوية: "),
                                  Text(sharedPref
                                          .getString("UserIdentityNumber") ??
                                      ""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("رقم الموظف: "),
                                  Text(EmployeeProfile.getEmployeeNumber()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("صالحة لغاية: "),
                                  Text("01/10/2023"),
                                ],
                              ),
                            ],
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: CachedNetworkImage(
                              height: 90,
                              width: 70,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://archive.eamana.gov.sa/TransactFileUpload" +
                                      sharedPref
                                          .getString("ImageURL")
                                          .toString(),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/image/blank-profile.png",
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: baseColor,
                        // width: double.infinity,
                        width: 100.w,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'www.Eamana.gov.sa',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
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
}
