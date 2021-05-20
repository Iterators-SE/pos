class ProductVariant{
  int variantId;
  String variantName;
  int quantity;
  int productId;
  int price;

  ProductVariant({
    this.variantId, 
    this.variantName, 
    this.quantity, 
    this.productId, 
    this.price});
    ProductVariant copyWith({
    int id,
    String parent,
    double basePrice,
    int quantity,
    String variant,
  }) {
    return ProductVariant(
      variantId: id ?? variantId,
      productId: parent ?? productId,
      price: basePrice ?? price,
      quantity: quantity ?? quantity,
      variantName: variant ?? variantName,
    );
  }
}