import '../../../core/state/app_state.dart';
import '../../../models/discounts.dart';
import 'add_discount_screen_view.dart';
import 'edit_discount_screen_view.dart';

abstract class DiscountScreenView {
  AppState state;
  List<Discount> discounts = [];

  AddDiscountScreenView addDiscountScreenView;
  EditDiscountScreenView editDiscountScreenView;

  void onError();
  Future<List<Discount>> getDiscounts();
  String formatTime(String time);
}
