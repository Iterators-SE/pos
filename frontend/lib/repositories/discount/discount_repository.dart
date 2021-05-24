import 'package:either_option/either_option.dart';
import '../../core/error/failure.dart';
import '../../models/discounts.dart';

abstract class DiscountRepository {
  Future<Either<Failure, Discount>> getDiscount({int id});

  Future<Either<Failure, List<Discount>>> getDiscounts({List<int> id});

  Future<Either<Failure, bool>> createGenericDiscount({
    String description,
    int percentage,
    List<int> products,
  });

  Future<Either<Failure, Discount>> createCustomDiscount({
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
  });

  Future<Either<Failure, Discount>> updateGenericDiscount({
    int id,
    String description,
    int percentage,
    List<int> products
  });

  Future<Either<Failure, Discount>> updateCustomDiscount({
    int id,
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
  });

  Future<Either<Failure, bool>> deleteDiscount({int id});
}
