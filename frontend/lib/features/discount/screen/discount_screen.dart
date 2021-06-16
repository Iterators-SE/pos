import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/repositories/discount/discount_repository_implementation.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:provider/provider.dart';

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
    var products =
        await Provider.of<InventoryRepository>(context, listen: false)
            .getProducts();

    return products;
  }

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    var discounts =
        await Provider.of<DiscountRepository>(context, listen: false)
            .getDiscounts();

    return discounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Discounts"),
      floatingActionButton: CustomDiscountFAB(
        label: "ADD DISCOUNT",
        icon: Icons.attach_money,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GenericDiscountScreen(
              discounts: discounts,
              allProducts: products,
            ),
          ),
        ),

      ),
    );
  }
}
