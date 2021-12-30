class TransactionHistory {
  int id;
  String transactionCreatorName;
  String transactionDate;
  String transactionDesc;
  String transactionStatus;
  TransactionHistory(this.id, this.transactionCreatorName, this.transactionDate,
      this.transactionDesc, this.transactionStatus);

  factory TransactionHistory.fromJson(dynamic json) {
    return TransactionHistory(
        json["id"] == null ? 0 : 1,
        json["transactionCreatorName"],
        json["transactionDate"] == null
            ? "2018/02/02"
            : json["transactionDate"],
        json["transactionDesc"] == null ? "معاملة2" : json["transactionDesc"],
        json["transactionStatus"] == null
            ? "غير مهم"
            : json["transactionStatus"]);
  }
}
