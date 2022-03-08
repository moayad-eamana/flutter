import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Alerts {
  static Alert successAlert(BuildContext context, String title, String desc) {
    return Alert(
      context: context,
      type: AlertType.success,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            "حسنا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        ),
      ],
    );
  }

  static Alert warningAlert(BuildContext context, String title, String desc) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            "حسنا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        ),
      ],
    );
  }

  static Alert errorAlert(BuildContext context, String title, String desc) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: const Text(
            "حسنا",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    );
  }

  static Alert confirmAlrt(
      BuildContext context, String title, String desc, String confirmMsg) {
    return Alert(
      style: AlertStyle(
        isCloseButton: false,
        backgroundColor: BackGWhiteColor,
        titleStyle: titleTx(baseColorText),
        descStyle: descTx1(baseColorText),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: bordercolor,
          ),
        ),
      ),
      context: context,
      //type: AlertType.warning,
      // title: title,
      // desc: desc,
      content: Column(
        children: [
          Icon(
            Icons.warning_rounded,
            size: 100,
            color: Colors.yellow.shade800,
          ),
          Text(
            title,
            style: titleTx(baseColorText),
          ),
          Text(
            desc,
            style: descTx1(baseColorText),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: baseColor,
          child: Text(
            confirmMsg,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context, true);
          },
          width: 120,
        ),
        DialogButton(
          color: baseColor,
          child: const Text(
            "إلغاء",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
          width: 120,
        )
      ],
    );
  }
}
