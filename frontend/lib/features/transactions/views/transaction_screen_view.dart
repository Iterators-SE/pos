import 'package:flutter/material.dart';
import '../../../repositories/transactions/interval.dart' as interval_i;

abstract class TransactionScreenView {
  interval_i.Interval interval = interval_i.Interval.day;
  Widget day;
  Widget week;
  Widget month;

  void onError(BuildContext context);

  void toggleView(interval_i.Interval interval);
}
