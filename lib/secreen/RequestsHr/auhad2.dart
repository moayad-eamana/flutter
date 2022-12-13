import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';

class Auhad2 extends StatefulWidget {
  const Auhad2({Key? key}) : super(key: key);

  @override
  State<Auhad2> createState() => _AuhadState();
}

class _AuhadState extends State<Auhad2> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("العهد", context, null),
      ),
    );
  }
}
