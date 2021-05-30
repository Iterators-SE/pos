import 'package:meta/meta.dart';

import '../../database/local/local_database.dart';
import 'discount_datasource.dart';

class DiscountLocalDataSource implements IDiscountLocalDataSource{
  final AppDatabase local;
  DiscountLocalDataSource({@required this.local});
  
  @override
  Future<List<Discount>> getDiscounts() {
    return local.getDiscounts();
  }
  
  @override
  Future<Discount> getDiscount({int id}){
    return local.getDiscount(id);
  }

  @override
  Future<void> cacheDiscount(data) {
      throw UnimplementedError();
    }
  
    @override
    Future<void> cacheDiscounts(data) {
    throw UnimplementedError();
  }
}