import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/inventory/inventory_datasource.dart';
import '../../features/inventory/models/new_product.dart';
import '../../features/inventory/models/new_variant.dart';
import '../../models/product.dart';
import '../../models/product_variant.dart';

abstract class IInventoryRepository {
  final IInventoryRemoteDataSource remote;
  final IInventoryLocalDataSource local;
  final NetworkInfo network;

  const IInventoryRepository(
      {@required this.remote, @required this.local, @required this.network});

  Future<Either<Failure, bool>> addProduct({NewProduct product}); //done
  Future<Either<Failure, List<Product>>> getProducts(); //done
  Future<Either<Failure, bool>> deleteProduct({int productId}); //done
  Future<Either<Failure, Product>> getProductDetails({int productId}); // done
  Future<Either<Failure, bool>> changeProductDetails({Product product}); // done

  Future<Either<Failure, bool>> addVariant({
    NewVariant variant, int productId
  }); //done
  Future<Either<Failure, bool>> editVariant({ProductVariant variant}); //done
  Future<Either<Failure, bool>> deleteVariant({int productVariantId}); //done
  Future<Either<Failure, bool>> deleteAllVariants({int productId}); //done
}
