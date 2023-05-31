import 'dart:convert';

import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  dynamic eventdetails;
  EventDetails(this.eventdetails);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  // dynamic eventdetails;
  String imageByArcSerial = "";
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
      var respose = await getAction("Ens/GetOccationAttachments/" +
          widget.eventdetails["ArchiveSerial"].toString());
      print(respose.body);
      respose = jsonDecode(respose.body);
      if (respose["StatusCode"] == 400) {
        respose = respose["data"];
        print(respose[respose.length - 1]["FilePath"]);
        imageByArcSerial = respose[respose.length - 4]["FilePath"];
        print(imageByArcSerial);
        setState(() {});
      } else {
        //   //Alerts.warningAlert(context, "رسالة", "لا توجد بيانات").show();
      }

      setState(() {});
      EasyLoading.dismiss();
    });
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    // widget.eventdetails = ModalRoute.of(context)!.settings.arguments;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW(
            widget.eventdetails["RelativeName"].toString(), context, null),
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
                      imageByArcSerial != ""
                          ? widgetsUni.viewImageNetwork(
                              "https://archive.eamana.gov.sa/TransactFileUpload/" +
                                  imageByArcSerial.toString(),
                              context)
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SelectableLinkify(
                          onOpen: (link) async {
                            try {
                              if (!await launch(link.url)) {
                                throw 'Could not launch ';
                              }
                            } catch (e) {}
                          },
                          text:
                              widget.eventdetails["SocialPostText"].toString(),
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
