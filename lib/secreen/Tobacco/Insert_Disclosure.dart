import 'dart:convert';
import 'dart:io';

import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/utilities/functions/PickAttachments.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/styles/CSS.dart';
import 'package:eamanaapp/utilities/styles/CSS/fontsStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Insert_Disclosure extends StatefulWidget {
  Insert_Disclosure();

  @override
  State<Insert_Disclosure> createState() => _Insert_DisclosureState();
}

class _Insert_DisclosureState extends State<Insert_Disclosure> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController LicenseNo = TextEditingController();
  TextEditingController ShopNo = TextEditingController();
  TextEditingController DisclosureDate = TextEditingController();
  TextEditingController Disclosureamount = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    await getAction("Tobaco/GetLicenceInfo?LicenseNumber=3909247302");
  }

  dynamic images;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBarW.appBarW("التبغ", context, null),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "رقم الرخصه",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: LicenseNo,
                      decoration: CSS.TextFieldDecoration('رقم الرخصة'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الرخصة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "رقم المنشأة",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: ShopNo,
                      decoration: CSS.TextFieldDecoration('رقم المنشأة'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم المنشأة';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "تاريخ الإفصاح",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //vacation day textform field
                    TextFormField(
                      controller: DisclosureDate,
                      decoration: CSS.TextFieldDecoration('تاريخ الإفصاح'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      maxLines: 1,
                      onTap: () async {
                        dynamic dd = await showMonthPicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2040),
                          locale: Locale("ar"),
                          initialDate: DateTime.now(),
                        );
                        DisclosureDate.text = dd.toString().split(" ")[0];
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال تاريخ الإفصاح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "المبلغ",
                      style: fontsStyle.px14(
                          fontsStyle.thirdColor(), FontWeight.bold),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: Disclosureamount,
                      decoration: CSS.TextFieldDecoration('المبلغ'),
                      style: fontsStyle.px14(Colors.grey, FontWeight.normal),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,6}'))
                      ],
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال المبلغ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    images == null
                        ? Stack(
                            fit: StackFit.loose,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //print("object");
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Placeholder(
                                    color: secondryColorText,
                                    strokeWidth: 0.4,
                                    fallbackHeight: 100,
                                    fallbackWidth: 100,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  images = await Pickattachments.pickImage(
                                      ImageSource.gallery);
                                  // Ataachment[index]["FileBytes"] =
                                  //     images[index]["base64"];
                                  // Ataachment[index]["FileName"] =
                                  //     images[index]["name"];
                                  // Ataachment[index]["FilePath"] =
                                  //     images[index]["path"];
                                  // Ataachment[index]["DocTypeName"] =
                                  //     images[index]["type"];
                                  // Ataachment[index]["DocTypeID"] = docTypeID;
                                  if (images == null || images == false) {
                                    images = null;
                                  }
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
                              images = await Pickattachments.pickImage(
                                  ImageSource.gallery);
                              // Ataachment[index]["FileBytes"] =
                              //     images[index]["base64"];
                              // Ataachment[index]["FileName"] =
                              //     images[index]["name"];
                              // Ataachment[index]["FilePath"] =
                              //     images[index]["path"];
                              // Ataachment[index]["DocTypeName"] =
                              //     images[index]["type"];
                              // Ataachment[index]["DocTypeID"] = docTypeID;
                              if (images == null || images == false) {
                                images = null;
                              }
                              setState(() {});
                            },
                            child: Image.file(
                              File(images["path"]),
                              width: 100,
                              height: 100,
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CSS.baseElevatedButton("إرسال", 200, () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (images == null) {
                          Alerts.errorAlert(context, "خطأ", 'يجب ادراج مرفق')
                              .show();
                          return;
                        }
                        EasyLoading.show(
                          status: '... جاري المعالجة',
                          maskType: EasyLoadingMaskType.black,
                        );
                        var response = await postAction(
                            "Tobaco/InsertTobacoRequest",
                            jsonEncode({
                              "EmployeeNumber":
                                  EmployeeProfile.getEmployeeNumber(),
                              "MunicpalityID": 1,
                              "LicenseNumber": int.parse(LicenseNo.text),
                              "Amount": int.parse(Disclosureamount.text),
                              "Month":
                                  int.parse(DisclosureDate.text.split('-')[0]),
                              "Year":
                                  int.parse(DisclosureDate.text.split('-')[1]),
                              "Attaches": [
                                {
                                  "FileBytes": images["base64"],
                                  "FileName": images["name"]
                                },
                              ]
                            }));
                        EasyLoading.dismiss();
                        if (jsonDecode(response.body)["StatusCode"] == 400) {
                          Alerts.successAlert(context, "", "تم الحفظ")
                              .show()
                              .then((value) {
                            Get.back();
                          });
                        } else {
                          Alerts.errorAlert(context, "خطأ",
                                  jsonDecode(response.body)["ErrorMessage"])
                              .show();
                        }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
