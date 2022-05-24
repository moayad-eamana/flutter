import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Mandates_history_detailes extends StatefulWidget {
  dynamic list;
  Mandates_history_detailes(this.list);

  @override
  State<Mandates_history_detailes> createState() =>
      _Mandates_history_detailesState();
}

class _Mandates_history_detailesState extends State<Mandates_history_detailes> {
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
              Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 1,
                        color: BackGWhiteColor,
                        child: Container(
                          width: 95.w,
                          padding: EdgeInsets.all(10),
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
                                style: titleTx(secondryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Card(
                                  color: BackGWhiteColor,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "إنتداب",
                                          style: titleTx(baseColorText),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.list["MandateType"],
                                          style: subtitleTx(secondryColorText),
                                        ),
                                      ],
                                    ),
                                  ))),
                          Expanded(
                              child: Card(
                                  color: BackGWhiteColor,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "الموقع",
                                          style: titleTx(baseColorText),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.list["MandateLocation"] == ""
                                              ? "النعيرية"
                                              : widget.list["MandateLocation"],
                                          style: subtitleTx(secondryColorText),
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 1,
                        color: BackGWhiteColor,
                        child: Container(
                          width: 95.w,
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
                                widget.list["MandateDays"].toString(),
                                style: subtitleTx(secondryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Card(
                                  color: BackGWhiteColor,
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
                                  ))),
                          Expanded(
                              child: Card(
                                  color: BackGWhiteColor,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "تاريخ النهاية",
                                          style: subtitleTx(baseColorText),
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
                                  )))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 1,
                        color: BackGWhiteColor,
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
                                widget.list["MandateStatus"].toString(),
                                style: subtitleTx(secondryColorText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 1,
                        color: BackGWhiteColor,
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
