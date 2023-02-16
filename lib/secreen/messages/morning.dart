import 'dart:typed_data';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/EmpInfo/Empprofile.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

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
      try {
        final ByteData imageData =
            await NetworkAssetBundle(Uri.parse(args["url"]["image"].toString()))
                .load("");
        bytes = imageData.buffer.asUint8List();
      } catch (e) {}

      setState(() {});
      EasyLoading.dismiss();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(args["url"]["title"].toString(), context, null),
        body: Stack(
          children: [
            widgetsUni.bacgroundimage(),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                color: BackGWhiteColor,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      bytes == null
                          ? Container()
                          : Image.memory(bytes as Uint8List),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Linkify(
                          onOpen: (link) async {
                            try {
                              if (!await launch(link.url)) {
                                throw 'Could not launch ';
                              }
                            } catch (e) {}
                          },
                          text: args["url"]["body"].toString(),
                          style: titleTx(secondryColor),
                          linkStyle: titleTx(baseColor),
                        ),
                      ),
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
