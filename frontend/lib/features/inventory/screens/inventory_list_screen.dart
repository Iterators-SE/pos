import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/screens/add_product_screen.dart';
import 'package:frontend/features/inventory/screens/product_details_screen.dart';
import 'package:frontend/features/inventory/screens/widgets/add_button.dart';
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../models/product.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../presenters/inventory_list_presenter.dart';
import '../views/inventory_list_screen_view.dart';
import 'page/list_view.dart';

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
  AppState state = AppState.loading;

  @override
  bool isSearching = false;

  @override
  void initState() {
    _presenter = InventoryListScreenPresenter();
    _presenter.attachView(this);

    getProducts(context).then((value) {
      var productResult = value.fold((failure) => failure, (list) => list);
      if (value.isRight) {
        setState(() {
          products = productResult;
          body = ProductListPage(
            functionOnTap: onProductTilePressed,
            products: products,
            isSearching: isSearching,
            productToSearch: productToSearch,
          );
          state = AppState.done;
        });
      } else {
        setState(() => state = AppState.error);
      }
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
              );
            }),
        appBar: AppBar(
          title: !isSearching
              ? Text('Inventory')
              : TextField(
                  onChanged: (value) {
                    setState(() {
                      productToSearch = value;
                      body = ProductListPage(
                        products: products,
                        isSearching: isSearching,
                        productToSearch: productToSearch,
                      );
                      print(value);
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
                          products: products,
                          isSearching: isSearching,
                          productToSearch: productToSearch,
                        );
                      });
                    },
                  )
          ],
        ),
        body: _presenter.body());
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts(
      BuildContext context) async {
    var products =
        await Provider.of<InventoryRepository>(context, listen: false)
            .getProducts();

    return products;
  }

  @override
  void onError() {
    // TODO: implement onError
  }

  @override
  void onProductTilePressed({Product product, BuildContext context}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product)));
  }

  @override
  void setProductToSearch(String name) {
    setState(() {
      productToSearch = name;
    });
  }
}
