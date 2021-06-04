class NewVariant {
  String name;
  int quantity;
  int price;

  NewVariant({this.name, this.quantity, this.price});

  @override
  String toString() {
    return "name: $name, quantity: $quantity, price: $price";
  }
}
