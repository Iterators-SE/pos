import 'package:either_option/either_option.dart';

import '../../core/error/failure.dart';
import '../../models/product.dart';
import 'interval.dart';
import 'transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  @override
  Future<Either<Failure, List>> getAllProductBreakdowns({
    Interval interval = Interval.day,
  }) {
    // TODO: implement getAllProductBreakdowns
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> getGenericBreakdown() {
    // TODO: implement getGenericBreakdown
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> getProductBreakdown({int id}) {
    // TODO: implement getProductBreakdown
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getTopThree({
    Interval interval = Interval.day,
  }) {
    // TODO: implement getTopThree
    throw UnimplementedError();
  }
}
