import 'product_variant.dart';

class Product {
  int id;
  String name;
  String photoLink;
  String description;
  bool isTaxable;
  int quantity;
  double discount;
  int min;
  int max;

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
    // TODO: Alan pls fix - major bug with transactions bc of this
    
    // quantity = variants?.fold(
    //   0,
    //   (previousValue, item) => previousValue + item.quantity ?? 0,
    // );

    // variants?.sort((a, b) => a.price.compareTo(b.price));
    // max = variants?.last?.price;
    // min = variants?.first?.price;
  }

  factory Product.fromJson(Map<String, dynamic> productJson) {
    return Product(
      id: int.tryParse(productJson['id']) ?? productJson['id'],
      name: productJson['name'],
      description: productJson['description'],
      photoLink: productJson['photoLink'] ?? '',
      isTaxable: productJson['isTaxable'] ?? false,
      variants: productJson['variant']
              ?.map<ProductVariant>(
                (variant) => ProductVariant.fromJson(
                  variant,
                  int.tryParse(productJson['id']) ?? productJson['id'],
                ),
              )
              ?.toList() ??
          [],
    );
  }

  String toString() {
    return 'Name: $name, variants: $variants';
  }
}
