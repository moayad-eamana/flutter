import 'package:eamanaapp/secreen/services/AndroidWallet3.dart';
import 'package:eamanaapp/secreen/services/AndroidWallet4.dart';
import 'package:eamanaapp/secreen/violation/addViolation/company/ListOfTextFieleds.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sizer/sizer.dart';
import 'AndroidWallet2.dart';

class AndroidWallet extends StatefulWidget {
  @override
  State<AndroidWallet> createState() => _AndroidWalletState();
}

//test
//get employee's data: الاسم-الوظيفة-الجوال-الرقم الوظيفي
var name = "نور ناجي عبدالله السعود";
var position = "مبرمجة تطبيقات الجوال";
var jobNo = "56493820";
var mobileNo = "0505050505";

class _AndroidWalletState extends State<AndroidWallet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
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
                Positioned(
                    child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AndroidWallet3()));
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "   Eastern Province Municipality    ",
                                        style: TextStyle(
                                            color: baseColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            'https://www.my.gov.sa/wps/wcm/connect/b47400fd-a90d-4d7a-bad6-1b195ac28372/%D8%A3%D9%85%D8%A7%D9%86%D8%A9-%D8%A7%D9%84%D9%85%D9%86%D8%B7%D9%82%D8%A9-%D8%A7%D9%84%D8%B4%D8%B1%D9%82%D9%8A%D8%A9.png?MOD=AJPERES&CACHEID=ROOTWORKSPACE-b47400fd-a90d-4d7a-bad6-1b195ac28372-oluw37v'),
                                        height: 60,
                                        width: 60,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Noor Naji Abdullah Alsaud",
                                      style: TextStyle(
                                        color: baseColor,
                                        fontSize: 26,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Position",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Mobile Application Developer",
                                      style: TextStyle(
                                        color: baseColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Job Number",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 190,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Mobile Number",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          jobNo,
                                          style: TextStyle(
                                            color: baseColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 146,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          mobileNo,
                                          style: TextStyle(
                                            color: baseColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image(
                                        height: 150,
                                        width: 150,
                                        image: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png')),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
                //---- Arabic Card ----
                Positioned(
                    top: 180,
                    child: Container(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AndroidWallet2()));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            " أمانة المنطقة الشرقية     ",
                                            style: TextStyle(
                                                color: baseColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Image(
                                            image: NetworkImage(
                                                'https://www.my.gov.sa/wps/wcm/connect/b47400fd-a90d-4d7a-bad6-1b195ac28372/%D8%A3%D9%85%D8%A7%D9%86%D8%A9-%D8%A7%D9%84%D9%85%D9%86%D8%B7%D9%82%D8%A9-%D8%A7%D9%84%D8%B4%D8%B1%D9%82%D9%8A%D8%A9.png?MOD=AJPERES&CACHEID=ROOTWORKSPACE-b47400fd-a90d-4d7a-bad6-1b195ac28372-oluw37v'),
                                            height: 60,
                                            width: 60,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "الاسم",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "نور ناجي عبدالله السعود",
                                          style: TextStyle(
                                            color: baseColor,
                                            fontSize: 26,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "الوظيفة",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "مبرمج تطبيقات الجوال",
                                          style: TextStyle(
                                            color: baseColor,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "الرقم الوظيفي",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 190,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "رقم الجوال",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              jobNo,
                                              style: TextStyle(
                                                color: baseColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 146,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              mobileNo,
                                              style: TextStyle(
                                                color: baseColor,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Image(
                                            height: 150,
                                            width: 150,
                                            image: NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png')),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
                // ---- بطاقة الموظف ----
                Positioned(
                    top: 350,
                    // right: 10,
                    width: 100.w,
                    child: Container(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AndroidWallet4()));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Eastern Province Municipality',
                                                style: TextStyle(fontSize: 13),
                                              )
                                            ],
                                          ),
                                          Image(
                                            image: NetworkImage(
                                                'https://www.my.gov.sa/wps/wcm/connect/b47400fd-a90d-4d7a-bad6-1b195ac28372/%D8%A3%D9%85%D8%A7%D9%86%D8%A9-%D8%A7%D9%84%D9%85%D9%86%D8%B7%D9%82%D8%A9-%D8%A7%D9%84%D8%B4%D8%B1%D9%82%D9%8A%D8%A9.png?MOD=AJPERES&CACHEID=ROOTWORKSPACE-b47400fd-a90d-4d7a-bad6-1b195ac28372-oluw37v'),
                                            height: 60,
                                            width: 60,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Image(
                                        image: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                                        height: 120,
                                        width: 120,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "نور ناجي عبدالله السعود",
                                          style: TextStyle(
                                              color: baseColor,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "مطور برامج",
                                          style: TextStyle(
                                              color: baseColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "الجريسي لخدمات الكمبيوتر",
                                          style: TextStyle(
                                              color: baseColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("الجنسية: "),
                                          Text("سعودية"),
                                          // ,
                                          // ,
                                          //
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("رقم الهوية: "),
                                          Text("1234567891"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("رقم الموظف: "),
                                          Text("1234567"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("صالحة لغاية: "),
                                          Text("01/10/2023"),
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
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
} //
