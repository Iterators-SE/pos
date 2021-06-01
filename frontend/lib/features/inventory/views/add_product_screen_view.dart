import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/models/new_product.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';

abstract class AddProductScreenView {
  AppState state;

  Widget body;

  Future<bool> addProduct(
      {BuildContext context, NewProduct product, PickedFile imageFile});
  void onError();
}
