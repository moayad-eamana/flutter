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
      context: context,
      type: AlertType.warning,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
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
