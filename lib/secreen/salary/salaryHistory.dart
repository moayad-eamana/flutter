import 'package:eamanaapp/secreen/widgets/appBarHome.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';

class SalaryHistory extends StatefulWidget {
  const SalaryHistory({Key? key}) : super(key: key);

  @override
  _SalaryHistoryState createState() => _SalaryHistoryState();
}

class _SalaryHistoryState extends State<SalaryHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome.appBarW("سجل الرواتب", context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "سجل الرواتب لاخر ستة أشهر",
                      style: titleTx(baseColor),
                    ),
                    Row(
                      children: [
                        Text(
                          "الترتيب",
                          style: titleTx(secondryColorText),
                        ),
                        Icon(Icons.ac_unit)
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: containerdecoration(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
