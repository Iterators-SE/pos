import '../../models/discounts.dart';


abstract class DiscountDataSource{
  Future <bool> addDiscount(
    {
    String description,
     int percentage,
     String products,
     String createdAt,
     String updatedAt,
     }
  );
  Future <List<Discount>> getDiscount({int discountId});
  Future <bool> deleteDiscount({int id});
}