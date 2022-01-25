import 'dart:convert';
import 'package:eamanaapp/model/mahamme/HrDecisions.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

class HrDecisionsProvider extends ChangeNotifier {
  late List<HrDecisions> _hrDecisions = [];
  Future<void> fetchHrDecisions() async {
    notifyListeners();
    var respose = await getAction("GetDecisions" + "/4341012");

    _hrDecisions = (jsonDecode(respose.body)["DecisionList"] as List)
        .map(((e) => HrDecisions.fromJson(e)))
        .toList();
    notifyListeners();
  }

  List<HrDecisions> get HrDecisionsList {
    return List.from(_hrDecisions);
  }

  Future<void> PostAproveDesition(int index) async {
    var respose = await postAction(
        "ApproveDecisionRequest",
        jsonEncode({
          "BossNumber": 4341012,
          "EmplyeeNumber": _hrDecisions[index].EmplyeeNumber,
          "SignTypeID": _hrDecisions[index].SignTypeID,
          "Seq": _hrDecisions[index].Seq,
          "NewClass": _hrDecisions[index].NewClass,
          "TrnsactionTypeID": _hrDecisions[index].TrnsactionTypeID,
          "ExecutionDateH": _hrDecisions[index].ExecutionDateH,
          "ExexutionDateG": _hrDecisions[index].ExexutionDateG
        }));

    _hrDecisions.removeAt(index);
    notifyListeners();
  }
}
