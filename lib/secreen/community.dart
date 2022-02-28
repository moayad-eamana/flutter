import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarHome.appBarW("التواصل", context),
        body: SingleChildScrollView(
          child: Container(),
        ),
      ),
    );
  }
}
