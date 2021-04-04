import 'package:either_option/either_option.dart';
import 'package:frontend/datasources/inventory/inventory_datasource.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/repositories/inventory_repository.dart';
import 'package:graphql/client.dart';

import '../core/error/exception.dart';
import '../core/error/failure.dart';
import '../datasources/authentication/authentication_datasource.dart';
import '../models/user.dart';

class InventoryRepository implements AbstractInventoryRepository {
  final InventoryDataSource remote;

  InventoryRepository({this.remote});

  @override
  Future<Either<Failure, bool>> addProduct(
      {String productname,
      String description,
      bool taxable,
      String photoLink}) async {
    try {
      final data = await remote.addProduct(
          productname: productname,
          description: description,
          taxable: taxable,
          photoLink: photoLink);
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

  @override
  Future<Either<Failure, bool>> deleteProduct({int productId}) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProductDetails({int productId}) {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }
}
