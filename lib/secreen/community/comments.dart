import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class Comments extends StatefulWidget {
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  dynamic commints = [
    {
      "name": "مؤيد العوفي",
      "des":
          "ألف مبروك ، الله يتمم علي خير باذن الله الف مبروك ، والله يتمم علي خير باذن الله",
      "time": "1h ago"
    },
    {"name": "نور الدين", "des": "ألف مبروك", "time": "1h ago"},
    {"name": "محمد آل سعيد", "des": "مبارك عليكم", "time": "1h ago"},
    {
      "name": "عبدالله آل كبيش",
      "des":
          "ألف مبروك ، الله يتمم علي خير باذن الله الف مبروك ، والله يتمم علي خير باذن الله ألف مبروك ، الله يتمم علي خير باذن الله الف مبروك ، والله يتمم علي خير باذن الله",
      "time": "1h ago"
    },
    {"name": "أنا", "des": "الله يبارك فيكم", "time": "1h ago"},
  ];
  TextEditingController _newComment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("التعليقات", context, null),
          body: Container(
            height: 100.h,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                    width: 100.w,
                    margin: EdgeInsets.only(bottom: 100, top: 20),
                    child: ListView.separated(
                      itemCount: commints.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          elevation: 1,
                          color: Color(0xffF8F8F8),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                border: Border.all(color: Color(0xffF8F8F8)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      commints[index]["name"],
                                      style: subtitleTx(baseColorText),
                                    ),
                                    Text(commints[index]["time"],
                                        style: descTx2(secondryColorText))
                                  ],
                                ),
                                Text(commints[index]["des"],
                                    style: descTx2(secondryColorText))
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.blue[50],
                    height: 100,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextField(
                          controller: _newComment,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    currentFocus.unfocus();
                                    setState(() {
                                      commints.add({
                                        "name": "مؤيد العوفي",
                                        "des": _newComment.text,
                                        "time": "just now"
                                      });
                                    });
                                  },
                                  child: Icon(Icons.send)),
                              // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              labelText: "إضافة تعليق",
                              labelStyle: TextStyle(color: secondryColorText),
                              errorStyle: TextStyle(color: redColor),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: responsiveMT(8, 30),
                                  horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: bordercolor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bordercolor),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: bordercolor),
                                borderRadius: BorderRadius.circular(25),
                              )),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
