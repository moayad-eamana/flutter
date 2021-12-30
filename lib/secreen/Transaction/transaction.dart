import 'package:eamanaapp/provider/transactionAction.dart';
import 'package:eamanaapp/provider/transactions.dart';
import 'package:eamanaapp/secreen/Transaction/TransactionDetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<Transactions>(context);
    list.getTransactions();
    //   print(list.transactionslist[0].transactionId);
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView.builder(
                itemCount: list.transactionslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: ListTile(
                          trailing: const Icon(Icons.arrow_back_ios_new),
                          subtitle: Text(
                              list.transactionslist[index].transactionCareator),
                          title:
                              Text(list.transactionslist[index].transactionNo),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => TransactionActions(),
                                  child: TransactionDetail(
                                    id: list
                                        .transactionslist[index].transactionId,
                                    list: list,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                })));
  }
}
