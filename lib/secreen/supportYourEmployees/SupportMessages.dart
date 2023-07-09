import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

import '../../main.dart';

class SupportMessages extends StatefulWidget {
  List list;
  List employeeNumbers;
  SupportMessages(this.list, this.employeeNumbers);

  @override
  State<SupportMessages> createState() => _SupportMessagesState();
}

class _SupportMessagesState extends State<SupportMessages> {
  @override
  void initState() {
    // TODO: implement initState
    print("object");
    print(widget.employeeNumbers);
    print(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                print(widget.list[index]);
                Alerts.confirmAlrt(
                        context,
                        "هل أانت متأكد",
                        "هل أانت متأكد من إرسال الرسالة\n" + widget.list[index],
                        'نعم')
                    .show()
                    .then((value) async {
                  if (value == true) {
                    //    widget.employeeNumbers.add(4438104);
                    EasyLoading.show(
                      status: '... جاري المعالجة',
                      maskType: EasyLoadingMaskType.black,
                    );
                    await postAction(
                        "Notifications/SendFCMNotification",
                        jsonEncode({
                          "Employees": widget.employeeNumbers,
                          "notification": {
                            "body": widget.list[index],
                            "title": sharedPref
                                    .getString("FirstName")
                                    .toString() +
                                "  " +
                                sharedPref.getString("LastName").toString() +
                                " يساندك ",
                            "image": "sample string 3"
                          },
                          "data": {
                            "module_id": "6",
                            "request_id": "0",
                            "module_name": "Support",
                            "image": "sample string 4",
                            "body": widget.list[index],
                            "title": sharedPref
                                    .getString("FirstName")
                                    .toString() +
                                "  " +
                                sharedPref.getString("LastName").toString() +
                                " يساندك "
                          },
                          "ApplicationID": 2
                        }));
                    EasyLoading.dismiss();
                  }
                });
              },
              child: Container(
                decoration: containerdecoration(BackGWhiteColor),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 60.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.list[index],
                        style: subtitleTx(baseColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.send,
                        color: baseColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
