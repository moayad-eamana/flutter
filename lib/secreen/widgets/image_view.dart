import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImage extends StatefulWidget {
  ProfileImage({required this.tag, this.path, Key? key}) : super(key: key);
  String tag;
  String? path;

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

  @override
  Widget build(BuildContext context) {
    if (widget.tag == "profile")
      return Scaffold(
        body: GestureDetector(
          child: Center(
            child: Hero(
              tag: widget.tag,
              child:
                  //  PhotoView(
                  //     imageProvider: CachedNetworkImageProvider(
                  //       "https://archive.eamana.gov.sa/TransactFileUpload" +
                  //           empinfo.ImageURL.toString().split("\$")[1],
                  //     ),
                  //   ),
                  CachedNetworkImage(
                imageUrl: "https://archive.eamana.gov.sa/TransactFileUpload" +
                    empinfo.ImageURL.toString(),
                imageBuilder: (context, imageProvider) => PhotoView(
                  imageProvider: imageProvider,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/image/blank-profile.png",
                ),
              ),
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
          onTap: () {
            Navigator.pop(context);
          },
        ),
      );
    return GestureDetector(
      child: Hero(
          tag: widget.tag,
          child: InteractiveViewer(
            child: Image.file(
              File(
                widget.path ?? "",
              ),
              fit: BoxFit.cover,
            ),
          )),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
