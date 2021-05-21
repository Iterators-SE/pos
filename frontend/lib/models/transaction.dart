import 'package:meta/meta.dart';

import 'order.dart';

class Transaction {
  final int id;
  final List<Order> orders;
  final DateTime createdAt;

  Transaction({
    @required this.id,
    @required this.orders,
    @required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        orders: json["orders"].map((order) => Order.fromJson(order)).toList(),
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders": orders,
        "createdAt": createdAt,
      };
}
