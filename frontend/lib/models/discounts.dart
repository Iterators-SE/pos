import 'package:frontend/models/mock_discounts.dart';
import 'package:frontend/models/user.dart';

class Discount {
  int id;
  String description;
  int percentage;
  List<int> products;

  Discount(
      {this.id,
      this.description,
      this.percentage,
      this.products,});

  int get discId => id;
  String get desc => description;
  int get percent => percentage;
  List get product => products;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
      id: json["id"],
      description: json["description"],
      percentage: json["percentage"],
      products: json["products"],);

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "percentage": percentage,
        "products": products
      };
}

class CustomDiscount extends Discount{
  String inclusiveDates;
  String startTime;
  String endTime;

  CustomDiscount({
    this.inclusiveDates, 
    this.startTime, 
    this.endTime,
    int discountId,
    String description,
    int percentage,
    List<int> products,
    }) : super(
      id: discountId,
      description: description,
      products: products
      );

  String get dateInclusive => inclusiveDates;
  String get timeStarted => startTime;
  String get timeEnded => endTime;

  factory CustomDiscount.fromJson(Map<String, dynamic> json) => CustomDiscount(
        inclusiveDates: json["inlcusiveDates"],
        startTime: json["startTime"],
        endTime: json["endTime"]
  );

  Map<String, dynamic> toJson() => {
        "inclusiveDates": inclusiveDates,
        "startTime": startTime,
        "endTime": endTime
    };
}
