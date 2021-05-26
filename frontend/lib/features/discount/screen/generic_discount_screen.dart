import 'package:flutter/material.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/features/discount/presenter/generic_discount_presenter.dart';
import 'package:frontend/features/discount/view/generic_discount_screen_view.dart';
import 'package:frontend/models/discounts.dart';

class GenericDiscountScreen extends StatefulWidget {
  final bool isAdd;

  const GenericDiscountScreen({
    Key key,
    this.isAdd = true,
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
    // TODO: implement onPressed
  }

  @override
  void onSave() {
    // TODO: implement onSave
  }

  @override
  void initState() {
    _presenter = GenericDiscountScreenPresenter();
    _presenter.attachView(this);
    
    state = AppState.loading;
    isAdd = widget.isAdd;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
