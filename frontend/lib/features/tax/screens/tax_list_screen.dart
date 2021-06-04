import 'package:flutter/material.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/features/inventory/presenters/inventory_list_presenter.dart';
import 'package:frontend/features/tax/presenters/tax_list_presenter.dart';
import 'package:frontend/features/tax/screens/pages/tax_list_view.dart';
import 'package:frontend/features/tax/screens/tax_add_screen.dart';
import 'package:frontend/features/tax/views/tax_list_screen_view.dart';
import 'package:frontend/models/tax.dart';
import 'package:frontend/providers/tax_provider.dart';
import 'package:frontend/repositories/tax/tax_repository_implementation.dart';
import 'package:provider/provider.dart';

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
  Tax selectedTax;

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
        setSelectedTaxLocal: setSelectedTax,
        selectedTax:
            value.where((element) => element.isSelected).toList().first,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaxScreen()),
          ).then((value) async {

            await getTaxes(context).then((value){
              setState(() {
                body = TaxListPage(
                  taxes: value,
                  onSelect: selectTax,
                  setSelectedTaxLocal: setSelectedTax,
                  selectedTax:
                  value.where((element) => element.isSelected).toList().first,
                );
              });
            });

            },
          );
        }
      ),
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
    var taxProvider = Provider.of<TaxProvider>(context, listen: false);
    var getTaxesResult = await taxProvider.getTaxes(context);
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
      body = TaxListPage(
        taxes: taxes,
        onSelect: selectTax,
        setSelectedTaxLocal: setSelectedTax,
        selectedTax:tax
      );
    });

    

    var taxProvider = Provider.of<TaxProvider>(context, listen: false);
    var setTaxResult = await taxProvider.selectTax(context, tax);
    if (setTaxResult.isRight) {
      setState(() {
        state = AppState.done;
      });
    }
  }

  @override
  void setTaxToSearch(String name) {
    // TODO: implement setTaxToSearch
  }

  @override
  void setSelectedTax(Tax tax) {
    setState(() {
      selectedTax = tax;
    });
  }
}
