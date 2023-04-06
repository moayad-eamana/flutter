import 'dart:io';

import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import 'image_view.dart';

class widgetsUni {
  static Divider divider() {
    return Divider(
      thickness: 0.5,
      color: baseColor,
    );
  }

  static bacgroundimage() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Opacity(
        opacity: 1,
        child: Image.asset(
          imageBG,
          fit: BoxFit.fill,
          //   height: 100.h,
        ),
      ),
    );
  }

  static Column cardcontentService(String icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          //color: Colors.white,
          width: responsiveMT(50, 48),
        ),
        // Icon(
        //   icon,
        //   size: SizerUtil.deviceType == DeviceType.mobile ? 30 : 35,
        //   color: baseColor,
        // ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            title,
            //maxLines: 1,
            textAlign: TextAlign.center,
            style: descTx1(baseColorText),
          ),
        )
      ],
    );
  }

  static Widget servicebutton(
      String text, String icon, VoidCallback onClicked) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: responsiveMT(60, 120),
      width: responsiveMT(140, 280),
      child: ElevatedButton(
        style: cardServiece,
        onPressed: () {
          onClicked();
        },
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              //color: Colors.white,
              width: responsiveMT(42, 48),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: descTx1(baseColorText),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget servicebutton2(
      String text, String icon, VoidCallback onClicked) {
    return ElevatedButton(
        style: cardServiece,
        onPressed: onClicked,
        child: widgetsUni.cardcontentService(icon, text));
  }

  static Widget actionbutton(String text, icon, VoidCallback onClicked) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide(
          width: 0.5,
          color: bordercolor,
        ),
        elevation: 0,
        primary: baseColor,
      ),
      onPressed: () {
        onClicked();
      },
      child: Row(
        children: [
          Icon(icon, color: BackGWhiteColor, size: 18),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: descTx1(BackGWhiteColor),
            maxLines: 2,
          )
        ],
      ),
    );
  }

  static imgeview(dynamic data, BuildContext context, Function delete) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Container(
            height: 100,
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
            child: data['type'] != 'pdf'
                ? GestureDetector(
                    child: Hero(
                        tag: data['name'],
                        child: Image.file(
                          File(
                            data['path'],
                          ),
                          width: 100.w,
                          fit: BoxFit.cover,
                        )),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ProfileImage(
                          tag: data['name'],
                          path: data['path'],
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: const Icon(Icons.picture_as_pdf),
                          color: baseColor,
                          onPressed: () async {},
                        ),
                        Text(
                          data['name'],
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
              iconSize: 30,
              onPressed: () {
                delete();
              },
            ),
          ),
        ],
      ),
    );
  }

  static viewImageNetwork(String link, BuildContext context) {
    return GestureDetector(
        child: Hero(
          tag: link,
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
            child: Image.network(link),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ProfileImage(
              tag: link,
              path: link,
              link: "car",
            );
          }));
        });
  }
}
