import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OutDuties_history_detailes extends StatefulWidget {
  dynamic list;
  OutDuties_history_detailes(this.list);

  @override
  State<OutDuties_history_detailes> createState() =>
      _OutDuties_history_detailesState();
}

class _OutDuties_history_detailesState
    extends State<OutDuties_history_detailes> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("التفاصيل", context, null),
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Image.asset(
                  imageBG,
                  fit: BoxFit.fill,
                ),
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
                          // color: BackGWhiteColor,
                          child: Column(
                            children: [
                              Text(
                                "رقم الطلب",
                                style: titleTx(baseColorText),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.list["RequestNumber"]
                                    .toString()
                                    .split(".")[0],
                                style: subtitleTx(secondryColorText),
                              ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.list["OutDutyDays"]
                                          .toString()
                                          .split(".")[0],
                                      style: subtitleTx(secondryColorText),
                                    ),
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
                                      "عدد الساعات",
                                      style: titleTx(baseColorText),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.list["OutDutyHours"].toString(),
                                      style: subtitleTx(secondryColorText),
                                    ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.list["StartDateG"]
                                          .toString()
                                          .split("T")[0],
                                      style: subtitleTx(secondryColorText),
                                    ),
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
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.list["EndDateG"]
                                          .toString()
                                          .split("T")[0],
                                      style: subtitleTx(secondryColorText),
                                    ),
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
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.list["RequestStatus"].toString(),
                                style: subtitleTx(secondryColorText),
                              ),
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
                                "ملاحظة",
                                style: titleTx(baseColorText),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.list["Notes"].toString().trim() == ""
                                    ? "لايوجد ملاحظة"
                                    : widget.list["Notes"].toString().trim(),
                                style: subtitleTx(secondryColorText),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
