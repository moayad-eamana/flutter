import 'package:flutter/material.dart';

class companyinfo extends StatefulWidget {
  const companyinfo({Key? key}) : super(key: key);

  @override
  State<companyinfo> createState() => _companyinfoState();
}

class _companyinfoState extends State<companyinfo> {
  TextEditingController edit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      key: UniqueKey(),
      children: [
        TextField(
          controller: edit,
        )
      ],
    );
  }
}
