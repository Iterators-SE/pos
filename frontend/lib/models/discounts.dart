class Discount {
  int id;
  String description;
  int percentage;
  List<int> products;
  String inclusiveDates;
  String startTime;
  String endTime;
  Discount({
    this.id,
    this.description,
    this.percentage,
    this.products,
    this.inclusiveDates,
    this.startTime,
    this.endTime,
  });

  int get discId => id;
  String get desc => description;
  int get percent => percentage;
  List get product => products;

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      id: int.tryParse(json["id"]) ?? json["id"],
      description: json["description"],
      percentage: json["percentage"],
      products: json["products"]
              ?.map<int>((prod) => int.parse(prod['id']))
              ?.toList() ??
          [],
      inclusiveDates: json["inlcusiveDates"],
      startTime: json["startTime"],
      endTime: json["endTime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "percentage": percentage,
        "products": products,
        "inclusiveDates": inclusiveDates,
        "startTime": startTime,
        "endTime": endTime
      };
}
