import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../models/discounts.dart';

abstract class IDiscountRepository {
  Future<Either<Failure, dynamic>> getDiscount({@required int id});

  Future<Either<Failure, List<dynamic>>> getDiscounts();

  Future<Either<Failure, Discount>> createGenericDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
  });

  Future<Either<Failure, Discount>> createCustomDiscount({
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  });

  Future<Either<Failure, Discount>> updateGenericDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products
  });

  Future<Either<Failure, Discount>> updateCustomDiscount({
    @required int id,
    @required String description,
    @required int percentage,
    @required List<int> products,
    @required DateTime endDate,
    @required DateTime startDate,
    @required String endTime,
    @required String startTime,
  });

  Future<Either<Failure, bool>> deleteDiscount({@required int id});
}
