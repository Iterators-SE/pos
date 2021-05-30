import 'package:meta/meta.dart';
import '../../models/discounts.dart';

abstract class IDiscountDataSource {
  dynamic getDiscount({@required int id});

  dynamic getDiscounts();
}

abstract class IDiscountRemoteDataSource implements IDiscountDataSource {
  Future<Discount> createGenericDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
  });

  Future<Discount> createCustomDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  });

  Future<Discount> updateGenericDiscount(
      {@required int id,
      @required String description,
      @required int percentage,
      @required List<int> products});

  Future<Discount> updateCustomDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  });

  Future<bool> deleteDiscount({@required int id});
}

abstract class IDiscountLocalDataSource implements IDiscountDataSource{
  Future<void> cacheDiscounts(dynamic data);
  Future<void> cacheDiscount(dynamic data);
}
