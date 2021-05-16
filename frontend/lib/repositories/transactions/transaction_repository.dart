import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';
import '../../core/error/failure.dart';
import '../../models/product.dart';
import 'interval.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, List<Product>>> getTopThree({
    Interval interval = Interval.day,
  }); 
  Future<Either<Failure, dynamic>> getGenericBreakdown();
  Future<Either<Failure, dynamic>> getProductBreakdown({@required int id});
  Future<Either<Failure, List<dynamic>>> getAllProductBreakdowns({
    Interval interval = Interval.day,
  });
}
