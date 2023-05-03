import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';

class transactions extends StatefulWidget {
  @override
  State<transactions> createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {
  @override
  void initState() {
    // TODO: implement initState
    getAction("ViolatedCars/GetRequestTransactions/4");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
