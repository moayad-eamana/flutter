import 'package:cached_network_image/cached_network_image.dart';
import 'package:eamanaapp/model/employeeInfo/EmployeeProfle.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  EmployeeProfile empinfo = new EmployeeProfile();

  getuserinfo() async {
    empinfo = await empinfo.getEmployeeProfile();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getuserinfo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: "profile",
            child: empinfo.ImageURL == null
                ? Container()
                : PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                      "https://archive.eamana.gov.sa/TransactFileUpload" +
                          empinfo.ImageURL.toString().split("\$")[1],
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
  }
}
