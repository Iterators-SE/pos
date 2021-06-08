import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../presenters/product_details_presenter.dart';
import '../views/product_details_screen_view.dart';
import 'edit_details_screen.dart';
import 'page/product_details_view.dart';

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
                onDelete(productData, context);
              }),
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditDetailScreen(product: widget.product),
                  ),
                ).then((value) async {
                  await updateProductData(productData, context);
                });
              }),
        ],
      ),
      body: _presenter.body(context),
    );
  }

  @override
  Product productData;

  @override
  Widget body;

  @override
  AppState state;

  @override
  void initState() {
    _presenter = ProductDetailScreenPresenter();
    _presenter.attachView(this);

    productData = widget.product;

    body = ProductDetailPage(product: productData);
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
  void updateProductData(Product product, BuildContext context) async {
    setState(() {
      state = AppState.loading;
    });

    var productProvider =
        Provider.of<InventoryRepository>(context, listen: false);
    var result =
        await productProvider.getProductDetails(productId: widget.product.id);
    if (await result.isRight) {
      setState(() {
        productData =
            result.fold((failure) => Product(), (isSuccessful) => isSuccessful);
        body = ProductDetailPage(product: productData);
        state = AppState.done;
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
