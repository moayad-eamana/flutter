import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

getAttachment(int archSeiral) async {
  dynamic path;
  EasyLoading.show(
    status: '... جاري المعالجة',
    maskType: EasyLoadingMaskType.black,
  );
  var headers = {
    'Content-Type': 'text/xml',
    'Cookie': 'cookiesession1=678B28B36718B06CD19AAAD934ACDF5C'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://archive.eamana.gov.sa/UploadService/UploadService.asmx?op=GetDocuments'));
  request.body =
      '''<?xml version="1.0" encoding="utf-8"?>\r\n<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">\r\n  <soap:Body>\r\n    <GetDocuments xmlns="http://tempuri.org/">\r\n      <arcSerial>${archSeiral}</arcSerial>\r\n    </GetDocuments>\r\n  </soap:Body>\r\n</soap:Envelope>''';
  request.headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());

    dynamic xml = await response.stream.bytesToString();

    // print(xml);

    final myTransformer = Xml2Json();

    myTransformer.parse(xml);

    dynamic jsondata = myTransformer.toGData();

    jsondata = jsonDecode(jsondata);

    // print(jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
    //     ["GetDocumentsResult"]["Attachments"][0]["FilePath"]["\$t"]);

    path = jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
        ["GetDocumentsResult"]["Attachments"][0]["FilePath"]["\$t"];

    path = "https://archive.eamana.gov.sa/TransactFileUpload/" + path;
    EasyLoading.dismiss();
    return path;
    // print(jsondata["soap\$Envelope"]["soap\$Body"]["GetDocumentsResponse"]
    //     ["GetDocumentsResult"]["Attachments"]);

  } else {
    EasyLoading.dismiss();
    print(response.reasonPhrase);
  }
  EasyLoading.dismiss();
}
