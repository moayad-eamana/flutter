import 'dart:convert';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:eamanaapp/model/employeeInfo/EmpInfo.dart';
import 'package:flutter/foundation.dart';

class EmpInfoProvider extends ChangeNotifier {
  late List<EmpInfo> _empinfo = [];

  Future<bool> fetchEmpInfo(String name) async {
    try {
      _empinfo = [];
      notifyListeners();
      var respose = await getAction("HR/GetEmployees/" + name);

      _empinfo.clear();
      if (jsonDecode(respose.body)["EmpInfo"] != null) {
        _empinfo = (jsonDecode(respose.body)["EmpInfo"] as List)
            .map(((e) => EmpInfo.fromJson(e)))
            .toList();
      }
      print(_empinfo);
      notifyListeners();
      if (_empinfo.length == 0) {
        return false;
      }
    } catch (e) {}

    return true;
  }

  List<EmpInfo> get empinfoList {
    return List.from(_empinfo);
  }
}
