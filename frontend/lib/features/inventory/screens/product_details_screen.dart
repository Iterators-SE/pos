import 'package:either_option/src/either.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/state/app_state.dart';
import 'package:frontend/core/error/failure.dart';
import 'package:frontend/features/inventory/presenters/product_details_presenter.dart';
import 'package:frontend/features/inventory/screens/page/product_details_view.dart';
import 'package:frontend/features/inventory/views/product_details_screen_view.dart';
import 'package:frontend/features/inventory_old/details/product_details.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  ProductDetailScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    implements ProductDetailScreenView {
  ProductDetailScreenPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                onDelete(product, context);
              }),
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                onEdit(widget.product);
              }),
        ],
      ),
      body: _presenter.body(context),
    );
  }

  @override
  Product product;

  @override
  Widget body;

  @override
  AppState state;

  @override
  void initState() {
    _presenter = ProductDetailScreenPresenter();
    _presenter.attachView(this);

    body = ProductDetailPage(product: widget.product);
    state = AppState.done;
    super.initState();
  }

  @override
  Future<bool> onDelete(Product product, BuildContext context) async {
    setState(() {
      state = AppState.loading;
    });

    var productProvider =
        Provider.of<InventoryRepository>(context, listen: false);
    var result =
        await productProvider.deleteProduct(productId: widget.product.id);
    print(result);
    if (await result.isRight) {
      print("trueeee");
      setState(() {
        state = AppState.successful;
      });
    } else {
      print("false");
      setState(() {
        state = AppState.error;
      });
    }
    var deleteResult =
        result.fold((failure) => failure, (isSuccessful) => isSuccessful);
    return deleteResult;
  }

  @override
  void onEdit(Product product) {
    // TODO: implement onEdit
  }

  @override
  void onError() {
    // TODO: implement onError
  }
}
