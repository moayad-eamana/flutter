import 'dart:convert';

import 'package:eamanaapp/secreen/ViolatedVehicle/ViewViolatedVehicle/transactionDetails.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class transactions extends StatefulWidget {
  int requestID;
  transactions(this.requestID);
  @override
  State<transactions> createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {
  List _transactions = [];
  @override
  void initState() {
    // TODO: implement initState
    getData();

    super.initState();
  }

  getData() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    var response = await getAction(
        "ViolatedCars/GetRequestTransactions/" + widget.requestID.toString());
    if (jsonDecode(response.body)["StatusCode"] == 400) {
      _transactions = jsonDecode(response.body)["data"];
      setState(() {});
    }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("سجل الطلب", context, null),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              widgetsUni.bacgroundimage(),
              Container(
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    transactionDetails(_transactions[index])),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            leading: Text(
                              (index + 1).toString(),
                              style: titleTx(baseColorText),
                            ),
                            subtitle: Text(
                              _transactions[index]["ToStatusName"],
                              maxLines: 3,
                              style: descTx1(baseColor),
                            ),
                            title: Text(
                              _transactions[index]["ActionDate"]
                                  .toString()
                                  .split("T")[0],
                              style: subtitleTx(baseColorText),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
