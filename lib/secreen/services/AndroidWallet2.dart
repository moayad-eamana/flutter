import 'package:eamanaapp/secreen/services/AndroidWallet.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class AndroidWallet2 extends StatefulWidget {
  const AndroidWallet2({Key? key}) : super(key: key);

  @override
  State<AndroidWallet2> createState() => _AndroidWallet2State();
}

class _AndroidWallet2State extends State<AndroidWallet2> {
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
                              " أمانة المنطقة الشرقية ",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "نور ناجي السعود",
                                style: TextStyle(
                                  color: baseColor,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                              height: 60,
                              width: 60,
                            ),
                          ],
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
                                "4435673",
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
                                "0555555555",
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
