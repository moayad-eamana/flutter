import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class widgetsUni {
  static Divider divider() {
    return Divider(
      thickness: 0.5,
      color: Colors.deepPurpleAccent,
    );
  }

  static Column cardcontentService(icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: SizerUtil.deviceType == DeviceType.mobile ? 25 : 35,
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: SizerUtil.deviceType == DeviceType.mobile ? 13 : 18,
            ),
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
              Icon(
                Icons.calendar_today,
                color: baseColor,
                size: 30.sp,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
