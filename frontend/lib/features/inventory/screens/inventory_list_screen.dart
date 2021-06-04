import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/screens/add_product_screen.dart';
import 'package:frontend/features/inventory/screens/product_details_screen.dart';
import 'package:frontend/features/inventory/screens/widgets/add_button.dart';
import 'package:frontend/providers/inventory_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/product.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../presenters/inventory_list_presenter.dart';
import '../views/inventory_list_screen_view.dart';
import 'page/list_view.dart';

// use this command when running app in browser
// flutter run -d chrome --web-renderer html

class InventoryListScreen extends StatefulWidget {
  @override
  _InventoryListScreenState createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen>
    implements InventoryListScreenView {
  InventoryListScreenPresenter _presenter;

  bool isUpdated = false;

  @override
  Widget body;

  @override
  String productToSearch = "";

  @override
  List<Product> products = [];

  @override
  AppState state;

  @override
  bool isSearching = false;

  @override
  void initState() {
    _presenter = InventoryListScreenPresenter();
    _presenter.attachView(this);

    getProducts(context).then((value) {
      body = ProductListPage(
        functionOnTap: onProductTilePressed,
        products: value,
        isSearching: isSearching,
        productToSearch: productToSearch,
      );

      // state = AppState.done;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InventoryFAB(
          label: "Add",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProductScreen()),
            ).then((value) async {

              await getProducts(context);
              setState(() {
                body = ProductListPage(
                  functionOnTap: onProductTilePressed,
                  products: products,
                  isSearching: isSearching,
                  productToSearch: productToSearch,
                );
              });
              
            });
          }),
      appBar: AppBar(
        title: !isSearching
            ? Text('Inventory')
            : TextField(
                onChanged: (value) {
                  setState(() {
                    productToSearch = value;
                    body = ProductListPage(
                      functionOnTap: onProductTilePressed,
                      products: products,
                      isSearching: isSearching,
                      productToSearch: productToSearch,
                    );
                  });
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search product",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      productToSearch = "";
                      body = ProductListPage(
                        functionOnTap: onProductTilePressed,
                        products: products,
                        isSearching: isSearching,
                        productToSearch: productToSearch,
                      );
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                      body = ProductListPage(
                        functionOnTap: onProductTilePressed,
                        products: products,
                        isSearching: isSearching,
                        productToSearch: productToSearch,
                      );
                    });
                  },
                )
        ],
      ),
      body: _presenter.body(),
    );
  }

  @override
  Future<List<Product>> getProducts(BuildContext context) async {
    setState(() {
      state = AppState.loading;
    });

    var resultProducts =
        await Provider.of<InventoryProvider>(context, listen: false)
            .getProducts(context);
    var result = resultProducts.fold((fail) => [], (products) => products);

    if (resultProducts.isRight) {
      setState(() {
        state = AppState.done;
        products = result;
      });
      return result;
    } else {
      setState(() {
        products = result;
        state = AppState.error;
      });
      return result;
    }

    // await Provider.of<InventoryRepository>(context, listen: false)
    //     .getProducts();
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void onProductTilePressed({Product product, BuildContext context}) async {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product)))
        .then((value) async {
      body = ProductListPage(
        functionOnTap: onProductTilePressed,
        products: await getProducts(context),
        isSearching: isSearching,
        productToSearch: productToSearch,
      );
    });
  }

  @override
  void setProductToSearch(String name) {
    setState(() {
      productToSearch = name;
    });
  }
}
