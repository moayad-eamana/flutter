import 'dart:io';

import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class Alerts {
  static Alert successAlert(BuildContext context, String title, String desc) {
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
      // type: AlertType.success,
      // title: title,
      // desc: desc,
      content: Column(
        children: [
          Icon(
            Icons.done,
            size: 100,
            color: Colors.green.shade800,
          ),
          Text(
            title,
            style: titleTx(baseColorText),
          ),
          Text(
            desc,
            style: descTx1(baseColorText),
            //textAlign: TextAlign.center,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
          child: const Text(
            "إغلاق",
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
      content: Column(
        children: [
          Icon(
            Icons.warning,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
      context: context,
      // type: AlertType.warning,
      // title: title,
      // desc: desc,
      buttons: [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
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
      content: Column(
        children: [
          Icon(
            Icons.error,
            size: 100,
            color: Colors.red.shade800,
          ),
          Text(
            title,
            style: titleTx(baseColorText),
          ),
          Text(
            desc,
            style: descTx1(baseColorText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      context: context,
      // type: AlertType.error,
      // title: title,
      // desc: desc,
      buttons: [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
          child: const Text(
            "إغلاق",
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
            Icons.warning,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(4)),
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
          radius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
          child: const Text(
            "إغلاق",
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

  static Alert update(BuildContext context, String title, String desc) {
    return Alert(
      style: AlertStyle(
        isCloseButton: true,
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
      //    onWillPopActive: true,
      content: Container(
        child: Column(
          children: [
            Icon(
              Icons.warning,
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      context: context,
      // type: AlertType.warning,
      // title: title,
      // desc: desc,
      buttons: [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(4)),
          color: baseColor,
          child: const Text(
            "تحديث",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (Platform.isAndroid) {
              launch("https://play.google.com/apps/internaltest/4701378476454016517")
                  .then((value) => {});
            } else {
              launch("https://testflight.apple.com/join/NCmeNY0Q")
                  .then((value) => {print("edkjhflkjhwelfkJH")});
            }
          },
          width: 120,
        ),
      ],
    );
  }

  static _showMyDialog(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
