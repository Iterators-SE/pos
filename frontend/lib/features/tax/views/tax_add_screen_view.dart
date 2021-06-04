import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/tax/models/new_tax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';

abstract class AddTaxScreenView {
  AppState state;

  Widget body;

  void addTax(BuildContext context, NewTax tax);
  void onError();
}
