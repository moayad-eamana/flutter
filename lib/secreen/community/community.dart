import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Community extends StatefulWidget {
  Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
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
                      height: 380,
                      decoration: containerdecoration(Colors.white),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          buildHeader(),
                          SizedBox(
                            height: 5,
                          ),
                          buildBody(),
                          SizedBox(
                            height: 5,
                          ),
                          BuildFotter(),
                          SizedBox(
                            height: 5,
                          ),
                          buildComment(),
                        ],
                      ),
                    ),
                    Container(
                      height: 380,
                      decoration: containerdecoration(Colors.white),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          buildHeader(),
                          SizedBox(
                            height: 5,
                          ),
                          buildBody(),
                          SizedBox(
                            height: 5,
                          ),
                          BuildFotter(),
                          SizedBox(
                            height: 5,
                          ),
                          buildComment(),
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
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "إضافة تعليق",
            style: descTx1(baseColor),
          ),
          ElevatedButton(
            style: cardServiece,
            onPressed: () {
              setState(() {
                i++;
              });
            },
            child: Text("+" + i.toString(),
                style:
                    TextStyle(color: baseColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Container(
        width: double.maxFinite,
        color: Colors.amber,
        child: Stack(
          children: [
            Image.asset(
              "assets/SVGs/appstore.png",
              fit: BoxFit.fill,
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
                  style: subtitleTx(baseColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        CircleAvatar(
            backgroundColor: baseColor,
            radius: responsiveMT(26, 28),
            child: Image.asset("assets/image/avatar.jpg")),
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
    );
  }
}
