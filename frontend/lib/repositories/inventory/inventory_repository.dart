import 'package:either_option/either_option.dart';
import 'package:meta/meta.dart';

import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/inventory/inventory_datasource.dart';
import '../../features/inventory/models/new_product.dart';
import '../../features/inventory/models/new_variant.dart';
import '../../models/product.dart';

abstract class IInventoryRepository {
  final IInventoryRemoteDataSource remote;
  final IInventoryLocalDataSource local;
  final NetworkInfo network;

  const IInventoryRepository(
      {@required this.remote, @required this.local, @required this.network});

  Future<Either<Failure, Product>> addProduct({NewProduct product});
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, bool>> deleteProduct({int productId});
  Future<Either<Failure, Product>> getProductDetails({int productId});
  Future<Either<Failure, bool>> changeProductDetails({Product product});

  Future<Either<Failure, bool>> addVariant({NewVariant variant});
}
