class Product {
  int id;
  int quantity;
  double basePrice;
  String variant;
  String name;
  double discount;

  // make required
  Product({
    this.id,
    this.quantity,
    this.name,
    this.variant,
    this.basePrice,
    this.discount = 0,
  });
}
