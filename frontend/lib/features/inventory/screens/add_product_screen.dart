import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/state/app_state.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../models/new_product.dart';
import '../models/new_variant.dart';
import '../presenters/add_product_presenter.dart';
import '../views/add_product_screen_view.dart';
import 'page/add_product_view.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    implements AddProductScreenView {
  AddProductScreenPresenter _presenter;
  @override
  Widget body;

  @override
  AppState state;

  @override
  void initState() {
    _presenter = AddProductScreenPresenter();
    _presenter.attachView(this);

    body = AddProductPage(
      onSubmit: addProduct,
    );

    setState(() {
      state = AppState.done;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: _presenter.body(context),
    );
  }

  Future<bool> addProduct(
      {BuildContext context, NewProduct product, PickedFile imageFile}) async {
    setState(() {
      state = AppState.loading;
    });

    if (product.variants.isEmpty) {
      product.addVariant(
        NewVariant(
          name: "Regular",
          price: 0,
          quantity: 0,
       )
      );
    }

    var url;

    var productProvider =
        Provider.of<InventoryRepository>(context, listen: false);

    if (imageFile != null) {
      var dateNow = DateTime.now().millisecondsSinceEpoch.toString();
      var ref = firebase_storage.FirebaseStorage.instance
          .refFromURL('gs://iterators-pos-photo-storage.appspot.com')
          .child('images')
          .child('/$dateNow.jpg');

      final metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      var uploadTask =
          await ref.putData(await imageFile.readAsBytes(), metadata);
      url = await uploadTask.ref.getDownloadURL();
    } else {
      url =
          "https://region4.uaw.org/sites/default/files/styles/large_square/public/bio/10546i3dac5a5993c8bc8c_6.jpg?itok=Iv9bC2vD&c=2e7651912d133fd4368c0dce602cd839";
    }

    print(url);
    product.photoLink = await url;
    var result = await productProvider.addProduct(product: product);

    if (await result.isRight) {
      setState(() {
        state = AppState.successful;
      });
    } else {
      setState(() {
        state = AppState.error;
      });
    }

    var addResult =
        result.fold((failure) => failure, (isSuccessful) => isSuccessful);

    return addResult;
  }

  @override
  void onError() {
    // TODO: implement onError
  }
}
