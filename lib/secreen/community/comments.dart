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
  dynamic commints = ["ماشاءالله", "كفو عليك مؤيد"];
  TextEditingController _newComment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("التعليقات", context, null),
          body: Container(
            height: 100.h,
            child: Stack(
              children: [
                Image.asset(
                  imageBG,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 45),
                    width: 100.w,
                    child: ListView.separated(
                      itemCount: commints.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          widgetsUni.divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(commints[index]),
                        );
                      },
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
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
                                    setState(() {
                                      commints.add(_newComment.text);
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
