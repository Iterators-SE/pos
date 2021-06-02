import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/inventory/models/edit_product_variant.dart';
import 'package:frontend/features/inventory/models/new_variant.dart';
import 'package:frontend/repositories/inventory/inventory_repository_implementation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../core/state/app_state.dart';
import '../../../models/product.dart';
import '../presenters/edit_details_presenter.dart';
import '../views/edit_details_screen_view.dart';
import 'page/edit_details_view.dart';

class EditDetailScreen extends StatefulWidget {
  final Product product;
  EditDetailScreen({Key key, this.product});

  @override
  _EditDetailScreenState createState() => _EditDetailScreenState();
}

class _EditDetailScreenState extends State<EditDetailScreen>
    implements EditDetailScreenView {
  EditDetailScreenPresenter _presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product Details'),
      ),
      body: _presenter.body(context),
    );
  }

  @override
  void initState() {
    _presenter = EditDetailScreenPresenter();
    _presenter.attachView(this);

    body = EditDetailPage(
      onSubmit: onEdit,
      product: widget.product,
    );

    setState(() {
      state = AppState.done;
    });

    super.initState();
  }

  @override
  Widget body;

  @override
  Product product;

  @override
  AppState state;

  @override
  void onEdit(
      BuildContext context,
      Product product,
      PickedFile imageFile,
      List<EditableProductVariant> variantsToUpdate,
      List<NewVariant> variantsToAdd) async {
    setState(() {
      state = AppState.loading;
    });

    var inventoryProvider =
        await Provider.of<InventoryRepository>(context, listen: false);

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
      var url = await uploadTask.ref.getDownloadURL();

      product.photoLink = url;
    }

    var resultProductDetails =
        await inventoryProvider.changeProductDetails(product: product);

    var variantsToDelete =
        variantsToUpdate.where((element) => element.isDeleted).toList();

    print("variants to delete");
    print(variantsToDelete);

    var variantsToChange =
        variantsToUpdate.where((element) => !element.isDeleted).toList();

    print("variants to change");
    print(variantsToChange);

  

    var variantsDeleteResult;
    var variantsToUpdateResult;
    var variantsAddResult;

    //AddVariants
    if (variantsToAdd.isNotEmpty) {
      for (var i = 0; i < variantsToAdd.length; i++) {
        variantsAddResult = await inventoryProvider.addVariant(
            productId: product.id, variant: variantsToAdd[i]);
      }
    } else {
      variantsAddResult = Right(true);
    }
    //DeleteVariants

   
    if (variantsToDelete.isNotEmpty) {
      for (var i = 0; i < variantsToDelete.length; i++) {
        variantsDeleteResult = await inventoryProvider.deleteVariant(
            productVariantId: variantsToDelete[i].oldVariant.variantId);
      }
    } else {
      variantsDeleteResult = Right(true);
    }

    //UpdateVariants
    if (variantsToChange.isNotEmpty) {
      for (var i = 0; i < variantsToChange.length; i++) {
        variantsToUpdateResult = await inventoryProvider.editVariant(
            variant: variantsToChange[i].oldVariant);
      }
    } else {
      variantsToUpdateResult = Right(true);
    }

    if (resultProductDetails.isLeft || variantsAddResult.isLeft ||
        variantsDeleteResult.isLeft
        // variantsToUpdateResult.isLeft
        ) {
      setState(() {
        state = AppState.error;
      });
    } else {
      setState(() {
        state = AppState.successful;
      });
    }

    // print("onEdit");
    // print(product);
    // print(imageFile == null ? true : false);
    // print(variantsToUpdate);
    // print(variantsToAdd);
  }

  @override
  void onError() {
    // TODO: implement onError
  }
}
