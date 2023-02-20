import 'package:flutter/material.dart';

class MyEmployees extends StatefulWidget {
  const MyEmployees({Key? key}) : super(key: key);

  @override
  State<MyEmployees> createState() => _MyEmployeesState();
}

class _MyEmployeesState extends State<MyEmployees> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("noor"),
      ),
    );
  }
}
