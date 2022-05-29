import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class OfferDetails extends StatefulWidget {
  dynamic offer;
  OfferDetails(this.offer);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  Widget build(BuildContext context) {
    print(widget.offer);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("تفاصل العرض", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CompanyName(),
                        StartAndEndDAte(),
                        OfferName(),
                        CompanyNotes(),
                        Respresentiveinfo(),
                        SizedBox(
                          height: 10,
                        ),
                        ViewPF(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CompanyName() {
    return Card(
        child: Container(
      color: BackGWhiteColor,
      width: 100.w,
      padding: EdgeInsets.all(10),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: -5,
            child: Container(
              height: 40,
              width: 110,
              decoration: containerdecoration(baseColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "خصم",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.offer["DiscoutRatio"].toString() + "%",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  "إسم الشركة",
                  style: titleTx(baseColorText),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.offer["CompanyName"],
                  style: subtitleTx(secondryColorText),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget StartAndEndDAte() {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Container(
              color: BackGWhiteColor,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "بداية العرض",
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.offer["OfferStartDate"].toString().split("T")[0],
                    style: subtitleTx(secondryColorText),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              color: BackGWhiteColor,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    "نهاية العرض",
                    style: titleTx(baseColorText),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.offer["OfferExpiryDate"].toString().split("T")[0],
                    style: subtitleTx(secondryColorText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Respresentiveinfo() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "ممثل الشركة",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.offer["RepresentiveName"],
              style: titleTx(secondryColorText),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launch("https://wa.me/" +
                        widget.offer["RespresentiveMobileNo"] +
                        "/");
                  },
                  child: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: secondryColor,
                    size: 24.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("tel://" + widget.offer["RespresentiveMobileNo"]);
                  },
                  child: Icon(
                    Icons.phone_outlined,
                    color: secondryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launch("mailto:" + widget.offer["CompanyEmail"]);
                  },
                  child: Icon(
                    Icons.email_outlined,
                    color: secondryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget OfferName() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "نبذة عن العرض",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.offer["OfferName"],
                style: subtitleTx(secondryColorText),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CompanyNotes() {
    return Card(
      child: Container(
        color: BackGWhiteColor,
        padding: EdgeInsets.all(10),
        width: 100.w,
        child: Column(
          children: [
            Text(
              "ملاحظات",
              style: titleTx(baseColorText),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.offer["CompanyNotes"],
                  style: subtitleTx(secondryColorText),
                  textAlign: TextAlign.justify),
            )
          ],
        ),
      ),
    );
  }

  Widget ViewPF() {
    return Container(
      width: 150,
      height: 50,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(
              width: 0.5,
              color: bordercolor,
            ),
            elevation: 0,
            primary: baseColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("عرض المرفق"),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.picture_as_pdf,
              )
            ],
          )),
    );
  }
}
