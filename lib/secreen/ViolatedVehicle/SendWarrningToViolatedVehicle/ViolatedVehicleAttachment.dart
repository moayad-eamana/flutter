import 'dart:convert';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/model/logApiModel.dart';
import 'package:eamanaapp/secreen/ViolatedVehicle/SendWarrningToViolatedVehicle/WarnViolatedVehiclePageView.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/functions/determinePosition.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViolatedVehicleAttachment extends StatefulWidget {
  ViolatedVehicle violatedVehicle;
  Function back;
  ViolatedVehicleAttachment(this.violatedVehicle, this.back);

  @override
  State<ViolatedVehicleAttachment> createState() =>
      _ViolatedVehicleAttachmentState();
}

class _ViolatedVehicleAttachmentState extends State<ViolatedVehicleAttachment> {
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                // Card(ImageSource.gallery, "الاستديو"),
                // SizedBox(
                //   width: 20,
                // ),
                Card(ImageSource.camera, "الكاميرا"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            !widget.violatedVehicle.AttachementsInfo.isEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.violatedVehicle.AttachementsInfo.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5.0),
                    itemBuilder: (BuildContext context, int index) {
                      return widgetsUni.imgeview(
                          widget.violatedVehicle.AttachementsInfo[index],
                          context, () {
                        widget.violatedVehicle.AttachementsInfo.removeAt(index);
                        (widget.violatedVehicle.sendwarning["VisitRequest"]
                                ["Attachements"])
                            .removeAt(index);

                        setState(() {});
                      });
                    },
                  )
                : Container(),
            widget.violatedVehicle.AttachementsInfo.isNotEmpty
                ? SizedBox(
                    width: 95,
                    child:
                        widgetsUni.actionbutton("إنذار", Icons.send, () async {
                      print(widget.violatedVehicle);
                      EasyLoading.show(
                        status: '... جاري المعالجة',
                        maskType: EasyLoadingMaskType.black,
                      );

                      dynamic location = await checkloaction();
                      if (location == false) {
                        EasyLoading.dismiss();
                        return;
                      }

                      EasyLoading.dismiss();
                      Alerts.confirmAlrt(
                              context,
                              "",
                              " سوف يتم أخذ الموقع الحالي وإرسال الإنذار للسيارة برقم " +
                                  widget.violatedVehicle
                                      .sendwarning["PlateNumber"]
                                      .toString(),
                              "نعم")
                          .show()
                          .then((value) async {
                        if (value == true) {
                          // widget.violatedVehicle.sendwarning["VisitRequest"]
                          //     ["Attachements"] = [];
                          // widget.violatedVehicle.sendwarning["StatusID"] = 1;
                          // widget.violatedVehicle.sendwarning["SerialNumber"] =
                          //     5;

                          EasyLoading.show(
                            status: '... جاري المعالجة',
                            maskType: EasyLoadingMaskType.black,
                          );
                          var reponse = await postAction(
                              "ViolatedCars/InsertViolationRequest",
                              jsonEncode(widget.violatedVehicle.sendwarning));
                          logApiModel logapiO = logApiModel();
                          logapiO.ControllerName = "ViolatedVehicle";
                          logapiO.ClassName = "ViolatedVehicle";
                          logapiO.EmployeeNumber =
                              int.parse(EmployeeProfile.getEmployeeNumber());
                          logapiO.ActionMethodName = "إنذار سيارة";
                          logapiO.ActionMethodType = 2;
                          if (jsonDecode(reponse.body)["StatusCode"] == 400) {
                            logapiO.StatusCode = 1;
                            logApi(logapiO);
                            Alerts.successAlert(
                                    context,
                                    "",
                                    "تم إرسال الانذار برقم " +
                                        " " +
                                        jsonDecode(
                                                reponse.body)["RequestNumber"]
                                            .toString())
                                .show()
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else {
                            logapiO.StatusCode = 0;
                            logapiO.ErrorMessage =
                                jsonDecode(reponse.body)["ErrorMessage"];
                            logApi(logapiO);
                            Alerts.errorAlert(context, "خطأ",
                                    jsonDecode(reponse.body)["ErrorMessage"])
                                .show();
                          }
                          EasyLoading.dismiss();
                        }
                      });
                    }))
                : Container(),
            SizedBox(
                width: 95,
                child: widgetsUni.actionbutton("الرجوع", Icons.arrow_back, () {
                  widget.back();
                })),
          ],
        ),
      ),
    );
  }

  Card(ImageSource source, String title) {
    return GestureDetector(
      onTap: () async {
        if (title == "الاستديو") {
          addmulti_image();
        } else {
          fromCamera();
        }
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: BackGWhiteColor,
          border: Border.all(
            color: bordercolor,
          ),
          //color: baseColor,
          borderRadius: BorderRadius.all(
            new Radius.circular(4),
          ),
        ),
        child: Column(
          children: [
            IconButton(
              //      padding: EdgeInsets.zero,
              // constraints: BoxConstraints(),
              icon: const Icon(Icons.image),
              color: baseColor,
              iconSize: 40,
              onPressed: () async {
                if (title == "الاستديو") {
                  addmulti_image();
                } else {
                  fromCamera();
                }
              },
            ),
            Text(
              title,
              style: descTx1(baseColorText),
            )
          ],
        ),
      ),
    );
  }

  addmulti_image() async {
    List? a = [];
    a = await Pickattachments.PickMultiImage();
    if (a != null) {
      for (int i = 0; i < a.length; i++) {
        widget.violatedVehicle.AttachementsInfo.add(a[i]);
        (widget.violatedVehicle.sendwarning["VisitRequest"]["Attachements"])
            .add({
          "FileBytes": a[i]["base64"],
          "FileName": a[i]["name"],
          "DocTypeID": 762
        });
      }
      setState(() {});
    }
  }

  fromCamera() async {
    //from gallary
    dynamic a;
    a = await Pickattachments.pickImage(ImageSource.camera);

    if (a != null) {
      widget.violatedVehicle.AttachementsInfo.add(a);
      //   widget.violatedVehicle.sendwarning["VisitRequest"]["Attachements"].add(a);
      (widget.violatedVehicle.sendwarning["VisitRequest"]["Attachements"]).add(
          {"FileBytes": a["base64"], "FileName": a["name"], "DocTypeID": 762});
      setState(() {});
    }
  }

  checkloaction() async {
    dynamic loaction = await DeterminePosition.determinePosition();

    if (loaction == false) {
      EasyLoading.dismiss();
      Alerts.confirmAlrt(context, "تنبيه", "يرجى تشغيل موقع", "إعدادات")
          .show()
          .then((value) async {
        if (value == true) {
          Geolocator.openLocationSettings();
        }
      });

      return loaction;
    } else {
      widget.violatedVehicle.sendwarning["Coordinates_X"] = loaction.latitude;
      widget.violatedVehicle.sendwarning["Coordinates_y"] = loaction.longitude;
      return loaction;
    }
  }
}
