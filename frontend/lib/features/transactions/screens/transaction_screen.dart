import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../../../models/transaction.dart';
import '../../../repositories/transactions/interval.dart' as interval_i;
import '../../../repositories/transactions/transaction_repository_implementation.dart';
import '../presenter/transaction_screen_presenter.dart';
import '../views/transaction_screen_view.dart';
import 'widgets/date_views/day_view.dart';
import 'widgets/date_views/month_view.dart';
import 'widgets/date_views/week_view.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}


class _TransactionScreenState extends State<TransactionScreen>
    implements TransactionScreenView {
  TransactionScreenPresenter _presenter;

  @override
  LoadingState state;

  @override
  Failure failure;

  @override
  List<Transaction> transactions;

  @override
  interval_i.Interval interval;

  @override
  List<Product> dayProductList;

  @override
  List<Product> dayTopThree;

  @override
  List<Product> monthProductList;

  @override
  List<Product> monthTopThree;

  @override
  List<Product> weekProductList;

  @override
  List<Product> weekTopThree;

  @override
  Widget day;

  @override
  Widget month;

  @override
  Widget week;

  @override
  void initState() {
    _presenter = TransactionScreenPresenter();
    _presenter.attachView(this);

    state = LoadingState.loading;

    interval = interval_i.Interval.day;

    getTransactions().then((value) => null);

    final fakeProducts = [
      Product(id: 1, name: 'Olympian Cappucino', variants: [
        ProductVariant(
            variantId: 1,
            variantName: 'Small',
            quantity: 10,
            productId: 1,
            price: 100)
      ]),
      Product(id: 2, name: 'Kapa-Kappucino', variants: [
        ProductVariant(
            variantId: 2,
            variantName: 'Small',
            quantity: 50,
            productId: 1,
            price: 100)
      ]),
      Product(id: 3, name: 'Donut', variants: [
        ProductVariant(
            variantId: 3,
            variantName: 'Regular',
            quantity: 100,
            productId: 1,
            price: 100)
      ])
    ];

    day = DayViewWidget(
      products: dayProductList ?? [],
      topThree: dayTopThree ?? [],
    );

    week = WeekViewWidget(
      products: weekProductList ?? [],
      topThree: weekTopThree ?? [],
    );

    month = MonthViewWidget(
      products: monthProductList ?? [],
      topThree: monthTopThree ?? [],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _presenter.body());
  }

  @override
  void toggleView(interval_i.Interval interval) {
    setState(() => this.interval = interval);
  }

  @override
  void getProductLists() {
    setState(() {
      dayProductList = productHelper(1);
      weekProductList = productHelper(7);
      monthProductList = productHelper(31);

      dayTopThree = dayProductList.take(3).toList();
      weekTopThree = weekProductList.take(3).toList();
      monthTopThree = monthProductList.take(3).toList();
    });
  }

  @override
  Future getTransactions() async {
    var data = await Provider.of<TransactionRepository>(context, listen: false)
        .getTransactions();

    var transaction = data.fold((left) => left, (right) => right);

    if (data.isRight) {
      setState(() => transactions = transaction);
      getProductLists();
    } else {
      setState(() {
        failure = transaction;
        state = LoadingState.error;
      });
    }
  }

  List<Product> productHelper(int diff) {
    var result = <Product>[];
    var orders = transactions
        .where((t) => t.createdAt.difference(DateTime.now()).inDays <= diff)
        .map((t) => t.orders)
        .toList();

    for (var index = 0; index < orders.length; index++) {
      var element = orders[index];

      for (var item = 0; item < element.length; item++) {
        var order = element[item];

        var indexOfOrder = result.indexWhere(
          (value) => value.id == order.product.id,
        );

        if (indexOfOrder != -1) {
          var modifiedOrder = result[indexOfOrder];

          var modifiedVariant = modifiedOrder.variants.firstWhere(
            (element) => element.variantId == order.variant.variantId,
          )..quantity += order.quantity;

          var indexOfVariant = modifiedOrder.variants.indexWhere(
            (element) => element.variantId == order.variant.variantId,
          );

          modifiedOrder.variants[indexOfVariant] = modifiedVariant;

          result[indexOfOrder] = Product(
            id: result[indexOfOrder].id,
            isTaxable: order.product.isTaxable,
            variants: modifiedOrder.variants,
          );
        } else {
          result.add(order.product);
        }
      }
    }

    result.sort(
      (a, b) =>
          b.variants.fold(
            0,
            (previousValue, element) => previousValue + element.quantity,
          ) -
          a.variants.fold(
            0,
            (previousValue, element) => previousValue + element.quantity,
          ),
    );

    return result;
  }
}
