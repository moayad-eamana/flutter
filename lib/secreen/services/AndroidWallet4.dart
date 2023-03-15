import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';

class AndroidWallet4 extends StatefulWidget {
  const AndroidWallet4({Key? key}) : super(key: key);

  @override
  State<AndroidWallet4> createState() => _AndroidWallet4State();
}

class _AndroidWallet4State extends State<AndroidWallet4> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(children: [
          widgetsUni.bacgroundimage(),
          Container(
            child: Column(
              children: [
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
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: baseColor,
                            // width: double.infinity,
                            width: 100.w,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                              Text("1234567891"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("رقم الموظف: "),
                              Text("1234567"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
