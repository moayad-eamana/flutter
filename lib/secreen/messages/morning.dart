import 'dart:typed_data';

import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';

class morning extends StatefulWidget {
  @override
  State<morning> createState() => _morningState();
}

class _morningState extends State<morning> {
  dynamic args;
  Uint8List? bytes;
  @override
  void initState() {
    // TODO: implement initState

    getimg();
    super.initState();
  }

  getimg() async {
    EasyLoading.show(
      status: '... جاري المعالجة',
      maskType: EasyLoadingMaskType.black,
    );
    Future.delayed(Duration.zero).then((value) async {
      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(args["url"].toString())).load("");
      bytes = imageData.buffer.asUint8List();
      setState(() {});
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("رسالة الصباح", context, null),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Image.asset(
                imageBG,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                color: BackGWhiteColor,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          // child: Text(
                          //   args["title"],
                          //   style: titleTx(baseColorText),
                          // ),
                          ),
                      Center(
                        child: Text(
                          args["body"],
                          style: titleTx(secondryColor),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      bytes == null
                          ? Container()
                          : Image.memory(bytes as Uint8List),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
