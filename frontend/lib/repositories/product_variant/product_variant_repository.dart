import 'package:either_option/either_option.dart';
import '../../core/error/failure.dart';
import '../../models/product_variant.dart';

abstract class AbstractProductVariantRepository{
  Future<Either<Failure, bool>> addVariant({
    String variantName,
    int price,
    int quantity,
    int productID
  });

  Future<Either<Failure,List<ProductVariant>>> getVariants({int productID});
  Future<Either<Failure, bool>> deleteVariant({int variantid});
}