import 'package:flutter/material.dart';
import 'package:frontend/core/themes/config.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../models/tax.dart';
import '../../../providers/tax_provider.dart';
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
      // appBar: AppBar(
      //   title: Text("Taxes List"),
      // ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 40),
          height: 125,
          decoration: BoxDecoration(
            color: xposGreen[300],
            borderRadius: BorderRadius.only(
              //bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                offset: Offset(0, 10.0),
                blurRadius: 25,
                spreadRadius: 1.50
              )
            ]
          ),
          //margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "TAXES",
                style: TextStyle(
                  fontFamily: "Montserrat Superbold",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )
          ),
          _presenter.body()
      ],),
      //body: _presenter.body(),
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
