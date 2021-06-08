import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../models/new_tax.dart';

abstract class AddTaxScreenView {
  AppState state;

  Widget body;

  void addTax(BuildContext context, NewTax tax);
  void onError();
}
