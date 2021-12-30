import 'dart:convert';

import 'package:eamanaapp/model/transactions.dart';
import 'package:flutter/cupertino.dart';

class Transactions extends ChangeNotifier {
  var _trans_list =
      '[{"transactionId":1,"transactionNo":"المعاملة الاولى","transactionCareator":"مؤيد "},{"transactionId":2,"transactionNo":"المعاملة الثانية","transactionCareator":"نور الدين"}]';
  late List<Transaction> trans = [];
  Future<void> getTransactions() async {
    var list = jsonDecode(_trans_list) as List;
    trans = list.map((e) => Transaction.fromJson(e)).toList();
  }

  List<Transaction> get transactionslist {
    return List.from(trans);
  }

  late Transaction filtredTras;
  Future<void> transactionByid(int? id) async {
    filtredTras = trans.firstWhere((element) => element.transactionId == id);
    filtredTras;
  }

  Transaction get hhh {
    return filtredTras;
  }
}
