import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/provider/ViolatedVehicle/SecondVisitP.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/utilities/dropDownCss.dart';

class SecondVisit extends StatefulWidget {
  int typeid;
  dynamic vehicle;
  List imagesss = [];
  SecondVisit(this.vehicle, this.imagesss, this.typeid);

  @override
  State<SecondVisit> createState() => _SecondVisitState();
}

class _SecondVisitState extends State<SecondVisit> {
  final _formKey1 = GlobalKey<FormState>();
  List images = [null, null, null];

  List Ataachment = [{}, {}, {}];
  bool yes = false;
  bool no = false;
  List location = [];
  double? Location_X;
  double? Location_Y;
  int? locationID;
  String? LocationName;
  List path = [];
  TextEditingController _Note = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    getLocation();
    filtterimages();
    if (widget.vehicle["StatusID"] >= 4) {
      _Note.text = widget.vehicle["Visits"][1]["Notes"];
      LocationName = widget.vehicle["Visits"][1]["Location"];
      setState(() {});
    }
    super.initState();
  }

  filtterimages() {
    path = widget.imagesss
        .where((element) =>
            element["DocTypeID"] == 763 ||
            element["DocTypeID"] == 764 ||
            element["DocTypeID"] == 765)
        .toList();

    setState(() {});
    //  print(widget.images);
  }

  getLocation() async {
    var response = await getAction("ViolatedCars/GetLocations");
    location = jsonDecode(response.body)["data"];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    path = widget.imagesss
        .where((element) =>
            element["DocTypeID"] == 763 ||
            element["DocTypeID"] == 764 ||
            element["DocTypeID"] == 765)
        .toList();
    return Form(
      key: _formKey1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "المرفقات",
                  style: subtitleTx(baseColor),
                ),
                widgetsUni.divider(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardsAttachment("السيارة عند التأشير", 0, 763,
                        path.length > 0 ? path[2]["FilePath"] : ""),
                    CardsAttachment("السيارة عند الرفع", 1, 764,
                        path.length > 0 ? path[1]["FilePath"] : ""),
                    CardsAttachment("المحضر", 2, 765,
                        path.length > 0 ? path[0]["FilePath"] : "")
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),

            if (findDiffDays() > 7 &&
                widget.vehicle["StatusID"] == 3 &&
                widget.typeid != -1)
              isNoticeproceed(),
            SizedBox(
              height: 15,
            ),
            // show location if the car still in the location
            if (no == true && widget.vehicle["StatusID"] == 3)
              dropDownLocation(),
            if (no == true && widget.vehicle["StatusID"] == 3)
              SizedBox(
                height: 15,
              ),
            if (widget.vehicle["StatusID"] > 3)
              TextFormField(
                enabled: false,
                controller: TextEditingController(
                    text: widget.vehicle["Visits"][1]["Location"]),
                style: TextStyle(color: baseColorText),
                decoration: formlabel1("الموقع"),
              ),

            if (widget.vehicle["StatusID"] > 3)
              SizedBox(
                height: 15,
              ),
            TextFormField(
              controller: _Note,
              maxLines: 3,
              style: TextStyle(color: baseColorText),
              decoration: formlabel1("ملاحظات"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "الرجاء إدخال الملاحظات";
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            // show button Actions
            if (widget.vehicle["StatusID"] == 3 && widget.typeid != -1)
              Row(
                children: [
                  if (findDiffDays() > 7)
                    Expanded(
                        child: widgetsUni.actionbutton("إرسال", Icons.send, () {
                      send();
                    })),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: widgetsUni
                          .actionbutton('إلغاء الطلب', Icons.forward, () async {
                    SecondVisitP.cancelRequest(
                        context, widget.vehicle["RequestID"]);
                  })),
                ],
              ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

// pick images
  Widget CardsAttachment(
      String caption, int index, int docTypeID, String link) {
    return Column(
      children: [
        if (widget.vehicle["StatusID"] == 3)
          images[index] == null
              ? Stack(
                  fit: StackFit.loose,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //print("object");
                      },
                      child: Placeholder(
                        color: secondryColorText,
                        strokeWidth: 0.4,
                        fallbackHeight: 100,
                        fallbackWidth: 100,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        images[index] =
                            await Pickattachments.pickImage(ImageSource.camera);
                        Ataachment[index]["FileBytes"] =
                            images[index]["base64"];
                        Ataachment[index]["FileName"] = images[index]["name"];
                        Ataachment[index]["FilePath"] = images[index]["path"];
                        Ataachment[index]["DocTypeName"] =
                            images[index]["type"];
                        Ataachment[index]["DocTypeID"] = docTypeID;
                        setState(() {});
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Center(child: Text("صورة")),
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () async {
                    images[index] =
                        await Pickattachments.pickImage(ImageSource.camera);
                    Ataachment[index]["FileBytes"] = images[index]["base64"];
                    Ataachment[index]["FileName"] = images[index]["name"];
                    Ataachment[index]["FilePath"] = images[index]["path"];
                    Ataachment[index]["DocTypeName"] = images[index]["type"];
                    Ataachment[index]["DocTypeID"] = docTypeID;
                    setState(() {});
                  },
                  child: Image.file(
                    File(images[index]["path"]),
                    width: 100,
                    height: 100,
                  ),
                ),
        if (widget.vehicle["StatusID"] > 3 && link != "")
          Container(
            width: 100,
            height: 100,
            child: widgetsUni.viewImageNetwork(
                "https://archive.eamana.gov.sa/TransactFileUpload/" + link,
                context),
          ),
        Text(
          caption,
          style: descTx1(baseColorText),
        )
      ],
    );
  }

  BottomSheet(int indx, int docTypeID) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          //  color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 100.w,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      images[indx] =
                          await Pickattachments.pickImage(ImageSource.camera);
                      Ataachment[indx]["FileBytes"] = images[indx]["base64"];
                      Ataachment[indx]["FileName"] = images[indx]["name"];
                      Ataachment[indx]["FilePath"] = images[indx]["path"];
                      Ataachment[indx]["DocTypeName"] = images[indx]["type"];
                      Ataachment[indx]["DocTypeID"] = docTypeID;
                      setState(() {});
                    },
                    child: Text("الكاميرا"),
                  ),
                ),
                // Container(
                //   width: 100.w,
                //   child: TextButton(
                //     onPressed: () async {
                //       Navigator.pop(context);
                //       images[indx] =
                //           await Pickattachments.pickImage(ImageSource.gallery);
                //       Ataachment[indx]["FileBytes"] = images[indx]["base64"];
                //       Ataachment[indx]["FileName"] = images[indx]["name"];
                //       Ataachment[indx]["FilePath"] = images[indx]["path"];
                //       Ataachment[indx]["DocTypeName"] = images[indx]["type"];
                //       Ataachment[indx]["DocTypeID"] = docTypeID;
                //       setState(() {});
                //     },
                //     child: Text("الاستديو"),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget isNoticeproceed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "هل تم معالجة البلاغ",
          style: subtitleTx(baseColor),
        ),
        Row(
          children: [
            Checkbox(
              value: yes,
              onChanged: (bool? value) {
                yes = value ?? true;
                no = false;
                setState(() {});
              },
            ),
            Text("نعم"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: no,
              onChanged: (bool? value) {
                no = value ?? true;
                yes = false;
                setState(() {});
              },
            ),
            Text("لا"),
          ],
        ),
      ],
    );
  }

  Widget dropDownLocation() {
    return DropdownSearch<dynamic>(
      items: location,
      popupBackgroundColor: BackGWhiteColor,
      popupItemBuilder: (context, rr, isSelected) =>
          dropDownCss.popupItemBuilder(rr["LocationName"].toString()),
      dropdownBuilder: (context, selectedItem) => Container(
        decoration: null,
        child: selectedItem == null
            ? null
            : Text(
                selectedItem == null ? "" : selectedItem["LocationName"] ?? "",
                style: TextStyle(fontSize: 16, color: baseColorText)),
      ),
      dropdownBuilderSupportsNullItem: true,
      mode: Mode.BOTTOM_SHEET,
      maxHeight: 400,
      showAsSuffixIcons: true,
      dropdownSearchDecoration: formlabel1("اختر الموقع"),
      validator: (value) {
        if (value == "" || value == null) {
          return "الرجاء إختيار الموقع";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (v) async {
        Location_X = v["Location_X"];
        Location_Y = v["Location_Y"];
        locationID = v["LocationID"];
        print(v);
      },
      popupTitle: dropDownCss.popupTitle("الموقع"),
      popupShape: dropDownCss.popupShape(),
      emptyBuilder: (context, searchEntry) => Center(
        child: Text(
          "لا يوجد بيانات",
          style: TextStyle(
            color: baseColorText,
          ),
        ),
      ),
      searchFieldProps: dropDownCss.searchFieldProps(),
      clearButton: dropDownCss.clearButton(),
      dropDownButton: dropDownCss.dropDownButton(),
    );
  }

  send() async {
    var res = valdation();
    if (res != false) {
      SecondVisitP.sendSecondVisit(context, widget.vehicle["RequestID"],
          _Note.text, yes, locationID, Ataachment);
    }
  }

  valdation() {
    if (images.contains(null)) {
      Alerts.errorAlert(context, "خطأ", "يجب إرفاق الصور").show();
      return false;
    }
    if (yes == false && no == false) {
      Alerts.errorAlert(context, "خطأ", "يجب إختيار معالجة البلاغ").show();
      return false;
    }
    if (!_formKey1.currentState!.validate()) {
      return false;
    }
  }

  findDiffDays() {
    DateTime dt = DateTime.parse(widget.vehicle["RequestDate"]);
    final date2 = DateTime.now();
    final difference = date2.difference(dt).inDays;
    return difference;
  }
}
