// ignore: file_names
// ignore_for_file: file_names

class TransactionInfo {
  int transactionNo;
  String transactionAddres;
  String transactionResponsible;
  String transactionCreatorName;
  String transactionPriority;
  String transactionOrederType;
  TransactionInfo(
      this.transactionNo,
      this.transactionAddres,
      this.transactionResponsible,
      this.transactionCreatorName,
      this.transactionPriority,
      this.transactionOrederType);

  factory TransactionInfo.fromJson(dynamic json) {
    return TransactionInfo(
        json["transactionNo"],
        json["transactionAddres"],
        json["transactionResponsible"],
        json["transactionCreatorName"],
        json["transactionPriority"],
        json["transactionOrederType"]);
  }
}
