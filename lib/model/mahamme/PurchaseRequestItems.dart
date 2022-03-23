class PurchaseRequestItems {
  int RequestNumber;
  int RequiredQuantity;
  String ItemName;
  String ItemCode;
  int StockAvaliableQuantity;
  int StockAcceptedQuantity;
  int StockPurchsedQuantity;
  String UnitDescription;
  PurchaseRequestItems(
      this.RequestNumber,
      this.RequiredQuantity,
      this.ItemName,
      this.ItemCode,
      this.StockAvaliableQuantity,
      this.StockAcceptedQuantity,
      this.StockPurchsedQuantity,
      this.UnitDescription);

  factory PurchaseRequestItems.fromJson(dynamic json) {
    return PurchaseRequestItems(
      json["RequestNumber"],
      json["RequiredQuantity"],
      json["ItemName"],
      json["ItemCode"],
      json["StockAvaliableQuantity"],
      json["StockAcceptedQuantity"],
      json["StockPurchsedQuantity"],
      json["UnitDescription"],
    );
  }
}
