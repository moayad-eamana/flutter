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
}
