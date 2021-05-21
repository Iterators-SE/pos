import 'package:flutter/material.dart';

import '../../../core/presenters/base_presenter.dart';
import '../../../repositories/transactions/interval.dart' as interval_i;
import '../views/transaction_screen_view.dart';

class TransactionScreenPresenter extends BasePresenter<TransactionScreenView> {
  Widget body() {
    checkViewAttached();

    if (isViewAttached && getView().state == LoadingState.done) {
      switch (getView().interval) {
        case interval_i.Interval.day:
          return getView().day;
          break;
        case interval_i.Interval.week:
          return getView().week;
          break;
        case interval_i.Interval.month:
          return getView().month;
          break;
        default:
          return getView().day;
      }
    } else if (isViewAttached && getView().state == LoadingState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (isViewAttached && getView().state == LoadingState.error) {
      return Center(child: Text(getView().failure.message));
    }

    return SizedBox.shrink();
  }
}
