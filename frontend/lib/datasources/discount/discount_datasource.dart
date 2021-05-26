import 'package:meta/meta.dart';
import '../../models/discounts.dart';

abstract class DiscountDataSource {
  Future<Discount> getDiscount({@required int id});

  Future<List<Discount>> getDiscounts();

  Future<bool> createGenericDiscount({
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

  Future<Discount> updateGenericDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products
    });
  
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
