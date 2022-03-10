import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class widgetsUni {
  static Divider divider() {
    return Divider(
      thickness: 0.5,
      color: baseColor,
    );
  }

  static Column cardcontentService(String icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          //color: Colors.white,
          width: responsiveMT(42, 48),
        ),
        // Icon(
        //   icon,
        //   size: SizerUtil.deviceType == DeviceType.mobile ? 30 : 35,
        //   color: baseColor,
        // ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            title,
            //maxLines: 1,
            textAlign: TextAlign.center,
            style: descTx1(baseColor),
          ),
        )
      ],
    );
  }

  static Widget servicebutton(
      String text, String icon, VoidCallback onClicked) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: responsiveMT(60, 120),
      width: responsiveMT(140, 280),
      child: ElevatedButton(
        style: cardServiece,
        onPressed: () {
          onClicked();
        },
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              //color: Colors.white,
              width: responsiveMT(42, 48),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: descTx1(baseColorText),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget servicebutton2(
      String text, String icon, VoidCallback onClicked) {
    return ElevatedButton(
        style: cardServiece,
        onPressed: onClicked,
        child: widgetsUni.cardcontentService(icon, text));
  }

  static Widget actionbutton(String text, icon, VoidCallback onClicked) {
    return ElevatedButton(
      style: cardServiece,
      onPressed: () {
        onClicked();
      },
      child: Row(
        children: [
          Icon(icon, color: secondryColor, size: 18),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: descTx1(baseColorText),
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
