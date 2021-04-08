import '../../../models/product_variant.dart';

abstract class ProductVariantDataSource{
  Future <bool> addVariant(
    {String variantName,
    int quantity,
    int price,
     int productID}
  );
  Future <List<ProductVariant>> getVariants({int productid});
  Future <bool> deleteVariant({int id});
}