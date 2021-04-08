class ProductVariant{
  int variantid;
  String variantName;
  int quantity;
  int productID;
  int price;

  ProductVariant({
    this.variantid, 
    this.variantName, 
    this.quantity, 
    this.productID, 
    this.price});
    ProductVariant copyWith({
    int id,
    String parent,
    double basePrice,
    int quantity,
    String variant,
  }) {
    return ProductVariant(
      variantid: id ?? variantid,
      productID: parent ?? productID,
      price: basePrice ?? price,
      quantity: quantity ?? quantity,
      variantName: variant ?? variantName,
    );
  }
}