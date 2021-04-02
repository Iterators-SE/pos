class Product {
  int id;
  int quantity;
  List variants = [];
  String name;
  double discount;

  // make required
  Product({
    this.id,
    this.name,
    this.variants = const [],
    this.discount = 0,
  }) {
    quantity = variants.fold(
      0,
      (previousValue, item) => previousValue + item?.quantity ?? 0,
    );
  }
}
