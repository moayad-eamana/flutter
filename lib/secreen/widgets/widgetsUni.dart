import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class widgetsUni {
  static Divider divider() {
    return Divider(
      thickness: 0.5,
      color: baseColor,
    );
  }

  static Column cardcontentService(icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: SizerUtil.deviceType == DeviceType.mobile ? 30 : 35,
          color: baseColor,
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: descTx1(baseColor),
          ),
        )
      ],
    );
  }

  static Widget servicebutton(String text, icon, VoidCallback onClicked) {
    return Container(
      height: 60,
      width: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
          style: cardServiece,
          onPressed: () {
            onClicked();
          },
          child: Row(
            children: [
              Icon(icon, color: baseColor, size: 40),
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
      ),
    );
  }
}
