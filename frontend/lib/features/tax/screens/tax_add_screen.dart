import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../repositories/tax/tax_repository_implementation.dart';
import '../models/new_tax.dart';
import '../presenters/tax_add_presenter.dart';
import '../views/tax_add_screen_view.dart';
import 'pages/tax_add_view.dart';

class AddTaxScreen extends StatefulWidget {
  const AddTaxScreen({Key key}) : super(key: key);

  @override
  _AddTaxScreenState createState() => _AddTaxScreenState();
}

class _AddTaxScreenState extends State<AddTaxScreen>
    implements AddTaxScreenView {
  AddTaxScreenPresenter _presenter;

  @override
  void initState() {
    _presenter = AddTaxScreenPresenter();
    _presenter.attachView(this);

    body = AddTaxPage(
      onSubmit: addTax,
    );

    setState(() {
      state = AppState.done;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tax"),
      ),
      body: _presenter.body(context),
    );
  }

  @override
  Widget body;

  @override
  AppState state;

  @override
  void addTax(BuildContext context, NewTax tax) async {
    setState(() {
      state = AppState.loading;
    });

    var taxProvider = Provider.of<TaxRepository>(context, listen: false);
    var taxAddResult = await taxProvider.addTax(tax);
    print(taxAddResult);

    if (taxAddResult.isRight) {
      setState(() {
        state = AppState.successful;
      });
    } else {
      setState(() {
        state = AppState.error;
      });
    }
  }

  @override
  void onError() {
    // TODO: implement onError
  }
}
