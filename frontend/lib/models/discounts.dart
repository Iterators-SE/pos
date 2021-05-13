class Discounts {
  int discountId;
  String description;
  String owner;
  int percentage;
  List products;
  String createdAt;
  String updatedAt;

  Discounts(
      {this.discountId,
      this.description,
      this.owner,
      this.percentage,
      this.products,
      this.createdAt,
      this.updatedAt});

  int get id => discountId;
  String get desc => description;
  String get user => owner;
  int get percent => percentage;
  List get product => products;
  String get dateCreated => createdAt;
  String get dateUpdated => updatedAt;

  factory Discounts.fromJson(Map<String, dynamic> json) => Discounts(
        discountId: json["id"],
        description: json["description"],
        owner: json["owner"],
        percentage: json["percentage"],
        products: json["products"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"]
  );

  Map<String, dynamic> toJson() => {
        "id": discountId,
        "description": description,
        "owner" : owner,
        "percentage" : percentage,
        "products" : products,
        "createdAt" : createdAt,
        "updatedAt" : updatedAt
    };

}
