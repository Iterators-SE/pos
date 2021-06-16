import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';

// import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
// import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../appBar.dart';
// import '../../../repositories/discount/discount_repository_implementation.dart';
import '../presenter/discount_screen_presenter.dart';
import '../view/discount_screen_view.dart';
import 'generic_discount_screen.dart';
import 'widgets/custom_discount_fab.dart';
import 'widgets/page/discount_page.dart';

class DiscountScreen extends StatefulWidget {
  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen>
    implements DiscountScreenView {
  DiscountScreenPresenter _presenter;

  @override
  AppState state = AppState.loading;

  @override
  Widget body;

  @override
  List<dynamic> discounts = [];
  List<dynamic> products = [];

  @override
  void initState() {
    _presenter = DiscountScreenPresenter();
    _presenter.view = this;

    getProducts().then((value) {
      var productResult = value.fold((failure) => failure, (list) => list);

      if (value.isRight) {
        setState(() => products = productResult);

        getDiscounts().then((value) {
          var result = value.fold((failure) => failure, (list) => list);

          if (value.isRight) {
            setState(() {
              discounts = result;
              state = AppState.done;
              body = DiscountPage(discounts: discounts, allProducts: products);
            });
          } else {
            setState(() {
              state = AppState.error;
            });
          }
        });
      } else {
        setState(() => state = AppState.error);
      }
    });

    super.initState();
  }

  @override
  void onError() {}

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    // var products =
    //     await Provider.of<InventoryRepository>(context, listen: false)
    //         .getProducts();

    // return products;
    var fake = await [
      Product(
        id: 1,
        name: 'Fake',
        description: 'Frapucapucino',
      ),
      Product(
        id: 2,
        name: 'Faker',
        description: "Kape",
      ),
      Product(
        id: 3,
        name: 'Fake Kopi',
        description: "Kopi",
      ),
    ];

    return Right(fake);
  }

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    // var discounts =
    //     await Provider.of<DiscountRepository>(context, listen: false)
    //         .getDiscounts();

    // return discounts;

    // MOCK
    var fake = await [
      Discount(
        id: 1,
        percentage: 20,
        products: [1, 2, 3],
        description: "Senior Citizen",
      ),
      Discount(
        id: 2,
        percentage: 15,
        products: [1, 3],
        description: "PWD",
      )
    ];

    return Right(fake);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Discounts"),
      floatingActionButton: CustomDiscountFAB(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenericDiscountScreen(
              discounts: discounts,
              allProducts: products,
            ),
          ),
        ),
        label: "ADD",
        icon: Icons.add,
      ),
      body: _presenter.body(),
    );
  }
}
