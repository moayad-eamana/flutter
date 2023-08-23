import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Pickattachments {
  static pickImage(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? images;

      images = await _picker.pickImage(
        source: ImageSource.camera,
        // preferredCameraDevice: CameraDevice.front,
        // imageQuality: 60,
      );
      if (images != null) {
        //  final imageTemp = File(images.path);

        var result = await FlutterImageCompress.compressAndGetFile(
          images.path,
          images.path + "compressed." + images.name.split(".").last,
          quality: 30,
        );
        File rotatedImage =
            await FlutterExifRotation.rotateImage(path: result!.path);
        var base64 = base64Encode(await rotatedImage.readAsBytes());
        int sizeInBytes = rotatedImage.lengthSync();
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

  static pickFile(List<String>? ext) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ext,
      type: FileType.custom,
    );
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
        'size': file.files[0].size,
        'base64': base64,
      };
      return res;
    }
  }
}
