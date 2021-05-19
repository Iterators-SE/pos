import 'package:flutter/material.dart';
import '../../../repositories/transactions/interval.dart' as intervalI;

abstract class TransactionScreenView {
  intervalI.Interval interval = intervalI.Interval.day;
  Widget day;
  Widget week;
  Widget month;

  void onError(BuildContext context);

  void toggleView();
}
