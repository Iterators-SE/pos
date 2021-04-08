class ProductDetails {
  final int productId;
  final String productName;
  final String description;
  final bool taxable;
  final String photoLink;

  ProductDetails(
      {this.productId,
      this.productName,
      this.description,
      this.taxable,
      this.photoLink});

  int get id => productId;
  String get name => productName;
  String get desc => description;
  bool get isTaxable => taxable;
  String get photo => photoLink;
}
