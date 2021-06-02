import '../../../models/product_variant.dart';

class EditableProductVariant {
  ProductVariant oldVariant;
  int index;
  bool isDeleted = false;

  EditableProductVariant({this.oldVariant, this.index});

  @override
  String toString() {
    return "index: $index, isDeleted: $isDeleted, variant: $oldVariant";
  }
}
