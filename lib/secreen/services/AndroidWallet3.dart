import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class AndroidWallet3 extends StatefulWidget {
  const AndroidWallet3({Key? key}) : super(key: key);

  @override
  State<AndroidWallet3> createState() => _AndroidWallet3State();
}

var name = "نور ناجي عبدالله السعود";
var position = "مبرمجة تطبيقات الجوال";
var jobNo = "56493820";
var mobileNo = "0505050505";

class _AndroidWallet3State extends State<AndroidWallet3> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(children: [
        widgetsUni.bacgroundimage(),
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Card(
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
                            Text(
                              " Eastern Region Municipality ",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Noor Naji Alsaud",
                                style: TextStyle(
                                  color: baseColor,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ],
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
            ],
          ),
        ),
      ]),
    );
  }
}
