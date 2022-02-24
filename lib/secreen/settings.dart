import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

bool fingerprint = false;
bool darkmode = false;
bool blindness = false;

class _SettingsState extends State<Settings> {
  //
  void getSettings() async {
    final settingSP = await SharedPreferences.getInstance();

    fingerprint = settingSP.getBool("fingerprint")!;

    blindness = settingSP.getBool('blindness')!;

    darkmode = settingSP.getBool("darkmode")!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarHome.appBarW("الاعدادات", context),
          body: SingleChildScrollView(
            child: Container(
              //color: Colors.amber,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "إعدادات الحساب",
                    style: titleTx(baseColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 100,
                      //margin: EdgeInsets.all(20),
                      decoration: containerdecoration(Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text("تغيير كلمة المرور",
                                  style: descTx1(baseColorText)),
                            ),
                            Row(
                              children: [
                                Text("الدخول عن طريق البصمة",
                                    style: descTx1(baseColorText)),
                                Spacer(),
                                Switch(
                                  value: fingerprint,
                                  onChanged: (bool newValue) async {
                                    final fingerprintSP =
                                        await SharedPreferences.getInstance();

                                    fingerprintSP.setBool(
                                        "fingerprint", newValue);

                                    setState(() {
                                      fingerprint =
                                          fingerprintSP.getBool('fingerprint')!;
                                    });
                                    print("fingerprint = " +
                                        fingerprint.toString());
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "إعدادات ذوي الهمم",
                    style: titleTx(baseColor),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      //margin: EdgeInsets.all(20),
                      decoration: containerdecoration(Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text("عمى الألوان",
                                    style: descTx1(baseColorText)),
                                Spacer(),
                                Switch(
                                  value: blindness,
                                  onChanged: (bool newValue) async {
                                    final blindnessSP =
                                        await SharedPreferences.getInstance();

                                    blindnessSP.setBool("blindness", newValue);

                                    setState(() {
                                      blindness =
                                          blindnessSP.getBool('blindness')!;
                                    });
                                    print(
                                        "blindness = " + blindness.toString());
                                    await getColorSettings();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("النظام الليلي",
                                    style: descTx1(baseColorText)),
                                Spacer(),
                                Switch(
                                  value: darkmode,
                                  onChanged: (bool newValue) async {
                                    final darkmodeSP =
                                        await SharedPreferences.getInstance();

                                    darkmodeSP.setBool("darkmode", newValue);

                                    setState(() {
                                      darkmode =
                                          darkmodeSP.getBool('darkmode')!;
                                    });
                                    print("darkmode = " + darkmode.toString());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "تواصلل معنا",
                    style: titleTx(baseColor),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      //margin: EdgeInsets.all(20),
                      decoration: containerdecoration(Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 100,
                              width: 800,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Image(
                          //width: responsiveMT(90, 150),
                          alignment: Alignment.center,
                          width: 150,

                          image: AssetImage("assets/image/rakamy-logo-2.png"),
                        ),
                        Text("الإصدار الأول 1.20.22")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
