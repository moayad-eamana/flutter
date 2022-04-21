import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';

class vacation_history_request_datiels extends StatefulWidget {
  dynamic list;
  vacation_history_request_datiels(this.list);

  @override
  State<vacation_history_request_datiels> createState() =>
      _vacation_history_request_datielsState();
}

class _vacation_history_request_datielsState
    extends State<vacation_history_request_datiels> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("التفاصيل", context, null),
        body: Stack(
          children: [
            Image.asset(
              imageBG,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Card(
                      color: BackGWhiteColor,
                      elevation: 1,
                      child: Container(
                        width: 95.w,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "نوع الإجازة",
                              style: titleTx(baseColor),
                            ),
                            SizedBox(height: 5),
                            Text(widget.list["VacationType"].toString(),
                                style: titleTx(secondryColorText)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: BackGWhiteColor,
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "عدد الأيام",
                                    style: titleTx(baseColorText),
                                  ),
                                  SizedBox(height: 5),
                                  Text(widget.list["VacationDays"].toString(),
                                      style: titleTx(secondryColorText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: BackGWhiteColor,
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "رقم الطلب",
                                    style: titleTx(baseColorText),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      widget.list["RequestNumber"]
                                          .toString()
                                          .split(".")[0],
                                      style: titleTx(secondryColorText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: BackGWhiteColor,
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "تاريخ البداية",
                                    style: titleTx(baseColorText),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      widget.list["StartDateG"]
                                          .toString()
                                          .split("T")[0],
                                      style: titleTx(secondryColorText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: BackGWhiteColor,
                            elevation: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    "تاريخ النهاية",
                                    style: titleTx(baseColorText),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                      widget.list["EndDateG"]
                                          .toString()
                                          .split("T")[0],
                                      style: titleTx(secondryColorText)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: BackGWhiteColor,
                      elevation: 1,
                      child: Container(
                        width: 95.w,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "حالة الطلب",
                              style: titleTx(baseColorText),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.list["Status"],
                              style: subtitleTx(secondryColorText),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: BackGWhiteColor,
                      elevation: 1,
                      child: Container(
                        width: 95.w,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "الموظف البديل",
                              style: titleTx(baseColorText),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.list["ReplaceEmployeeName"],
                              style: subtitleTx(secondryColorText),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: BackGWhiteColor,
                      elevation: 1,
                      child: Container(
                        width: 95.w,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "الملاحظات",
                              style: titleTx(baseColorText),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.list["Notes"].toString().trim() == ""
                                  ? "لايوجد ملاحظات"
                                  : widget.list["Notes"].toString().trim(),
                              style: subtitleTx(secondryColorText),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
