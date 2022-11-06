import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:flutter/material.dart';

class privacypolicy extends StatefulWidget {
  const privacypolicy({Key? key}) : super(key: key);

  @override
  State<privacypolicy> createState() => _privacypolicyState();
}

class _privacypolicyState extends State<privacypolicy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Your privacy comes first"),
          widgetsUni.actionbutton("Accept and contunue", Icons.approval, () {})
        ],
      ),
    );
  }
}
