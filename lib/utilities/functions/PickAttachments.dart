import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eamanaapp/secreen/widgets/alerts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Pickattachments {
  static pickImage(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? images;

      images = await _picker.pickImage(
        source: source,
        // preferredCameraDevice: CameraDevice.front,
        // imageQuality: 60,
      );
      if (images != null) {
        final imageTemp = File(images.path);

        // var result = await FlutterImageCompress.compressAndGetFile(
        //   images.path,
        //   images.path + "compressed" + images.name.split(".").last,
        //   quality: 30,
        // );
        File rotatedImage =
            await FlutterExifRotation.rotateImage(path: imageTemp!.path);
        var base64 = base64Encode(await rotatedImage.readAsBytes());
        int sizeInBytes = imageTemp.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        print(sizeInMb);
        var res = {
          'path': images.path,
          'type': images.name.split(".").last,
          'name': images.name,
          'base64': base64,
          'size': sizeInMb
        };
        return res;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static PickMultiImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images;
    List res = [];
    images = await _picker.pickMultiImage(
        //   imageQuality: 30,
        );
    print(images);
    print(images);
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        final imageTemp = File(images[i].path);
        var base64 = base64Encode(await imageTemp.readAsBytes());
        int sizeInBytes = imageTemp.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        res.add({
          'path': images[i].path,
          'type': images[i].name.split(".").last,
          'name': images[i].name,
          'base64': base64,
          'size': sizeInMb
        });
      }

      return res;
    }
  }

  static pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    dynamic file;
    if (result != null) {
      file = result;
    }

    if (file != null) {
      final filTemp = await File(file.files[0].path);
      var base64 = base64Encode(await filTemp.readAsBytes());
      var res = {
        'path': file.files[0].path,
        'type': file.files[0].extension,
        'name': file.files[0].name,
        'base64': base64,
      };
      return res;
    }
  }
}
