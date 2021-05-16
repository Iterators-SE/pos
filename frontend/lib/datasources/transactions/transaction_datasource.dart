import 'package:meta/meta.dart';

import '../../models/product.dart';
import '../../repositories/transactions/interval.dart';

abstract class ITransactionDataSource {
  Future<List<Product>> getTopThree({
    Interval interval = Interval.day,
  }); 
  Future<dynamic> getGenericBreakdown();
  Future<dynamic> getProductBreakdown({@required int id});
  Future<List<dynamic>> getAllProductBreakdowns({
    Interval interval = Interval.day,
  });
}
