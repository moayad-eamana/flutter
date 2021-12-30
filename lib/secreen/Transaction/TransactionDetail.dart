import 'package:eamanaapp/provider/transactionAction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TransactionDetail extends StatefulWidget {
  int? id;
  var list;
  TransactionDetail({Key? key, this.id, this.list}) : super(key: key);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<TransactionActions>(context);

    _provider.fetchTransactionInfo();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [Text("تفاصيل المعاملة")],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              actionHeder(),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 12,
                thickness: 1,
              ),
              transactionInfo(context),
              const SizedBox(
                height: 12,
              ),
              dividerText(),
              const SizedBox(
                height: 10,
              ),
              transactionHistoryView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionHeder() {
    var listOfAction = [
      {"name": "إلغاء", "icon": Icons.close_outlined},
      {"name": "إضافة ملاحظة", "icon": Icons.note},
      {"name": 'إرسال ملاحظة', "icon": Icons.send_sharp},
    ];
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          ...(listOfAction.map)(
            (e) => Expanded(
              flex: 1,
              child: SizedBox(
                height: 120,
                child: Card(
                  elevation: 5,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(e["icon"] as dynamic),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(e["name"] as String),
                    ],
                  )),
                ),
              ),
            ),
          ).toList(),
        ],
      ),
    );
  }

  Widget transactionInfo(context) {
    var _provider = Provider.of<TransactionActions>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  const Text("رقم المعاملة: "),
                  Text(_provider.TransactionInfoList[0].transactionNo
                      .toString()),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: const Divider(
                thickness: 0.8,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("العنوان : " +
                        _provider.TransactionInfoList[0].transactionAddres),
                    Text("الإسم : " +
                        _provider
                            .TransactionInfoList[0].transactionCreatorName),
                    Text("الأولوية : " +
                        _provider.TransactionInfoList[0].transactionPriority),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("المسؤول : " +
                        _provider
                            .TransactionInfoList[0].transactionResponsible),
                    Text("الأهمية : " +
                        _provider.TransactionInfoList[0].transactionOrederType),
                    const Text("")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget dividerText() {
    return Row(
      children: const [
        Expanded(
            flex: 2,
            child: Divider(
              thickness: 1,
            )),
        Expanded(flex: 3, child: Text("الملاحظات المظافة على المعاملة")),
        Expanded(
            flex: 2,
            child: Divider(
              thickness: 1,
            )),
      ],
    );
  }

  Widget transactionHistoryView(context) {
    var _provider = Provider.of<TransactionActions>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          ...(_provider.getTransactionHistory
              .map((e) => Container(
                    height: 85,
                    child: Card(
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text('المنشئ : ' + e.transactionCreatorName),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 0.3,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("التاريخ : " + e.transactionDate),
                                Text("الوصف : " + e.transactionDesc),
                                Text("الوضع الحالي : " + e.transactionStatus),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList())
        ],
      ),
    );
  }
}
