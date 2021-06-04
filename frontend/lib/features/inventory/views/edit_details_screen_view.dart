import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/models/edit_product_variant.dart';
import 'package:frontend/features/inventory/models/new_variant.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';

abstract class EditDetailScreenView {
  AppState state;

  Product product;

  Widget body;

  void onEdit(
    BuildContext context, 
    Product product, 
    PickedFile imageFile, 
    List<EditableProductVariant> variantsToUpdate,
    List<NewVariant> variantsToAdd
  );
  void onError();
}
