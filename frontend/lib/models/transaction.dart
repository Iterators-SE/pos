import 'package:meta/meta.dart';

import 'order.dart';
import 'tax.dart';

class Transaction {
  final int id;
  final List<Order> orders;
  final String link;
  Tax tax = Tax(percentage: 0);
  final DateTime createdAt;

  Transaction({
    @required this.id,
    @required this.orders,
    @required this.createdAt,
    this.link,
    this.tax,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var orders = <Order>[];

    for (var i = 0; i < json['orders'].length; i++) {
      orders.add(Order.fromJson(json['orders'][i]));
    }

    return Transaction(
      id: int.parse(json["id"]),
      orders: orders,
      link: json["link"],
      createdAt: DateTime.tryParse(json["createdAt"]) ?? json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders": orders,
        "createdAt": createdAt.toString(),
      };

  @override
  String toString() {
    return 'Transaction $id';
  }
}
