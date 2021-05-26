import 'package:flutter/material.dart';

import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../presenter/custom_discount_presenter.dart';
import '../view/custom_discount_screen_view.dart';
import 'generic_discount_screen.dart';
import 'helpers/time_formatter.dart';
import 'widgets/page/custom_discount_page.dart';

class CustomDiscountScreen extends StatefulWidget {
  final List<Product> products;
  final CustomDiscount discount;
  final bool isAdd;

  const CustomDiscountScreen({
    Key key,
    this.isAdd,
    this.products,
    this.discount,
  }) : super(key: key);

  @override
  _CustomDiscountScreenState createState() => _CustomDiscountScreenState();
}

class _CustomDiscountScreenState extends State<CustomDiscountScreen>
    implements CustomDiscountScreenView {
  CustomDiscountScreenPresenter _presenter;

  @override
  AppState state;

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isAdd
            ? GenericDiscountScreen()
            : GenericDiscountScreen(isAdd: false),
      ),
    );
  }

  @override
  void onSave() {
    if (isAdd) {
    } else {}
  }

  @override
  void setStartDate(DateTime dateTime) => setState(() => startDate = dateTime);

  @override
  void setEndDate(DateTime dateTime) => setState(() => endDate = dateTime);

  @override
  void setStartTime(TimeOfDay time) => setState(() => startTime = time);

  @override
  void setEndTime(TimeOfDay time) => setState(() => endTime = time);

  // @override
  // void toggle() {
  //   isAdd = !isAdd;
  //   startTime = null;
  //   endTime = null;
  //   startDate = null;
  //   startDate = null;
  // }

  @override
  void initState() {
    _presenter = CustomDiscountScreenPresenter();
    _presenter.view = this;

    state = AppState.loading;

    isAdd = widget.isAdd;

    includedProducts = widget.discount.products;
    percentage = widget.discount.percentage;

    body = CustomDiscountPage(
      onSave: onSave,
      onPressed: onPressed,
      label: isAdd ? "Create Generic Discount" : "Create Custom Discount",
      iconLabel: isAdd ? Icons.add : Icons.edit,
      products: widget.products,
      discounts: discounts,
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
