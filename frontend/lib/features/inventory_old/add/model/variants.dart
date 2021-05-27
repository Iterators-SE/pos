class Variant {
  String variantName = "initial";
  int variantPrice = 0;
  int variantQuantity = 0;

  Variant({this.variantName, this.variantPrice, this.variantQuantity});

  String get name => variantName;
  int get quantity => variantQuantity;
  int get price => variantPrice;
}
