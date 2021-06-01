import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

import '../../database/local/local_database.dart';
import 'discount_datasource.dart';

class DiscountLocalDataSource implements IDiscountLocalDataSource {
  final AppDatabase local;
  DiscountLocalDataSource({@required this.local,});

  @override
  Future<List<Discount>> getDiscounts() {
    return local.getDiscounts();
  }

  @override
  Future<Discount> getDiscount({int id}) {
    return local.getDiscount(id);
  }

  @override
  Future<void> cacheDiscounts(dynamic data) {
    print(data);
  }
}
