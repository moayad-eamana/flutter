import 'dart:convert';

import 'package:eamanaapp/model/transactionInfo.dart';
import 'package:eamanaapp/model/transactionhistory.dart';
import 'package:flutter/cupertino.dart';

class TransactionActions extends ChangeNotifier {
  late List<TransactionInfo> TransactionInfoList;
  late List<TransactionHistory> transactionHistorylist;
  var _dumyJson =
      '[{"transactionNo":25552,"transactionAddres": "الخبر","transactionResponsible": "مؤيد","transactionCreatorName": "نور","transactionPriority": "مهم","transactionOrederType": "عاجل" } ]';

  var _dumyJson2 =
      '[{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"},{"id":0,"transactionCreatorName":"مؤيد","transactionDate":"2018/01/01","transactionDesc":"معاملة","transactionStatus":"مهم"}]';
  Future<void> fetchTransactionInfo() async {
    TransactionInfoList = (jsonDecode(_dumyJson) as List)
        .map((e) => TransactionInfo.fromJson(e))
        .toList();

    transactionHistorylist = (jsonDecode(_dumyJson2) as List)
        .map((e) => TransactionHistory.fromJson(e))
        .toList();
  }

  List<TransactionInfo> get getTransactionActions {
    return List.from(TransactionInfoList);
  }

  List<TransactionHistory> get getTransactionHistory {
    return List.from(transactionHistorylist);
  }
}
