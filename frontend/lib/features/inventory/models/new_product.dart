import 'new_variant.dart';

class NewProduct {
  String name;
  String description;
  String photoLink;
  bool isTaxable;
  List<NewVariant> variants = [];

  NewProduct({this.name, this.description, this.photoLink, this.isTaxable});

  void addVariant(NewVariant variant) => variants.add(variant);
  void deleteVariant() => variants.removeLast();
}
