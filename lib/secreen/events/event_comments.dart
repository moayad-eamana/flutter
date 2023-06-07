import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import '../../main.dart';

class EventComments extends StatefulWidget {
  int orderId;
  int socialTypeId;
  EventComments(this.orderId, this.socialTypeId);

  @override
  State<EventComments> createState() => _EventCommentsState();
}

class _EventCommentsState extends State<EventComments> {
  List comments = [];
  List eventsCommentsList = [];
  bool Isload = true;

  TextEditingController _newComment = TextEditingController();

  @override
  void initState() {
    super.initState();
    getcomments(widget.orderId, widget.socialTypeId);
  }

  void getcomments(int orderId, int socialTypeId) async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var resposecomments = await getAction(
        "Ens/GetInteractionsWithOccasionsApp/${orderId}/${socialTypeId}");
    print(resposecomments.body);
    Isload = false;
    comments = jsonDecode(resposecomments.body)["CommentWithOccasionVMs"];
    _newComment.text = comments[0]["CommentNameArabic"];
    eventsCommentsList =
        jsonDecode(resposecomments.body)["InteractionWithOccasionVMs"] ?? [];

    print(comments);
    print(eventsCommentsList);
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("جمیع التعلیقات", context, null),
          body: Container(
            height: 100.h,
            color: BackGColor,
            child: Stack(
              children: [
                Container(
                    width: 100.w,
                    margin: EdgeInsets.only(bottom: 100, top: 20),
                    child: Isload == false && eventsCommentsList.length == 0
                        ? Center(
                            child: Text(
                            "لايوجد تعليقات",
                            style: titleTx(baseColor),
                          ))
                        : ListView.separated(
                            itemCount: eventsCommentsList.length,
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                elevation: 1,
                                color: chatColor,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: chatColor,
                                      border: Border.all(color: chatColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            eventsCommentsList[index]
                                                ["CreatedName"],
                                            style: subtitleTx(baseColorText),
                                          ),
                                          Text(
                                              eventsCommentsList[index]
                                                      ["CreatedDate"]
                                                  .toString()
                                                  .split("T")[0],
                                              style: descTx2(secondryColorText))
                                        ],
                                      ),
                                      Text(
                                          eventsCommentsList[index]
                                              ["CommentNameArabic"],
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
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  currentFocus.unfocus();
                                  Alerts.confirmAlrt(context, "رسالة تأكيد",
                                          "هل تريد إضافة تعليق ؟", "نعم")
                                      .show()
                                      .then((value) async {
                                    if (value == true) {
                                      EasyLoading.show(
                                        status: '... جاري المعالجة',
                                        maskType: EasyLoadingMaskType.black,
                                      );
                                      var reponse = await postAction(
                                          "Ens/InsertInteractionWithOccasion",
                                          jsonEncode({
                                            "OrderId": widget.orderId,
                                            "InteractionType": 1,
                                            "CommentId": comments[0]
                                                ["CommentId"],
                                            "InteractionDate":
                                                "2023-06-06T13:33:05.3014593+03:00",
                                            "UserNumber": EmployeeProfile
                                                .getEmployeeNumber()
                                          }));
                                      if (jsonDecode(
                                              reponse.body)["StatusCode"] ==
                                          400) {
                                        setState(() {
                                          eventsCommentsList.add({
                                            "CreatedName": sharedPref
                                                .getString("EmployeeName"),
                                            "CommentNameArabic":
                                                _newComment.text,
                                            "CreatedDate": "الآن"
                                          });
                                        });
                                        Alerts.successAlert(
                                                context, "", "تم إضافة تعليق")
                                            .show();
                                      } else {
                                        Alerts.errorAlert(
                                                context,
                                                "خطأ",
                                                jsonDecode(reponse.body)[
                                                    "ErrorMessage"])
                                            .show();
                                      }
                                      EasyLoading.dismiss();
                                    }
                                  });
                                },
                                child: Icon(Icons.send)),
                            // contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            labelText: "شاركنا تعليقك",
                            labelStyle: TextStyle(color: secondryColorText),

                            errorStyle: TextStyle(color: redColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: responsiveMT(8, 30),
                                horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
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
                          ),
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
