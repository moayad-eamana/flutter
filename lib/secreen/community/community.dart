import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

class Community extends StatefulWidget {
  Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

//int count = 1;

class _CommunityState extends State<Community> {
  EmployeeProfile empinfo = new EmployeeProfile();

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getuserinfo();
  }

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
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: BackGColor,
        appBar: AppBarHome.appBarW("التواصل", context),
        body: Container(
          height: 100.h,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  imageBG,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Container(
                      height: 400,
                      decoration: containerdecoration(BackGWhiteColor),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Column(
                        children: [
                          buildHeader(),
                          SizedBox(
                            height: 5,
                          ),
                          buildBody("assets/image/Rectangle 238.jpg"),
                          SizedBox(
                            height: 10,
                          ),
                          BuildFotter(),
                          //buildComment(),
                        ],
                      ),
                    ),
                    Container(
                      height: 380,
                      decoration: containerdecoration(Colors.white),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          buildHeader(),
                          SizedBox(
                            height: 5,
                          ),
                          buildBody("assets/image/Rectangle 238 2.jpg"),
                          SizedBox(
                            height: 5,
                          ),

                          BuildFotter(),
                          SizedBox(
                            height: 5,
                          ),
                          //buildComment(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
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

  Widget BuildFotter() {
    return Container(
      decoration: BoxDecoration(
        color: BackGColor,
        border: Border(
          top: BorderSide(color: bordercolor),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              print("qwdqw");
              Navigator.pushNamed(context, "/comments");
            },
            child: Text(
              "شوف جمیع التعلیقات",
              style: descTx1(baseColor),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                fixedSize: Size.fromWidth(70),
                padding: EdgeInsets.zero),
            child: LikeButton(
              size: responsiveMT(25, 40),
              circleColor: CircleColor(start: secondryColor, end: baseColor),
              bubblesColor: BubblesColor(
                dotPrimaryColor: secondryColor,
                dotSecondaryColor: baseColor,
              ),
              likeBuilder: (_isLiked) {
                return Icon(
                  //_isLiked ? Icons.exposure_neg_1_outlined : Icons.plus_one, // +1 or -1
                  Icons.plus_one,
                  color: _isLiked ? baseColor : Colors.grey,
                  size: responsiveMT(23, 40),
                );
              },
              countBuilder: (_likeCount, _isLiked, text) {
                return Text(
                  text,
                  style: subtitleTx(
                    _isLiked ? baseColor : Colors.grey,
                  ),
                );
              },
              animationDuration: Duration(milliseconds: 500),
              likeCountPadding: EdgeInsets.only(right: 5),
              onTap: (_isLiked) async {
                this._isLiked = !_isLiked;
                _likeCount += this._isLiked ? 1 : -1;

                Future.delayed(Duration(milliseconds: 500))
                    .then((value) => setState(() {}));

                return !_isLiked;
              },
              likeCount: _likeCount,
              isLiked: _isLiked,
            ),
          ),
          // LikeButton(
          //   size: responsiveMT(25, 40),
          //   circleColor:
          //       CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
          //   bubblesColor: BubblesColor(
          //     dotPrimaryColor: Color(0xff33b5e5),
          //     dotSecondaryColor: Color(0xff0099cc),
          //   ),
          //   likeBuilder: (bool isLiked) {
          //     return Container();
          //   },
          //   likeCount: _likeCount,
          //   countBuilder: (_likeCount, bool isLiked, String text) {
          //     var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
          //     return Text(
          //       text,
          //       style: TextStyle(color: color),
          //     );
          //   },
          // ),
          // ElevatedButton(
          //   style: cardServiece,
          //   onPressed: () {
          //     setState(() {
          //       i++;
          //     });
          //   },
          //   child: Text("+" + i.toString(),
          //       style:
          //           TextStyle(color: baseColor, fontWeight: FontWeight.bold)),
          // ),
        ],
      ),
    );
  }

  Widget buildBody(String imgpath) {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        color: Colors.amber,
        margin: EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            Image.asset(
              imgpath,
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.maxFinite,
                height: 40,
                color: Colors.blueGrey.withOpacity(0.5),
                child: Center(
                    child: Text(
                  "حصول الادارة على شهادة الايزو",
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

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: baseColor,
            radius: responsiveMT(26, 28),
            child: empinfo.ImageURL == null || empinfo.ImageURL == ""
                ? Image.asset("assets/image/blank-profile.png")
                : ClipOval(
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://archive.eamana.gov.sa/TransactFileUpload" +
                              empinfo.ImageURL.toString().split("\$")[1],
                    ),
                  ),
            // ClipOval(
            //     child: FadeInImage
            //         .assetNetwork(
            //       fit: BoxFit.cover,
            //       width: 50,
            //       height: 50,
            //       image: "https://archive.eamana.gov.sa/TransactFileUpload" +
            //           empinfo.ImageURL
            //                   .toString()
            //               .split(
            //                   "\$")[1],
            //       placeholder:
            //           "assets/image/avatar.jpg",
            //     ),
            //   ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                "مدير إدارة التطبيقات",
                style: descTx1(baseColor),
              ),
              Text(
                "مدير إدارة التطبيقات",
                style: descTx2(secondryColorText),
              ),
            ],
          )
        ],
      ),
    );
  }
}
