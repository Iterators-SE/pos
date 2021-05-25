import 'package:either_option/either_option.dart';
import '../../core/error/failure.dart';
import '../../models/product.dart';

abstract class IInventoryRepository {
  Future<Either<Failure, int>> addProduct({
    String productName,
    String description,
    bool isTaxable,
    String photoLink,
  });

  Future<Either<Failure, List<Product>>> getProducts();
  
  Future<Either<Failure, bool>> deleteProduct({int productId});

  Future<Either<Failure, Product>> getProductDetails({int productId});

  Future<Either<Failure, bool>> changeProductDetails({
    int productId,
    String productName,
    String description,
    bool isTaxable,
    String photoLink,
  });
}
