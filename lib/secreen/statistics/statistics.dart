import 'package:eamanaapp/secreen/globalcss.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildCard("إجمالي المنصرف", "300 مليون"),
                    buildCard("إجمالي الإيرادات", "300 مليون"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildCard("إجمالي الغير محصل", "300 مليون"),
                    buildCard("إجمالي المحصل", "300 مليون"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCard(String title, String value) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Card(
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
                child: const Icon(Icons.ac_unit)),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(color: baseColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(value, style: const TextStyle(color: baseColor))
          ],
        ),
      ),
    );
  }
}
