import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/presenters/inventory_screen_presenter.dart';
import 'package:frontend/features/inventory/screens/widgets/list_view.dart';
import 'package:frontend/features/inventory/views/inventory_screen_view.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen>
    implements InventoryScreenView {
  InventoryScreenPresenter _presenter;

  @override
  Product focusedProduct;

  @override
  Widget addProduct;

  @override
  Widget editProductDetails;

  @override
  GlobalKey<FormState> formKey;

  @override
  Widget inventoryList;

  @override
  Widget productDetails;

  @override
  String viewName;

  @override
  void initState() {
    _presenter = InventoryScreenPresenter();
    _presenter.attachView(this);

    viewName = "list";

    inventoryList = InventoryListWidget(getProducts: onGetProducts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _presenter.scaffold();
  }

  @override
  void changeProductDetails(BuildContext context, Product product) {
    // TODO: implement changeProductDetails
  }

  @override
  void onAddProduct(BuildContext context, String name, String description,
      bool isTaxable, String photoLink) {}

  @override
  void onDeleteProduct(BuildContext context, int productId) {
    // TODO: implement onDeleteProduct
  }

  @override
  void onDeleteVariant(BuildContext context, int variantId) {
    // TODO: implement onDeleteVariant
  }

  @override
  void onGetProductDetails(BuildContext context, int productId) {
    // TODO: implement onGetProductDetails
  }

  @override
  void onGetProducts(BuildContext context) async {
    var provider = Provider.of<InventoryRepository>(context, listen: false);
    var response = await provider.getProducts();
    response.fold((failure) => [], (productList) => productList);
    print(await response);
  }

  @override
  void toggleView({String newViewName, Product productToView}) {
    if (productToView != null) {
      setState(() {
        formKey.currentState.reset();
        viewName = newViewName;
        focusedProduct = productToView;
      });
    } else {
      setState(() {
        formKey.currentState.reset();
        viewName = newViewName;
      });
    }
  }
}
