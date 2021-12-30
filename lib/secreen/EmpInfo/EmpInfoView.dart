import 'package:clipboard/clipboard.dart';
import 'package:eamanaapp/provider/EmpInfoProvider.dart';
import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmpInfoView extends StatefulWidget {
  const EmpInfoView({Key? key}) : super(key: key);

  @override
  _EmpInfoViewState createState() => _EmpInfoViewState();
}

class _EmpInfoViewState extends State<EmpInfoView> {
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<EmpInfoProvider>(context).empinfoList;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Stack(
        children: [
          SvgPicture.asset(
            'assets/SVGs/background.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  controller: _search,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "رقم الوضيفي",
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          EasyLoading.show(
                            status: 'loading...',
                          );
                          await Provider.of<EmpInfoProvider>(context,
                                  listen: false)
                              .fetchEmpInfo(_search.text);
                          EasyLoading.dismiss();
                          print("ssssssssss");
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
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _provider.length,
                              itemBuilder: (BuildContext context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: ScaleAnimation(
                                    curve: Curves.linear,
                                    child: Container(
                                      height: 295,
                                      child: Card(
                                        elevation: 5,
                                        child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  _provider[index].EmployeeName,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Center(
                                                child: TexrW(
                                                    _provider[index].JobName),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: const Divider(
                                                  color: Colors.blue,
                                                  thickness: 0.5,
                                                ),
                                              ),
                                              Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: _provider[index]
                                                                .ImageURL ==
                                                            ""
                                                        ? Image.asset(
                                                            "assets/SVGs/dumyprofile.png")
                                                        : ClipOval(
                                                            child: FadeInImage
                                                                .assetNetwork(
                                                              fit: BoxFit.cover,
                                                              width: 50,
                                                              height: 50,
                                                              image: "https://archive.eamana.gov.sa/TransactFileUpload" +
                                                                  _provider[
                                                                          index]
                                                                      .ImageURL
                                                                      .split(
                                                                          "\$")[1],
                                                              placeholder:
                                                                  "assets/SVGs/dumyprofile.png",
                                                            ),
                                                          ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SelectableText("رقم الجوال : " +
                                                                (_provider[index]
                                                                            .GenderID ==
                                                                        2
                                                                    ? "0"
                                                                    : _provider[
                                                                            index]
                                                                        .MobileNumber)),
                                                          ],
                                                        ),
                                                        TexrW(
                                                            "البريد الالكتروني : " +
                                                                _provider[index]
                                                                    .Email),
                                                        TexrW("رقم التحويلة : " +
                                                            _provider[index]
                                                                .Extension
                                                                .toString()),
                                                        Row(
                                                          children: [
                                                            TexrW("الرقم الوضيفي : " +
                                                                _provider[index]
                                                                    .EmployeeNumber
                                                                    .toString()
                                                                    .split(
                                                                        ".")[0]),
                                                            IconButton(
                                                                onPressed: () {
                                                                  FlutterClipboard.copy(_provider[
                                                                              index]
                                                                          .EmployeeNumber
                                                                          .toString()
                                                                          .split(
                                                                              ".")[0])
                                                                      .then((value) => print('copied'));
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.copy,
                                                                  size: 20,
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
                                              const Divider(
                                                  indent: 20,
                                                  endIndent: 20,
                                                  thickness: 0.5),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton.icon(
                                                      label:
                                                          const Text('واتساب'),
                                                      icon: const FaIcon(
                                                        FontAwesomeIcons
                                                            .whatsapp,
                                                        color: baseColor,
                                                        size: 24.0,
                                                      ),
                                                      style: mainbtn,
                                                      onPressed: _provider[
                                                                      index]
                                                                  .GenderID ==
                                                              2
                                                          ? null
                                                          : () {
                                                              if (_provider[
                                                                          index]
                                                                      .GenderID ==
                                                                  1) {
                                                                launch(
                                                                    "https://wa.me/+966${_provider[index].MobileNumber}/?text=${Uri.parse("السلام عليكم ورحمة الله وبركاته")}");
                                                              }
                                                            },
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton.icon(
                                                      label:
                                                          const Text('إتصال'),
                                                      icon: const Icon(
                                                        Icons.call,
                                                        color: baseColor,
                                                        size: 24.0,
                                                      ),
                                                      style: mainbtn,
                                                      onPressed: _provider[
                                                                      index]
                                                                  .GenderID ==
                                                              2
                                                          ? null
                                                          : () {
                                                              launch("tel://" +
                                                                  _provider[
                                                                          index]
                                                                      .MobileNumber);
                                                            },
                                                    ),
                                                  ],
                                                ),
                                              )
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
        ],
      )),
    );
  }

  Widget TexrW(String val) {
    return Text(
      val,
      style: TextStyle(fontFamily: "Cairo"),
    );
  }
}
