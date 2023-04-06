import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:url_launcher/url_launcher.dart';

class ViolatedVehicle extends StatefulWidget {
  dynamic vehicle;
  ViolatedVehicle(this.vehicle);
  @override
  State<ViolatedVehicle> createState() => _ViolatedVehicleState();
}

class _ViolatedVehicleState extends State<ViolatedVehicle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            cards("هوية المالك",
                widget.vehicle["VehicleUserIdNumber"].toString()),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("رقم الطلب", widget.vehicle["RequestID"].toString()),
            cards("تاريخ الطلب",
                widget.vehicle["RequestDate"].toString().split("T")[0]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("رقم اللوحة", widget.vehicle["PlateNumber"].toString()),
            cards(
                "الحروف",
                widget.vehicle["Letter1"] +
                    widget.vehicle["Letter2"] +
                    widget.vehicle["Letter3"]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("نوع السيارة", widget.vehicle["VehicleType"]),
            cards("السيارة", widget.vehicle["VehicleModel"]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards("موديل السيارة", widget.vehicle["VehicleYear"].toString()),
            cards("اللون", widget.vehicle["VehicleColor"]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            cards(
                "المنطقة",
                widget.vehicle["MuniciplaityName"] +
                    ' - ' +
                    widget.vehicle["DistrictName"]),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widgetsUni.actionbutton('عرض الموقع', Icons.map, () async {
                if (await launchUrl(
                  Uri.parse(
                      "https://www.google.com/maps/search/?api=1&query=${widget.vehicle["Coordinates_X"]},${widget.vehicle["Coordinates_y"]}"),
                  mode: LaunchMode.externalApplication,
                )) {
                } else {
                  await launchUrl(
                    Uri.parse(
                        "https://www.google.com/maps/search/?api=1&query=${widget.vehicle["Coordinates_X"]},${widget.vehicle["Coordinates_y"]}"),
                  );
                }
              }),
              widgetsUni.actionbutton('عرض المرفقات', Icons.attach_file, () {}),
            ],
          ),
        )
      ],
    );
  }

  Widget cards(String title, String desc) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            child: Container(
          decoration: containerdecoration(BackGWhiteColor),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: subtitleTx(secondryColorText),
              ),
              Text(desc, style: subtitleTx(baseColorText)),
            ],
          ),
        )),
      ),
    );
  }
}
