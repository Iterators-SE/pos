import 'package:either_option/either_option.dart';
import '../core/error/failure.dart';
import '../models/product.dart';

abstract class AbstractInventoryRepository {
  Future<Either<Failure, bool>> addProduct(
      {String productname,
      String description,
      bool taxable,
      String photoLink});
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, bool>> deleteProduct({int productId});
  Future<Either<Failure, Product>> getProductDetails({int productId});
  //  Future<Either<Failure, bool>> changeProductDetails({int productId});

}
