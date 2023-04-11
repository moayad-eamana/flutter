import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool yes = false;
  bool no = false;
  List location = [];
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
                    CardsAttachment("السيارة عند التأشير", 0),
                    CardsAttachment("السيارة عند الرفع", 1),
                    CardsAttachment("المحضر", 2)
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
            dropDownLocation(),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: 3,
              style: TextStyle(color: baseColorText),
              decoration: formlabel1("ملاحظات"),
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
  Widget CardsAttachment(String caption, int index) {
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
                      BottomSheet(index);
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
                  BottomSheet(index);
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

  BottomSheet(int indx) {
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
          dropDownCss.popupItemBuilder(rr["MunicipalityName"].toString()),
      dropdownBuilder: (context, selectedItem) => Container(
        decoration: null,
        child: selectedItem == null
            ? null
            : Text(
                selectedItem == null
                    ? ""
                    : selectedItem["MunicipalityName"] ?? "",
                style: TextStyle(fontSize: 16, color: baseColorText)),
      ),
      dropdownBuilderSupportsNullItem: true,
      mode: Mode.BOTTOM_SHEET,
      maxHeight: 400,
      showAsSuffixIcons: true,
      dropdownSearchDecoration: formlabel1("اختر الموقع"),
      validator: (value) {
        if (value == "" || value == null) {
          return "الرجاء إختيار الموعد";
        } else {
          return null;
        }
      },
      showSearchBox: true,
      onChanged: (v) async {},
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
}
