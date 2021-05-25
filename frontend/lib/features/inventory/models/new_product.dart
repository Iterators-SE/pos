import 'new_variant.dart';

class NewProduct {
  String name;
  String description;
  String photoLink;
  bool isTaxable;
  List<NewVariant> variants = [];

  void addVariant(NewVariant variant) => variants.add(variant);
  void deleteVariant() => variants.removeLast();
}