import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Pickattachments {
  static pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? images;
    images = await _picker.pickImage(
      source: source,
      imageQuality: 100,
    );
    if (images != null) {
      final imageTemp = File(images!.path);
      var base64 = base64Encode(await imageTemp.readAsBytes());
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
    }
  }

  static PickMultiImage() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images;
    List res = [];
    images = await _picker.pickMultiImage(
      imageQuality: 100,
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
}
