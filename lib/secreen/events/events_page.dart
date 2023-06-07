import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/events/event_comments.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List Events = [];
  bool Isload = true;
  int _likeCount = 299;
  bool _isLiked = false;

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    // Future.delayed(const Duration(milliseconds: 500));
    // setState(() {
    //   _likeCount += isLiked ? 1 : -1;
    //   _isLiked = !isLiked;
    // });

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  int i = 1;

  @override
  void initState() {
    super.initState();

    getdatat();
  }

  Future<String> getimagepath(var arcNumber) async {
    String imageByArcSerial = "";
    var respose =
        await getAction("Ens/GetOccationAttachments/" + arcNumber.toString());
    print(respose.body);
    respose = jsonDecode(respose.body);
    if (respose["StatusCode"] == 400) {
      respose = respose["data"];
      // print(respose[respose.length - 1]["FilePath"]);
      imageByArcSerial = respose[respose.length - 1]["FilePath"];
      // print(imageByArcSerial);

      return "https://archive.eamana.gov.sa/TransactFileUpload/" +
          imageByArcSerial;
    }
    return imageByArcSerial;
  }

  void getdatat() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var respose = await getAction("Ens/GetApprovedOccasions/" +
        EmployeeProfile.getEmployeeNumber() +
        "/0");
    print(respose.body);
    Isload = false;
    Events = jsonDecode(respose.body)["OccasionOrderVMs"] ?? [];
    EasyLoading.dismiss();
    setState(() {});
    await Future.wait(Events.map((e) async {
      e["ee"] = await getimagepath(e["ArchiveSerial"]);
      print(Events);
    }));

    setState(() {});
    // logApiModel logapiO = logApiModel();
    // logapiO.ControllerName = "NotificationsController";
    // logapiO.ClassName = "NotificationsController";
    // logapiO.ActionMethodName = "الإشعارات";
    // logapiO.ActionMethodType = 1;
    // logapiO.StatusCode = 1;
    // logApi(logapiO);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("المناسبات", context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Isload == false && Events.length == 0
                ? Center(
                    child: Text(
                    "لايوجد مناسبات",
                    style: titleTx(baseColor),
                  ))
                : Container(
                    margin: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: Events.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             EventDetails(Events[index])),
                            //   );
                            // },
                            child: Column(
                              children: [
                                Container(
                                  height: 420,
                                  decoration:
                                      containerdecoration(BackGWhiteColor),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  child: Column(
                                    children: [
                                      buildHeader(
                                        Events[index]["EmployeeName"],
                                        Events[index]["SocialOccurredDate"]
                                            .toString()
                                            .split("T")[0],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),

                                      buildBody(
                                          Events[index]["ee"] ?? "",
                                          Events[index]["SocialTypeName"]
                                          // +
                                          //     " - " +
                                          //     Events[index]["RelativeName"]
                                          ,
                                          context),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      BuildFotter(Events[index]["OrderId"],
                                          Events[index]["SocialTypeId"]),
                                      // buildComment(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }

  Widget ee(String title, String Body, String Date, String name) {
    return ListTile(
      leading: Text(
        title,
        style: subtitleTx(baseColor),
      ),
      title: Text(
        name,
        style: descTx1(baseColor),
      ),
      subtitle: Text(Date),
      trailing: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.arrow_forward_ios,
          // color: baseColor,
        ),
      ),
    );
  }

  Widget buildComment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 45,
      child: TextField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        decoration: formlabel1("إضافة تعليق"),
        onTap: () {},
      ),
    );
  }

  Widget BuildFotter(int OrderId, int socialTypeId) {
    return Container(
      decoration: BoxDecoration(
        color: BackGColor,
        border: Border(
          top: BorderSide(color: bordercolor),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              print("qwdqw");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventComments(OrderId, socialTypeId)),
              );
            },
            child: Text(
              "شاهد جمیع التعلیقات",
              style: descTx1(baseColor),
            ),
          ),
          // OutlinedButton(
          //   onPressed: () {},
          //   style: OutlinedButton.styleFrom(
          //       backgroundColor: Colors.white,
          //       fixedSize: Size.fromWidth(70),
          //       padding: EdgeInsets.zero),
          //   child: LikeButton(
          //     size: responsiveMT(25, 40),
          //     circleColor: CircleColor(start: secondryColor, end: baseColor),
          //     bubblesColor: BubblesColor(
          //       dotPrimaryColor: secondryColor,
          //       dotSecondaryColor: baseColor,
          //     ),
          //     likeBuilder: (_isLiked) {
          //       return Icon(
          //         //_isLiked ? Icons.exposure_neg_1_outlined : Icons.plus_one, // +1 or -1
          //         Icons.plus_one,
          //         color: _isLiked ? baseColor : Colors.grey,
          //         size: responsiveMT(23, 40),
          //       );
          //     },
          //     countBuilder: (_likeCount, _isLiked, text) {
          //       return Text(
          //         text,
          //         style: subtitleTx(
          //           _isLiked ? baseColor : Colors.grey,
          //         ),
          //       );
          //     },
          //     animationDuration: Duration(milliseconds: 500),
          //     likeCountPadding: EdgeInsets.only(right: 5),
          //     onTap: (_isLiked) async {
          //       this._isLiked = !_isLiked;
          //       _likeCount += this._isLiked ? 1 : -1;

          //       Future.delayed(Duration(milliseconds: 500))
          //           .then((value) => setState(() {}));

          //       return !_isLiked;
          //     },
          //     likeCount: _likeCount,
          //     isLiked: _isLiked,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildBody(String imgpath, String typename, BuildContext context) {
    return Expanded(
      child: Container(
        // height: ,
        width: 100.w,
        color: baseColor,
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            imgpath != ""
                ? widgetsUni.viewImageNetworkEvent(imgpath, context)
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                height: 50,
                color: secondryColor.withOpacity(0.5),
                child: Center(
                    child: Text(
                  typename,
                  textAlign: TextAlign.center,
                  style: subtitleTx(Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader(String name, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // CircleAvatar(
          //   backgroundColor: baseColor,
          //   radius: responsiveMT(26, 28),
          //   child: Image.asset("assets/image/blank-profile.png"),

          //   // ClipOval(
          //   //     child: FadeInImage
          //   //         .assetNetwork(
          //   //       fit: BoxFit.cover,
          //   //       width: 50,
          //   //       height: 50,
          //   //       image: "https://archive.eamana.gov.sa/TransactFileUpload" +
          //   //           empinfo.ImageURL
          //   //                   .toString()
          //   //               .split(
          //   //                   "\$")[1],
          //   //       placeholder:
          //   //           "assets/image/avatar.jpg",
          //   //     ),
          //   //   ),
          // ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: subtitleTx(baseColor),
              ),
              Text(
                title,
                style: descTx2(secondryColorText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
