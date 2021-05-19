import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../repositories/transactions/interval.dart' as intervalI;
import '../views/transaction_screen_view.dart';

class TransactionScreenPresenter
    extends BasePresenter<TransactionScreenView> {
  Widget body() {
    checkViewAttached();
    
    if (isViewAttached) {
      switch (getView().interval) {
        case intervalI.Interval.day:
          return getView().day;
          break;
        case intervalI.Interval.week:
          return getView().week;
          break;
        case intervalI.Interval.month:
          return getView().month;
          break;
        default:
          return getView().day;
      }
    }
  }
}
