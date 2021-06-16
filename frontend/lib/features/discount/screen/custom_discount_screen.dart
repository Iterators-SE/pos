import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../../repositories/discount/discount_repository_implementation.dart';
import '../presenter/custom_discount_presenter.dart';
import '../view/custom_discount_screen_view.dart';
import 'generic_discount_screen.dart';
import 'helpers/time_formatter.dart';
import 'widgets/page/custom_discount_page.dart';

class CustomDiscountScreen extends StatefulWidget {
  final List<Product> products;
  final List<Product> allProducts;
  final Discount discount;
  final bool isAdd;

  const CustomDiscountScreen(
      {Key key,
      this.isAdd = true,
      this.products,
      this.discount,
      this.allProducts})
      : super(key: key);

  @override
  _CustomDiscountScreenState createState() => _CustomDiscountScreenState();
}

class _CustomDiscountScreenState extends State<CustomDiscountScreen>
    implements CustomDiscountScreenView {
  CustomDiscountScreenPresenter _presenter;

  @override
  AppState state = AppState.done;

  @override
  Discount discount;

  @override
  Widget body;

  @override
  bool isAdd;

  @override
  String description;

  @override
  List<Discount> discounts;

  @override
  DateTime endDate;

  @override
  TimeOfDay endTime;

  @override
  List<int> includedProducts;

  @override
  List<Product> allProducts;

  @override
  int percentage;

  @override
  DateTime startDate;

  @override
  TimeOfDay startTime;

  @override
  String formatTime(String time) {
    return timeFormatter(time);
  }

  @override
  void onError() {}

  @override
  void onPressed() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => isAdd
            ? GenericDiscountScreen(
                allProducts: allProducts,
                discount: null,
                discounts: discounts,
              )
            : GenericDiscountScreen(
                isAdd: false,
                allProducts: allProducts,
                discount: null,
                discounts: discounts,
              ),
      ),
    );
  }

  @override
  void onSave() async {
    Either<Failure, Discount> result;

    if (isAdd) {
      result = await Provider.of<DiscountRepository>(context, listen: false)
          .createCustomDiscount(
        description: description,
        percentage: percentage,
        products: includedProducts,
        endDate: endDate,
        startDate: startDate,
        endTime: endTime.toString(),
        startTime: startTime.toString(),
      );
    } else {
      result = await Provider.of<DiscountRepository>(context, listen: false)
          .updateCustomDiscount(
        id: discount.id,
        description: description,
        percentage: percentage,
        products: includedProducts,
        endDate: endDate,
        startDate: startDate,
        endTime: endTime.toString(),
        startTime: startTime.toString(),
      );
    }

    if (result.isRight) {
      Navigator.pop(context);
    }
  }

  @override
  void setStartDate(DateTime dateTime) => setState(() => startDate = dateTime);

  @override
  void setEndDate(DateTime dateTime) => setState(() => endDate = dateTime);

  @override
  void setStartTime(TimeOfDay time) => setState(() => startTime = time);

  @override
  void setEndTime(TimeOfDay time) => setState(() => endTime = time);

  @override
  void initState() {
    _presenter = CustomDiscountScreenPresenter();
    _presenter.view = this;

    isAdd = widget.isAdd;

    includedProducts = widget?.discount?.products ?? [];
    allProducts = widget.allProducts;
    percentage = widget?.discount?.percentage;

    body = CustomDiscountPage(
      onSave: onSave,
      onPressed: onPressed,
      label: isAdd ? "Create Generic Discount" : "Create Custom Discount",
      iconLabel: isAdd ? Icons.add : Icons.edit,
      products: allProducts,
      discounts: discounts,
      discount: discount,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _presenter.body(),
    );
  }
}
