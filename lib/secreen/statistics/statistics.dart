import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/SVGs/background.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
        Column(
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
                        buildCard("إجمالي المنصرف", "1.6 BN"),
                        buildCard("إجمالي الإيرادات", "107 M"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildCard("إجمالي الغير محصل", "33 M"),
                        buildCard("إجمالي المحصل", "74 M"),
                      ],
                    ),
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
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: baseColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
