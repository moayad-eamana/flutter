import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImage extends StatefulWidget {
  ProfileImage({required this.tag, this.path, this.link, Key? key})
      : super(key: key);
  String tag;
  String? path;
  String? link;
  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  EmployeeProfile empinfo = new EmployeeProfile();

  @override
  void initState() {
    empinfo = empinfo.getEmployeeProfile();
    super.initState();
    //  WidgetsBinding.instance?.addPostFrameCallback((_) => getuserinfo());
  }

  final transformationController = TransformationController();
  @override
  Widget build(BuildContext context) {
    if (widget.tag == "profile" || widget.link == "car")
      return SafeArea(
        child: Scaffold(
          body: GestureDetector(
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                        ),
                        //   Text("رجوع")
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Hero(
                    tag: widget.tag,
                    child:
                        //  PhotoView(
                        //     imageProvider: CachedNetworkImageProvider(
                        //       "https://archive.eamana.gov.sa/TransactFileUpload" +
                        //           empinfo.ImageURL.toString().split("\$")[1],
                        //     ),
                        //   ),

                        widget.tag == "profile"
                            ? CachedNetworkImage(
                                imageUrl:
                                    "https://archive.eamana.gov.sa/TransactFileUpload" +
                                        empinfo.ImageURL.toString(),
                                imageBuilder: (context, imageProvider) =>
                                    PhotoView(
                                  imageProvider: imageProvider,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/image/blank-profile.png",
                                ),
                              )
                            : Image.network(widget.path.toString()),
                    //  FadeInImage.assetNetwork(
                    //     fit: BoxFit.cover,
                    //     // width: 100,
                    //     // height: 100,
                    //     image: "https://archive.eamana.gov.sa/TransactFileUpload" +
                    //         empinfo.ImageURL.toString().split("\$")[1],
                    //     placeholder: "",
                    //   ),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarW.appBarW("عرض المرفقات", context, null),
        body: GestureDetector(
          child: Hero(
              tag: widget.tag,
              child: Center(
                child: InteractiveViewer(
                  alignPanAxis: true,
                  child: Image.file(
                    File(
                      widget.path ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
