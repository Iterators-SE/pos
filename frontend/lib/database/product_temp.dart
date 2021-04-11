class ProductTemp {

  final int productId;
  final String productName;
  final String description;
  final bool taxable;
  final String photoLink;

  ProductTemp(
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

   factory ProductTemp.fromMap(Map<String, dynamic> json) => ProductTemp(
        productId: json["id"],
        productName: json["productname"],
        description: json["description"],
        taxable: json["taxable"],
        photoLink: json["photoLink"]
  );

    Map<String, dynamic> toMap() => {
        "id": productId,
        "productName": productName,
        "description": description,
        "taxable": taxable,
        "photoLink": photoLink
    };
}
