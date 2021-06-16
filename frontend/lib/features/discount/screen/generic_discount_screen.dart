import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../../repositories/discount/discount_repository_implementation.dart';
import '../presenter/generic_discount_presenter.dart';
import '../view/generic_discount_screen_view.dart';
import 'custom_discount_screen.dart';
import 'widgets/page/generic_discount_page.dart';

class GenericDiscountScreen extends StatefulWidget {
  final bool isAdd;
  final Discount discount;
  final List<Product> allProducts;
  final List<Discount> discounts;

  const GenericDiscountScreen({
    Key key,
    this.isAdd = true,
    this.discount,
    @required this.discounts,
    @required this.allProducts,
  }) : super(key: key);
  @override
  _GenericDiscountScreenState createState() => _GenericDiscountScreenState();
}

class _GenericDiscountScreenState extends State<GenericDiscountScreen>
    implements GenericDiscountScreenView {
  GenericDiscountScreenPresenter _presenter;
  @override
  Widget body;

  @override
  String description;

  @override
  List<Discount> discounts;

  @override
  List<Product> allProducts = [];

  @override
  Discount discount;

  @override
  List<int> includedProducts;

  @override
  bool isAdd;

  @override
  int percentage;

  @override
  AppState state;

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void onPressed() {
    if (isAdd) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CustomDiscountScreen(
            isAdd: isAdd,
            allProducts: allProducts,
            discount: isAdd ? null : discount,
          ),
        ),
      );
    }
  }

  @override
  Future onSave({
    String description,
    List<int> includedProducts,
    int percentage,
    int id,
  }) async {
    Either<Failure, Discount> result;

    if (isAdd) {
      result = await Provider.of<DiscountRepository>(context, listen: false)
          .createGenericDiscount(
        description: description,
        percentage: percentage,
        products: includedProducts,
      );
    } else {
      result = await Provider.of<DiscountRepository>(context, listen: false)
          .updateGenericDiscount(
        id: discount.id,
        description: description,
        percentage: percentage,
        products: includedProducts,
      );
    }

    if (result.isRight) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _presenter = GenericDiscountScreenPresenter();
    _presenter.attachView(this);

    state = AppState.loading;

    isAdd = widget.isAdd;
    discount = widget.discount;
    allProducts = widget.allProducts;
    discounts = widget.discounts;

    body = GenericDiscountPage(
      onSave: ({description, includedProducts, percentage, id}) => onSave(
          description: description,
          includedProducts: includedProducts,
          percentage: percentage,
          id: id),
      onPressed: onPressed,
      iconLabel: isAdd ? Icons.add : Icons.edit,
      label: isAdd ? "Create Generic Discount" : "Edit Custom Discount",
      products: allProducts,
      discounts: discounts,
      discount: discount,
    );

    state = AppState.done;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _presenter.body(),
    );
  }
}
