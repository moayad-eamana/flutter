import 'dart:convert';
import 'dart:io';
import 'package:eamanaapp/model/violation/vaiolation.dart';
import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:eamanaapp/secreen/widgets/image_view.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eamanaapp/secreen/widgets/widgetsUni.dart';

class attachment extends StatefulWidget {
  attachment({required this.back, required this.vaiolationModel, Key? key})
      : super(key: key);
  Function back;
  VaiolationModel vaiolationModel;

  @override
  State<attachment> createState() => _attachmentState();
}

class _attachmentState extends State<attachment>
    with AutomaticKeepAliveClientMixin {
  // Pick an image
  final ImagePicker _picker = ImagePicker();
  List listofimage = [];
  List<XFile>? images;
  XFile? photo;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                Row(
                  children: [
                    widgetsUni.actionbutton("رجوع", Icons.next_plan, () {
                      widget.back();
                    }),
                  ],
                ),
                Text(
                  "إضافة المرفقات",
                  style: titleTx(baseColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
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
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: const Icon(Icons.image),
                        color: baseColor,
                        onPressed: () async {
                          //from gallary
                          images = await _picker.pickMultiImage(
                            imageQuality: 100,
                            maxHeight: 1440,
                            maxWidth: 1440,
                          );
                          print(images);
                          if (images != null) {
                            for (int i = 0; i < images!.length; i++) {
                              final imageTemp = File(images![i].path);
                              var base64 =
                                  base64Encode(await imageTemp.readAsBytes());
                              int sizeInBytes = imageTemp.lengthSync();
                              double sizeInMb = sizeInBytes / (1024 * 1024);
                              print(sizeInMb);
                              listofimage.add({
                                'path': images![i].path,
                                'type': images![i].name.split(".").last,
                                'name': images![i].name,
                                'base64': base64,
                                'size': sizeInMb
                              });
                            }

                            setState(() {});
                          } else {
                            return;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 70,
                      width: 70,
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
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: const Icon(Icons.camera_alt),
                        color: baseColor,
                        onPressed: () async {
                          // Capture a photo
                          photo = await _picker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 1440,
                            maxWidth: 1440,
                          );
                          print(photo);
                          if (photo == null) return;
                          final imageTemp = File(photo!.path);
                          var base64 =
                              base64Encode(await imageTemp.readAsBytes());
                          int sizeInBytes = imageTemp.lengthSync();
                          double sizeInMb = sizeInBytes / (1024 * 1024);
                          print(sizeInMb);
                          print(base64);
                          setState(() {
                            listofimage.add({
                              'path': photo!.path,
                              'type': photo!.name.split(".").last,
                              'name': photo!.name,
                              'base64': base64,
                              'size': sizeInMb
                            });
                          });
                          // print(listofimage[0]);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 70,
                      width: 70,
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
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: const Icon(Icons.picture_as_pdf),
                        color: baseColor,
                        onPressed: () async {
                          //pdf
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );

                          if (result != null) {
                            for (int i = 0; i < result.count; i++) {
                              PlatformFile file = result.files[i];
                              final imageTemp = File(file.path!);
                              var base64 =
                                  base64Encode(await imageTemp.readAsBytes());
                              int sizeInBytes = imageTemp.lengthSync();
                              double sizeInMb = sizeInBytes / (1024 * 1024);
                              print(sizeInMb);
                              if (sizeInMb <= 5) {
                                listofimage.add({
                                  'path': file.path,
                                  'type': file.extension,
                                  'name': file.name,
                                  'base64': base64,
                                  'size': sizeInMb
                                });
                              } else {
                                Alerts.errorAlert(context, "خطأ",
                                        "يجب ان يكون حجم الملف اقل من 5 ميجا")
                                    .show();
                              }

                              print(listofimage);
                            }

                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (listofimage.isNotEmpty)
                  Text(
                    "عرض المرفقات",
                    style: titleTx(baseColor),
                  ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            mainAxisExtent: 100,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    primary: false,
                    itemCount: listofimage.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
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
                            child: listofimage[index]['type'] != 'pdf'
                                ? GestureDetector(
                                    child: Hero(
                                        tag: listofimage[index]['name'],
                                        child: Image.file(
                                          File(
                                            listofimage[index]['path'],
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return ProfileImage(
                                          tag: listofimage[index]['name'],
                                          path: listofimage[index]['path'],
                                        );
                                      }));
                                    })
                                : Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          icon:
                                              const Icon(Icons.picture_as_pdf),
                                          color: baseColor,
                                          onPressed: () async {},
                                        ),
                                        Text(
                                          listofimage[index]['name'],
                                          maxLines: 1,
                                          style: descTx2(baseColorText),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: const Icon(Icons.close_rounded),
                              color: redColor,
                              onPressed: () async {
                                setState(() {
                                  listofimage.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widgetsUni.actionbutton("إرسال", Icons.send, () {
                      if (listofimage.isNotEmpty) {
                        //post json to api
                        widget.vaiolationModel.individualUserInfoModel
                            .settestdata();
                      } else {
                        Alerts.errorAlert(context, "خطأ", "الرجاء إضافة مرفقات")
                            .show();
                      }
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    widgetsUni.actionbutton("حفظ", Icons.save, () {
                      if (listofimage.isNotEmpty) {
                        //post json to api
                      } else {
                        Alerts.errorAlert(context, "خطأ", "الرجاء إضافة مرفقات")
                            .show();
                      }
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    widgetsUni.actionbutton("إالغاء", Icons.cancel, () {
                      Alerts.confirmAlrt(context, "خروج",
                              "هل تريد الخروج النظام المخالفات", "نعم")
                          .show()
                          .then((value) async {
                        if (value == true) {
                          Navigator.pop(context);
                        }
                      });
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
