class ProductVariant {
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
    this.price,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json, int productId) {
      return ProductVariant(
        variantId: int.tryParse(json['id']),
        price: json['price'],
        quantity: json['quantity'],
        variantName: json['name'],
        productId: productId,
      );
  }

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

  @override
  String toString() {
    return 'id: $variantId, name: $variantName, productId: $productId';
  }
}
