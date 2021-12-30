import 'package:eamanaapp/provider/EmpInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EmpProfile extends StatefulWidget {
  const EmpProfile({Key? key}) : super(key: key);

  @override
  _EmpProfileState createState() => _EmpProfileState();
}

class _EmpProfileState extends State<EmpProfile> {
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      EasyLoading.show(
        status: 'loading...',
      );
      await Provider.of<EmpInfoProvider>(context, listen: false)
          .fetchEmpInfo("4438104");

      EasyLoading.dismiss();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<EmpInfoProvider>(context).empinfoList;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/SVGs/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            _provider.length == 0
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Image.asset("assets/SVGs/profileBackground.png"),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: 150,
                                  width: 150,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: ClipOval(
                                      child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        image:
                                            "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                _provider[0]
                                                    .ImageURL
                                                    .split("\$")[1],
                                        placeholder:
                                            "assets/SVGs/dumyprofile.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextW_size(_provider[0].EmployeeName),
                        TextW(_provider[0].JobName),
                        Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            elevation: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextW("رقم الجوال : " +
                                        _provider[0].MobileNumber),
                                    TextW("رقم التحويلة : " +
                                        _provider[0].Extension.toString()),
                                    TextW("البريد الالكتروني : " +
                                        _provider[0].Email),
                                    TextW("الرقم الوضيفي : " +
                                        _provider[0]
                                            .EmployeeNumber
                                            .toString()
                                            .split(".")[0]),
                                  ],
                                ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  child: Image.asset(
                                    'assets/SVGs/amanah-v.png',
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    //height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget TextW(String val) {
    return Text(
      val,
      style: TextStyle(fontFamily: "Cairo"),
    );
  }

  Widget TextW_size(String val) {
    return Text(
      val,
      style: TextStyle(
          fontFamily: "Cairo", fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
