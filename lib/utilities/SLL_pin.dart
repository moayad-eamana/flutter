import 'package:http_certificate_pinning/http_certificate_pinning.dart';

Future checkSSL(String url) async {
  try {
    final secure = await HttpCertificatePinning.check(
        serverURL: url,
        headerHttp: {"method": "GET"},
        sha: SHA.SHA256,
        allowedSHAFingerprints: [
          "D8 5F 6F 65 23 0F 41 A4 9B FB 62 63 FD F6 AE 75 8F 08 B0 52 5F 36 9E 19 DB 3D AC 8D 19 CE E6 CA"
        ],
        timeout: 50);

    if (secure.contains("CONNECTION_SECURE")) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
