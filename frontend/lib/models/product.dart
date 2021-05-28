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
      id: int.parse(productJson['id']),
      name: productJson['name'],
      description: productJson['description'],
      photoLink: productJson['photoLink'],
      isTaxable: productJson['isTaxable'],
      variants: productJson['variant'].map<ProductVariant>(
        (variant) => ProductVariant.fromJson(variant)).toList()  
    );
  }
}
