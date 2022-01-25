import 'dart:convert';
import 'package:eamanaapp/model/mahamme/HrRequests.dart';
import 'package:eamanaapp/model/mahamme/InboxHeader.dart';
import 'package:eamanaapp/model/RequestRejectReasons.dart';
import 'package:eamanaapp/utilities/constantApi.dart';
import 'package:flutter/material.dart';

class EatemadatProvider extends ChangeNotifier {
  bool isLoding = false;

  late List<InboxHeader> _inboxHeader = [];
  Future<void> getInboxHeader() async {
    isLoding = true;
    notifyListeners();

    var respose = await getAction("GetInboxHeader/4341012");
    _inboxHeader = (jsonDecode(respose.body)["HeaderList"] as List)
        .map(((e) => InboxHeader.fromJson(e)))
        .toList();

    isLoding = false;

    notifyListeners();
  }

  List<InboxHeader> get inboxHeaderList {
    return List.from(_inboxHeader);
  }

  late List<HrRequests> _hrRequestsList = [];
  Future<void> fetchHrRequests() async {
    isLoding = true;
    notifyListeners();
    var respose = await getAction("GetInboxHrRequests/4341012");
    _hrRequestsList = (jsonDecode(respose.body)["RequestList"] as List)
        .map(((e) => HrRequests.fromJson(e)))
        .toList();

    isLoding = false;
    notifyListeners();
  }

  List<HrRequests> get getHrRequests {
    return List.from(_hrRequestsList);
  }

  Future<bool> deleteEtmad(int index, bool IsRecjcted, String resondID) async {
    double id = 0;
    for (int i = 0; i < _RequestRejectReasons.length; i++) {
      if (resondID == _RequestRejectReasons[i].RejectReasonName) {
        id = _RequestRejectReasons[i].RejectReasonID;
        break;
      }
    }
    var respose = await postAction(
        "HrRequestApprove",
        jsonEncode({
          "RequesterEmployeeNumber":
              _hrRequestsList[index].RequesterEmployeeNumber,
          "RequestNumber": _hrRequestsList[index].RequestNumber,
          "IsApproved": IsRecjcted,
          "RejectReasonID": IsRecjcted ? 0.0 : id,
          "RequestTypeID": _hrRequestsList[index].RequestTypeID,
          "ApprovedBy": 4341012
        }));

    print(respose.body);
    _hrRequestsList.removeAt(index);

    notifyListeners();
    return true;
  }

  List<String> _reason = [];
  late List<RequestRejectReasons> _RequestRejectReasons;
  Future<void> fetchRejectReasonNames() async {
    var respose = await getAction("GetHrRequestRejectReasons");
    _RequestRejectReasons =
        (jsonDecode(respose.body)["RejectReasonsList"] as List)
            .map(((e) => RequestRejectReasons.fromJson(e)))
            .toList();

    for (int i = 0; i < _RequestRejectReasons.length; i++) {
      if (_RequestRejectReasons[i].RejectReasonName != "0") {
        _reason.add(_RequestRejectReasons[i].RejectReasonName);
      }
    }
  }

  List<String> get resonsSrtings {
    return _reason;
  }

  List<RequestRejectReasons> get getRequestRejectReasonsList {
    return List.from(_RequestRejectReasons);
  }
}
