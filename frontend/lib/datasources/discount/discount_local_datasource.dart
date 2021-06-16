import 'package:meta/meta.dart';

import '../../database/local/local_database.dart';
import 'discount_datasource.dart';

class DiscountLocalDataSource implements IDiscountLocalDataSource {
  final AppDatabase local;
  DiscountLocalDataSource({@required this.local,});

  @override
  Future<List<Discount>> getDiscounts() async {
    return await local.getDiscounts();
  }

  @override
  Future<Discount> getDiscount({int id})async  {
    return await local.getDiscount(id);
  }

  @override
  Future<void> cacheDiscounts(dynamic data) async {
     var discounts = data.map((discount){
      local.addDiscount(Discount(
        description:discount['description'],
        id: discount['id'],
        percentage: discount['percentage'],
        inclusiveDates: discount['inclusiveDates'],
        startTime: discount['startTime'],
        endTime: discount['endTime'] ));
    });
    print(discounts);
  }
}
