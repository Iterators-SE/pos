import 'product_variant.dart';

class Product {
  int id;
  String name;
  String photoLink;
  String description;
  bool isTaxable;
  int quantity;
  double discount;
  List<ProductVariant> variants = [];


  Product({
    this.isTaxable,
    this.id,
    this.name,
    this.description,
    this.photoLink,
    this.variants = const [],
    this.discount = 0,
  }) {
    quantity = variants.fold(
      0,
      (previousValue, item) => previousValue + item.quantity ?? 0,
    );
  }

  factory Product.fromJson(Map<String, dynamic> productJson){
    return Product(
      id: productJson['id'],
      name: productJson['productname'],
      description: productJson['description'],
      photoLink: productJson['photolink'],
      isTaxable: productJson['taxable'],
    );
  }
}
