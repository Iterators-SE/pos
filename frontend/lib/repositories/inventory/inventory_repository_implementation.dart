import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/inventory/inventory_local_datasource.dart';
import '../../datasources/inventory/inventory_remote_datasource.dart';
import '../../features/inventory/models/new_product.dart';
import '../../features/inventory/models/new_variant.dart';
import '../../models/product.dart';
import 'inventory_repository.dart';

class InventoryRepository implements IInventoryRepository {
  final InventoryRemoteDataSource remote;
  final InventoryLocalDataSource local;
  final NetworkInfo network;

  InventoryRepository(
      {@required this.remote, @required this.local, @required this.network});

  @override
  Future<Either<Failure, Product>> addProduct({NewProduct product}) async {
    if (await network.isConnected()) {
      try {
        print("this thing ran");
        final data = await remote.addProduct(product: product);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }

    return Left(UnhandledFailure());
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({int productId}) async {
    if (await network.isConnected()) {
      try {
        final data = await remote.deleteProduct(productId: productId);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }

    return Left(UnhandledFailure());
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await network.isConnected()) {
      try {
        final data = await remote.getProducts();
        print(await data);
        await local.cacheProducts(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } else {
      try {
        final data = await local.getProducts();
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails({int productId}) async {
    if (await network.isConnected()) {
      try {
        final data = await remote.getProductDetails(productId: productId);
        await local.cacheProduct(data);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } else {
      try {
        final data = await local.getProductDetails(productId: productId);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }
  }

  @override
  @override
  Future<Either<Failure, bool>> changeProductDetails({Product product}) async {
    if(await network.isConnected()){
      try {
        final data = await remote.changeProductDetails(product: product);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    }

    return Left(UnhandledFailure());
  }

  @override
  Future<Either<Failure, bool>> addVariant({NewVariant variant}) async {
    if(await network.isConnected()){  
      try {
        final data = await remote.addVariant(variant: variant);
        return Right(data);
      } on OperationException catch (e) {
        return Left(OperationFailure(e.graphqlErrors.first.message));
      } on NoResultsFoundException {
        return Left(NoResultsFoundFailure());
      } on Exception {
        return Left(ServerFailure());
      } catch (e) {
        return Left(UnhandledFailure());
      }
    } 

    return Left(UnhandledFailure());
  }
}
