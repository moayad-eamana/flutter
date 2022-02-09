import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ViewFile {
  static open(String base64File, String extention) async {
    Uint8List bytes = base64.decode(base64File);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/" +
        DateTime.now().millisecondsSinceEpoch.toString() +
        "." +
        extention);
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  }
}
