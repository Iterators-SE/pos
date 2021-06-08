import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/state/app_state.dart';
import '../models/new_product.dart';

abstract class AddProductScreenView {
  AppState state;

  Widget body;

  Future<bool> addProduct(
      {BuildContext context, NewProduct product, PickedFile imageFile});
  void onError();
}
