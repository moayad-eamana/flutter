import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:sizer/sizer.dart';

class transactionDetails extends StatefulWidget {
  dynamic _transaction;
  transactionDetails(this._transaction);

  @override
  State<transactionDetails> createState() => _transactionDetailsState();
}

class _transactionDetailsState extends State<transactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("التفاصيل", context, null),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              Container(
                  width: 100.w,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CardW(
                          "تاريخ الإجراء",
                          widget._transaction["ActionDate"]
                              .toString()
                              .split("T")[0]),
                      CardW("بواسطة", widget._transaction["ByEmployeeName"]),
                      CardW("من", widget._transaction["FromStatusName"]),
                      CardW("إلى", widget._transaction["ToStatusName"]),
                      CardW("ملاحظات", widget._transaction["Notes"]),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Card CardW(String Title, String des) {
    return Card(
      child: Container(
        width: 90.w,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              Title,
              style: titleTx(baseColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              des,
              style: subtitleTx(secondryColor),
            )
          ],
        ),
      ),
    );
  }
}
