class ProductVariant {
  final int id;
  final String parent;
  final double basePrice;
  final int quantity;
  final String variant;

  ProductVariant({
    this.id,
    this.parent,
    this.basePrice,
    this.quantity,
    this.variant,
  });

  ProductVariant copyWith({
    int id,
    String parent,
    double basePrice,
    int quantity,
    String variant,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      parent: parent ?? this.parent,
      basePrice: basePrice ?? this.basePrice,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
    );
  }
}
