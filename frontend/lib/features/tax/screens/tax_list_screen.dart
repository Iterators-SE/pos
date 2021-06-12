import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../models/tax.dart';
import '../../../repositories/tax/tax_repository_implementation.dart';
import '../presenters/tax_list_presenter.dart';
import '../views/tax_list_screen_view.dart';
import 'pages/tax_list_view.dart';
import 'tax_add_screen.dart';

class TaxListScreen extends StatefulWidget {
  const TaxListScreen({Key key}) : super(key: key);

  @override
  _TaxListScreenState createState() => _TaxListScreenState();
}

class _TaxListScreenState extends State<TaxListScreen>
    implements TaxListScreenView {
  TaxListScreenPresenter _presenter;

  @override
  Widget body;

  @override
  bool isSearching;

  @override
  AppState state;

  @override
  String taxToSearch;

  @override
  List<Tax> taxes;

  @override
  void initState() {
    _presenter = TaxListScreenPresenter();
    _presenter.attachView(this);

    print("I ran");

    getTaxes(context).then((value) {
      value.sort((a, b) => a.id.compareTo(b.id));

      body = TaxListPage(
        taxes: value,
        onSelect: selectTax,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(taxes);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTaxScreen()),
            ).then(
              (value) async {
                await getTaxes(context).then((value) {
                  setState(() {
                    body = TaxListPage(
                      taxes: value,
                      onSelect: selectTax,
                    );
                  });
                });
              },
            );
          }),
      appBar: AppBar(
        title: Text("Taxes List"),
      ),
      body: _presenter.body(),
    );
  }

  @override
  Future<List<Tax>> getTaxes(BuildContext context) async {
    setState(() {
      state = AppState.loading;
    });
    var taxProvider = Provider.of<TaxRepository>(context, listen: false);
    var getTaxesResult = await taxProvider.getTaxes();
    var result = getTaxesResult.fold((fail) => fail, (taxes) => taxes);
    if (getTaxesResult.isRight) {
      setState(() {
        taxes = result;
        state = AppState.done;
      });
      return result;
    } else {
      setState(() {
        state = AppState.error;
        taxes = [];
      });
      return [];
    }
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void selectTax(BuildContext context, Tax tax) async {
    setState(() {
      state = AppState.loading;
    });
    var taxProvider = Provider.of<TaxRepository>(context, listen: false);
    var setTaxResult = await taxProvider.selectTax(tax);
    var newTaxesResult = await taxProvider.getTaxes();
    var newTaxes = newTaxesResult.fold((fail) => [], (taxes) => taxes);
    newTaxes.sort((a, b) => a.id.compareTo(b.id));
    if (setTaxResult.isRight) {
      setState(() {
        state = AppState.done;
        body = TaxListPage(
          taxes: newTaxes,
          onSelect: selectTax,
        );
      });
    }
  }

  @override
  void setTaxToSearch(String name) {
    // TODO: implement setTaxToSearch
  }
}
