import 'dart:convert';
import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:eamanaapp/utilities/dropDownCss.dart';

class SecondVisit extends StatefulWidget {
  dynamic vehicle;
  SecondVisit(this.vehicle);

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
  TextEditingController _Note = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  getLocation() async {
    var response = await getAction("ViolatedCars/GetLocations");
    location = jsonDecode(response.body)["data"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                    CardsAttachment("السيارة عند التأشير", 0, 763),
                    CardsAttachment("السيارة عند الرفع", 1, 764),
                    CardsAttachment("المحضر", 2, 765)
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            isNoticeproceed(),
            SizedBox(
              height: 15,
            ),
            if (no == true) dropDownLocation(),
            SizedBox(
              height: 15,
            ),
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
            Row(
              children: [
                Expanded(
                    child: widgetsUni.actionbutton("إرسال", Icons.send, () {
                  send();
                })),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: widgetsUni.actionbutton(
                        "إلغاء البلاغ", Icons.close, () {})),
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
  Widget CardsAttachment(String caption, int index, int docTypeID) {
    return Column(
      children: [
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
                    onTap: () {
                      BottomSheet(index, docTypeID);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(child: Text("صورة")),
                    ),
                  )
                ],
              )
            : InkWell(
                onTap: () {
                  BottomSheet(index, docTypeID);
                },
                child: Image.file(
                  File(images[index]["path"]),
                  width: 100,
                  height: 100,
                ),
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
                Container(
                  width: 100.w,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      images[indx] =
                          await Pickattachments.pickImage(ImageSource.gallery);
                      Ataachment[indx]["FileBytes"] = images[indx]["base64"];
                      Ataachment[indx]["FileName"] = images[indx]["name"];
                      Ataachment[indx]["FilePath"] = images[indx]["path"];
                      Ataachment[indx]["DocTypeName"] = images[indx]["type"];
                      Ataachment[indx]["DocTypeID"] = docTypeID;
                      setState(() {});
                    },
                    child: Text("الاستديو"),
                  ),
                ),
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
        print(Location_X);
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
      Alerts.confirmAlrt(context, "", "هل أنت متأكد من إرسال الطلب", "نعم")
          .show()
          .then((value) async {
        if (value == true) {
          EasyLoading.show(
            status: '... جاري المعالجة',
            maskType: EasyLoadingMaskType.black,
          );

          var response = await postAction(
              "ViolatedCars/InsertVisit",
              jsonEncode({
                "EmplpyeeNumber":
                    int.parse(EmployeeProfile.getEmployeeNumber()),
                "RequestNumber": widget.vehicle["RequestID"],
                "Notes": _Note.text,
                "IsProcessed": yes ? 1 : 0,
                "LocationID": locationID,
                "VisiID": 2,
                "Attachements": Ataachment
              }));

          if (jsonDecode(response.body)["StatusCode"] == 400) {
            var response2 = await postAction(
                "Inbox/UpdateViolatedVehiclesRequestStatus",
                jsonEncode({
                  "RequestNumber": widget.vehicle["RequestID"],
                  "Notes": "",
                  "NewStatusID": 4,
                  "EmployeeNumber":
                      int.parse(EmployeeProfile.getEmployeeNumber()),
                }));
            EasyLoading.dismiss();

            if (jsonDecode(response2.body)["StatusCode"] == 400) {
              Alerts.successAlert(context, "", "تم الارسال")
                  .show()
                  .then((value) {
                Navigator.pop(context);
              });
            } else {
              Alerts.errorAlert(
                      context, "", jsonDecode(response2.body)["ErrorMessage"])
                  .show();
              return;
            }
          } else {
            EasyLoading.dismiss();
            Alerts.errorAlert(context, "خطأ",
                    jsonDecode(response.body)["ErrorMessage"].toString())
                .show();
            return;
          }
        }
      });
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
}
