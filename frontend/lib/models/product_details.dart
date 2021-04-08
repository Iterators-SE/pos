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

   factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productId: json["id"],
        productName: json["productname"],
        description: json["description"],
        taxable: json["taxable"],
        photoLink: json["photoLink"]
  );

    Map<String, dynamic> toJson() => {
        "id": productId,
        "productName": productName,
        "description": description,
        "taxable": taxable,
        "photoLink": photoLink
    };
}
