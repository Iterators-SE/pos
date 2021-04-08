
import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../datasources/inventory/product_variant.dart/product_variant_datasource.dart';
import '../../models/product_variant.dart';
import 'product_variant_repository.dart';

class ProductVariantRepository implements AbstractProductVariantRepository{
  final ProductVariantDataSource remote;

  ProductVariantRepository({this.remote});
  @override
  Future<Either<Failure, bool>> addVariant({
    String variantName,
     int price,
      int quantity,
       int productID})async {
         try{
           final data = await remote.addVariant(
             variantName: variantName,
             price: price,
             quantity: quantity,
             productID: productID
           );
           return Right(data);
         }on OperationException catch(e){
           return Left(OperationFailure(e.graphqlErrors.first.message));
         }on NoResultsFoundException{
           return Left(NoResultsFoundFailure());
         }on Exception{
           return Left(ServerFailure());
         }catch (e){
           return Left(UnhandledFailure());
         }
    }
  
    @override
    Future<Either<Failure, List<ProductVariant>>> getVariants({
      int productID
      }) async {
      try{
        final data = await remote.getVariants(productid: productID);
        return Right(data);
      }on OperationException catch (e) {
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
    Future<Either<Failure, bool>> deleteVariant({int variantid}) async {
      try{
        final data = await remote.deleteVariant(id: variantid);
        return Right(data);
      }on OperationException catch (e) {
      return Left(OperationFailure(e.graphqlErrors.first.message));
    } on NoResultsFoundException {
      return Left(NoResultsFoundFailure());
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }
  
}