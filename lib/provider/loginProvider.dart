import 'dart:convert';
import 'dart:io';
import 'package:xml2json/xml2json.dart';
import 'package:eamanaapp/model/EmployeeProfle.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  // String Url =
  //'http://10.1.241.127/ActiveDirectoryService/ActiveDirectoryService.asmx/CheckUserForMobile';
  EmployeeProfile employeeProfile = EmployeeProfile(0, "", "", "");
  Future<bool> checkUser(String userName, String password) async {
    var APP_HEADERS = {
      HttpHeaders.authorizationHeader:
          basicAuthenticationHeader("DevTeam", "DevTeam"),
      //  HttpHeaders.contentTypeHeader: "application/json"
    };
    var response1 = await http.get(
        Uri.parse(
            "https://srv.eamana.gov.sa/Amanaapi_test/API/HR/GetEmployeeDataByEmpNo/" +
                userName),
        headers: APP_HEADERS);
    print(response1.body);
    var res = jsonDecode(response1.body);
    // print(res["EmpInfo"]);
    if (res["EmpInfo"]["EmployeeName"] == null) {
      employeeProfile.EmployeeNumber = 0;
      employeeProfile.Email = "";
      employeeProfile.FirstName = "";
      employeeProfile.EmployeeName = "";
      return false;
    } else {
      employeeProfile.EmployeeNumber =
          res["EmpInfo"]["EmployeeNumber"] as double;
      employeeProfile.Email = res["EmpInfo"]["Email"] as String;
      employeeProfile.FirstName = res["EmpInfo"]["FirstName"] as String;
      employeeProfile.EmployeeName = res["EmpInfo"]["EmployeeName"] as String;
    }

    // xml request

    var xml =
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:CheckUserForMobile><tem:username>nnabih</tem:username><tem:password>Nna-1234</tem:password><tem:Token>XMAAAsSAAALEgKHSSDNH67KBklEQVR4Xu19</tem:Token></tem:CheckUserForMobile></soapenv:Body></soapenv:Envelope>';

    var response = await http.post(
        Uri.parse(
            'https://srv.eamana.gov.sa/ActiveDirectoryService/ActiveDirectoryService.asmx'),
        headers: {
          "Content-Type": "text/xml;charset=UTF-8",
          "cache-control": "no-cache"
        },
        body: utf8.encode(xml),
        encoding: Encoding.getByName("UTF-8"));
    final Xml2Json xml2Json = Xml2Json();

    xml2Json.parse(response.body);

    var jsonString = xml2Json.toParker();

    var data = jsonDecode(jsonString);
    print(data["soap:Envelope"]["soap:Body"]["CheckUserForMobileResponse"]
        ["CheckUserForMobileResult"]);
    return data["soap:Envelope"]["soap:Body"]["CheckUserForMobileResponse"]
                ["CheckUserForMobileResult"] ==
            "true"
        ? true
        : false;
    //var checkRespose = data["soap"][""]
  }

  String basicAuthenticationHeader(String username, String password) {
    return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  }
}
