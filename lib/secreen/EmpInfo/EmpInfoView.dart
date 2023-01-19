import 'package:clipboard/clipboard.dart';
import 'package:eamanaapp/main.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/provider/mahamme/EmpInfoProvider.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class EmpInfoView extends StatefulWidget {
  bool? showback;
  EmpInfoView(this.showback);

  @override
  _EmpInfoViewState createState() => _EmpInfoViewState();
}

class _EmpInfoViewState extends State<EmpInfoView> {
  TextEditingController _search = TextEditingController();
  @override
  @override
  void dispose() {
    // TODO: implement dispose
    logApiModel logapiO = logApiModel();
    logapiO.ControllerName = "DaleelController";
    logapiO.ClassName = "DaleelController";
    logapiO.ActionMethodName = "عرض صفحة دليل الموظفين";
    logapiO.ActionMethodType = 1;
    logapiO.StatusCode = 1;
    logApi(logapiO);
    EasyLoading.dismiss();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var _provider = Provider.of<EmpInfoProvider>(context).empinfoList;
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW(
              "دليل الموظفين", context, widget.showback == null ? null : true),
          body: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              Container(
                margin:
                    EdgeInsets.only(bottom: widget.showback != null ? 10 : 10),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: TextField(
                        onSubmitted: (value) {},
                        style: TextStyle(
                          color: baseColorText,
                        ),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        controller: _search,
                        onEditingComplete: () async {
                          getEmpInfoViewdata();
                        },
                        decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(
                            //     vertical: responsiveMT(8, 30), horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: BorderSide(color: bordercolor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: bordercolor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: bordercolor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            filled: true,
                            fillColor: BackGWhiteColor,
                            labelStyle: subtitleTx(baseColorText),
                            labelText: "بحث عن موظف",
                            alignLabelWithHint: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: baseColor,
                              ),
                              onPressed: () async {
                                getEmpInfoViewdata();
                              },
                            )),
                        onChanged: (String val) {
                          setState(() {
                            if (val.isEmpty) {
                            } else {}
                          });
                        },
                      ),
                    ),
                    _provider.length == 0
                        ? Container()
                        : Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: AnimationLimiter(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                (width >= 768.0 ? 2 : 1),
                                            mainAxisSpacing: 10,
                                            mainAxisExtent:
                                                onlyme() == true ? 320 : 250),
                                    shrinkWrap: true,
                                    itemCount: _provider.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration: Duration(milliseconds: 375),
                                        child: ScaleAnimation(
                                          curve: Curves.linear,
                                          child: Container(
                                            height: 295,
                                            child: Card(
                                              color: BackGWhiteColor,
                                              elevation: 5,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        _provider[index]
                                                            .EmployeeName,
                                                        style: TextStyle(
                                                            color: baseColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Center(
                                                      child: TexrW(
                                                        _provider[index].Title,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      child: Divider(
                                                        color: baseColor,
                                                        thickness: 0.5,
                                                      ),
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                baseColor,
                                                            radius:
                                                                responsiveMT(
                                                                    24, 26),
                                                            child: ClipOval(
                                                              child: _provider[index]
                                                                              .ImageURL ==
                                                                          "" ||
                                                                      _provider[index]
                                                                              .GenderID ==
                                                                          2
                                                                  ? Image.asset(
                                                                      "assets/image/blank-profile.png",
                                                                    )
                                                                  : ClipOval(
                                                                      child: FadeInImage
                                                                          .assetNetwork(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        width:
                                                                            100,
                                                                        height:
                                                                            100,
                                                                        image: "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                                            _provider[index].ImageURL,
                                                                        placeholder:
                                                                            "assets/image/blank-profile.png",
                                                                        imageErrorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            Image.asset(
                                                                          "assets/image/blank-profile.png",
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              onlyme() == true
                                                                  ? Row(
                                                                      children: [
                                                                        SelectableText(
                                                                          "رقم الجوال : " +
                                                                              (_provider[index].GenderID == 2 ? "0" : _provider[index].MobileNumber),
                                                                          style:
                                                                              TextStyle(color: baseColorText),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Container(),
                                                              Row(children: [
                                                                TexrW("البريد الالكتروني : " +
                                                                    _provider[
                                                                            index]
                                                                        .Email),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      launch("mailto:" +
                                                                          _provider[index]
                                                                              .Email +
                                                                          "@eamana.gov.sa");
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .send,
                                                                      size: 20,
                                                                      color:
                                                                          baseColor,
                                                                    ))
                                                              ]),
                                                              TexrW("رقم التحويلة : " +
                                                                  _provider[
                                                                          index]
                                                                      .Extension
                                                                      .toString()),
                                                              Row(
                                                                children: [
                                                                  TexrW("الرقم الوظيفي : " +
                                                                      _provider[
                                                                              index]
                                                                          .EmployeeNumber
                                                                          .toString()
                                                                          .split(
                                                                              ".")[0]),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        FlutterClipboard.copy(_provider[index].EmployeeNumber.toString().split(".")[0]).then((value) =>
                                                                            print('copied'));
                                                                        Fluttertoast
                                                                            .showToast(
                                                                          msg:
                                                                              "تم النسخ", // message
                                                                          toastLength:
                                                                              Toast.LENGTH_SHORT, // length
                                                                          gravity:
                                                                              ToastGravity.BOTTOM, // location
                                                                          timeInSecForIosWeb:
                                                                              1, // duration
                                                                          backgroundColor:
                                                                              BackGColor,
                                                                          textColor:
                                                                              baseColorText,
                                                                        );
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .copy,
                                                                        size:
                                                                            20,
                                                                        color:
                                                                            baseColor,
                                                                      ))
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    onlyme() == true
                                                        ? Divider(
                                                            indent: 20,
                                                            endIndent: 20,
                                                            thickness: 0.5)
                                                        : Container(),
                                                    onlyme() == true
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                ElevatedButton
                                                                    .icon(
                                                                  label: Text(
                                                                      'واتساب'),
                                                                  icon: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .whatsapp,
                                                                    color:
                                                                        baseColor,
                                                                    size: 24.0,
                                                                  ),
                                                                  style:
                                                                      mainbtn,
                                                                  onPressed:
                                                                      _provider[index].GenderID ==
                                                                              2
                                                                          ? null
                                                                          : () {
                                                                              if (_provider[index].GenderID == 1) {
                                                                                launch("https://wa.me/+966${_provider[index].MobileNumber}/?text=${Uri.parse("السلام عليكم ورحمة الله وبركاته")}");
                                                                              }
                                                                            },
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                ElevatedButton
                                                                    .icon(
                                                                  label: Text(
                                                                      'إتصال'),
                                                                  icon: Icon(
                                                                    Icons.call,
                                                                    color:
                                                                        baseColor,
                                                                    size: 24.0,
                                                                  ),
                                                                  style:
                                                                      mainbtn,
                                                                  onPressed:
                                                                      _provider[index].GenderID ==
                                                                              2
                                                                          ? null
                                                                          : () {
                                                                              launch("tel://" + _provider[index].MobileNumber);
                                                                            },
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  bool onlyme() {
    if (sharedPref.getDouble("EmployeeNumber") == 4261003 ||
        sharedPref.getDouble("EmployeeNumber") == 4438104 ||
        sharedPref.getDouble("EmployeeNumber") == 4281309 ||
        sharedPref.getDouble("EmployeeNumber") == 4341012) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getEmpInfoViewdata() async {
    FocusScope.of(context).unfocus();
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );

    if (sharedPref.getString("dumyuser") != "10284928492") {
      bool hasinfo = await Provider.of<EmpInfoProvider>(context, listen: false)
          .fetchEmpInfo(_search.text);
      logApiModel logapiO = logApiModel();
      logapiO.ControllerName = "DaleelController";
      logapiO.ClassName = "DaleelController";
      logapiO.ActionMethodName = "دليل الموظفين";
      logapiO.ActionMethodType = 1;
      logapiO.StatusCode = 1;
      logApi(logapiO);
      if (hasinfo == false) {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "",
          desc: "لايوجد موظفين",
          buttons: [
            DialogButton(
              child: Text(
                "حسنا",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    } else {
      await Future.delayed(Duration(seconds: 1));
      Alert(
        context: context,
        type: AlertType.warning,
        title: "",
        desc: "لايوجد موظفين",
        buttons: [
          DialogButton(
            child: Text(
              "حسنا",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    EasyLoading.dismiss();
  }

  Widget TexrW(String val) {
    return Text(
      val,
      style: TextStyle(fontFamily: "Cairo", color: baseColorText),
      // maxLines: 1,
    );
  }
}
