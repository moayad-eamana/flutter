class RequestRejectReasons {
  double RejectReasonID;
  String RejectReasonName;
  RequestRejectReasons(this.RejectReasonID, this.RejectReasonName);
  factory RequestRejectReasons.fromJson(dynamic json) {
    return RequestRejectReasons(
      json["RejectReasonID"],
      json["RejectReasonName"],
    );
  }
}
