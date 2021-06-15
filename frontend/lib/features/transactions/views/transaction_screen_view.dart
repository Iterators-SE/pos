import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../models/product.dart';
import '../../../repositories/transactions/interval.dart' as interval_i;

enum LoadingState { loading, retry, error, done }

abstract class TransactionScreenView {
  interval_i.Interval interval = interval_i.Interval.day;

  LoadingState state = LoadingState.loading;
  Failure failure;

  List<dynamic> transactions = [];

  List<Product> dayTopThree = [];
  List<Product> weekTopThree = [];
  List<Product> monthTopThree = [];

  List<Product> dayProductList = [];
  List<Product> weekProductList = [];
  List<Product> monthProductList = [];

  Widget day;
  Widget week;
  Widget month;

  void getProductLists();

  void toggleView(interval_i.Interval interval);

  Future getTransactions();
}
