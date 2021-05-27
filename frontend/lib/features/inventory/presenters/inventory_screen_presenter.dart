import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../views/inventory_screen_view.dart';

class InventoryScreenPresenter extends BasePresenter<InventoryScreenView> {
  Widget scaffold() {
    checkViewAttached();

    if (isViewAttached) {
      if (getView().viewName == "add") {
        return getView().addProduct;
      } else if (getView().viewName == "details") {
        return getView().productDetails;
      } else if (getView().viewName == "list") {
        return getView().inventoryList;
      } else if (getView().viewName == "edit") {
        return getView().editProductDetails;
      }
    }

    return getView().inventoryList;
  }
}
