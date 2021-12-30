class Transaction {
  int transactionId;
  String transactionNo;
  String transactionCareator;

  Transaction(this.transactionNo, this.transactionCareator, this.transactionId);

  factory Transaction.fromJson(dynamic json) {
    return Transaction(json["transactionNo"], json["transactionCareator"],
        json["transactionId"]);
  }
}
