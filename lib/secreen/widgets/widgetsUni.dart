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
}
