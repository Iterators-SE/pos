import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../models/order.dart';
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
  LoadingState state = LoadingState.loading;

  @override
  Failure failure;

  @override
  List<dynamic> transactions = [];

  @override
  interval_i.Interval interval = interval_i.Interval.day;

  @override
  List<Product> dayProductList = [];

  @override
  List<Product> dayTopThree = [];

  @override
  List<Product> monthProductList = [];

  @override
  List<Product> monthTopThree = [];

  @override
  List<Product> weekProductList = [];

  @override
  List<Product> weekTopThree = [];

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

    // getTransactions().then((value) => value);

    // MOCK LOADING && DATA FETCHING
    Future.delayed(Duration(seconds: 10)).then((value) => {
          getTransactionsMock().then((value) {
            var data = value.fold((fail) => fail, (pass) => pass);

            if (value.isRight) {
              setState(() {
                transactions = data;

                dayProductList = productHelper(1);
                weekProductList = productHelper(7);
                monthProductList = productHelper(31);

                dayTopThree = dayProductList.take(3).toList();
                weekTopThree = weekProductList.take(3).toList();
                monthTopThree = monthProductList.take(3).toList();

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
                state = LoadingState.done;
              });
              getProductLists();
            } else {
              setState(() {
                failure = data;
                state = LoadingState.error;
              });
            }
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.view_day),
            onPressed: () => toggleView(interval_i.Interval.day),
          ),
          IconButton(
            icon: Icon(Icons.view_week),
            onPressed: () => toggleView(interval_i.Interval.week),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => toggleView(interval_i.Interval.month),
          ),
        ],
      ),
      body: _presenter.body(),
    );
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

  // FAKE
  Future<Either<Failure, List<Transaction>>> getTransactionsMock() async {
    var data = await <Transaction>[
      Transaction(
        id: 1,
        orders: [
          Order(
            id: 1,
            product: Product(id: 1, name: 'Rando'),
            variant: ProductVariant(
              productId: 1,
              variantId: 1,
              quantity: 7,
              price: 100,
              variantName: 'Small',
            ),
            quantity: 7,
          ),
          Order(
            id: 2,
            product: Product(id: 2, name: 'Rando2'),
            variant: ProductVariant(
              productId: 2,
              variantId: 2,
              quantity: 70,
              variantName: 'Small',
              price: 150,
            ),
            quantity: 10,
          ),
          Order(
            id: 3,
            product: Product(id: 1, name: 'Rando'),
            variant: ProductVariant(
                productId: 1,
                variantId: 3,
                quantity: 10,
                price: 120,
                variantName: 'Regular'),
            quantity: 7,
          ),
        ],
        createdAt: DateTime(2021, 5, 22),
      )
    ];

    return data.isNotEmpty ? Right(data) : Left(NoResultsFoundFailure());
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
              orElse: () => null);

          if (modifiedVariant != null) {
            result[indexOfOrder] = result[indexOfOrder]
              ..quantity += order.quantity;
          } else {
            result[indexOfOrder] = result[indexOfOrder]
              ..variants = [...result[indexOfOrder].variants, order.variant]
              ..quantity += order.quantity;
          }
        } else {
          result.add(order.product..quantity = order.quantity);
        }
      }
    }

    result?.sort(
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

    return result ?? [];
  }
}
