import 'package:frontend/features/inventory/models/new_variant.dart';

import '../../../models/product_variant.dart';

class EditableNewVariant {
  NewVariant newVariant;
  int index;

  EditableNewVariant({this.newVariant, this.index});
}
