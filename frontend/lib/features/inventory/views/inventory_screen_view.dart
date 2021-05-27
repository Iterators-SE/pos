import 'package:flutter/material.dart';
import '../../../models/product.dart';

abstract class InventoryScreenView {
  GlobalKey<FormState> formKey;

  String viewName = "";

  Product focusedProduct;


  Widget inventoryList;
  Widget addProduct;
  Widget editProductDetails;
  Widget productDetails;

  void onGetProducts(BuildContext context);
  void onGetProductDetails(BuildContext context, int productId);

  void onAddProduct(
      BuildContext context,
      String name,
      String description,
      // ignore: avoid_positional_boolean_parameters
      bool isTaxable,
      String photoLink);

  void changeProductDetails(BuildContext context, Product product);

  void onDeleteProduct(BuildContext context, int productId);
  void onDeleteVariant(BuildContext context, int variantId);

  void toggleView({String newViewName, Product productToView});
}
