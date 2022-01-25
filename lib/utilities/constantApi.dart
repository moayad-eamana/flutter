import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String Url = "https://srv.eamana.gov.sa/AmanaAPI_Test/API/HR/";
var APP_HEADERS = {
  HttpHeaders.authorizationHeader:
      basicAuthenticationHeader("DevTeam", "DevTeam"),
  "Content-Type": "application/json; charset=utf-8",
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
      "Access-Control-Allow-Headers,Content-Type, Access-Control-Allow-Methods, authorization, X-Requested-With"
};

String basicAuthenticationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}

dynamic getAction(String link) async {
  return await http.get(Uri.parse(Url + link), headers: APP_HEADERS);
}

dynamic postAction(String link, dynamic body) async {
  return await http.post(Uri.parse(Url + link),
      headers: APP_HEADERS, body: body);
}
