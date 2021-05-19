import 'package:flutter/material.dart';

import '../../../repositories/transactions/interval.dart' as interval_i;
import '../presenter/transaction_screen_presenter.dart';
import '../views/transaction_screen_view.dart';
import 'widgets/date_views/day_view.dart';
import 'widgets/date_views/month_view.dart';
import 'widgets/date_views/week_view.dart';


class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

// TODO: date picker for custom??

class _TransactionScreenState extends State<TransactionScreen>
    implements TransactionScreenView {
  TransactionScreenPresenter _presenter;

  @override
  interval_i.Interval interval;

  @override
  Widget day;

  @override
  Widget month;

  @override
  Widget week;

  @override
  void initState() {
    _presenter = TransactionScreenPresenter();
    _presenter.attachView(this);

    interval = interval_i.Interval.day;

    // TODO: POSSIBLE SOLN 
    // pass transaction data? from presenter.body?
    // have transaction variable to pass via presenter???

    day = DayViewWidget();
    week = WeekViewWidget();
    month = MonthViewWidget();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _presenter.body());
  }

  @override
  void onError(BuildContext context) {
    // TODO: implement onError
  }

  // pass interval param
  @override
  void toggleView(interval_i.Interval interval) {
    setState(() => this.interval = interval);

    // TODO: fetch necessary data || perhaps add fn to TView to fetch from repo?
  }
}
