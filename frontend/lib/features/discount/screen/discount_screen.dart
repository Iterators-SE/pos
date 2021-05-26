import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
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
  List<Discount> discounts = [];

  @override
  void initState() {
    _presenter = DiscountScreenPresenter();
    _presenter.view = this;

    getDiscounts().then((value) {
      var result = value.fold((failure) => failure, (list) => list);

      if (value.isRight) {
        setState(() {
          discounts = result;
          state = AppState.done;
          body = DiscountPage(discounts: discounts);
        });
      } else {
        setState(() {
          state = AppState.error;
        });
      }
    });

    super.initState();
  }

  @override
  void onError() {}

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
      appBar: AppBar(
        title: Text(
          "Discounts",
          style: TextStyle(fontFamily: "Montserrat Bold"),
        ),
      ),
      floatingActionButton: CustomDiscountFAB(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenericDiscountScreen(),
          ),
        ),
        label: "ADD",
        icon: Icons.add,
      ),
      body: _presenter.body(),
    );
  }
}
