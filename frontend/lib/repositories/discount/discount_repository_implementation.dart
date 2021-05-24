
import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../datasources/discount/discounts_datasource.dart';
import '../../models/discounts.dart';
import 'discount_repository.dart';

class IDiscountRepository implements DiscountRepository{
  final DiscountDataSource remote;

  IDiscountRepository({this.remote});

  @override
  Future<Either<Failure, Discount>> getDiscount({
    int id
    })async {
         try{
           final data = await remote.getDiscount(
             id : id
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
  Future<Either<Failure, List<Discount>>> getDiscounts({
    List<int> id
    })async {
         try{
           final data = await remote.getDiscounts(
             id: id
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
  Future<Either<Failure, bool>> createGenericDiscount({
    String description,
    int percentage,
    List<int> products
    })async {
         try{
           final data = await remote.createGenericDiscount(
             description: description,
             percentage: percentage,
             products: products             
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
  Future<Either<Failure, Discount>> createCustomDiscount({
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
    })async {
         try{
           final data = await remote.createCustomDiscount(
             description: description,
             percentage: percentage,
             products: products,
             endDate: endDate,
             startDate: startDate,
             endTime: endTime,
             startTime: startTime            
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
  Future<Either<Failure, Discount>> updateGenericDiscount({
    int id,
    String description,
    int percentage,
    List<int> products
    })async {
         try{
           final data = await remote.updateGenericDiscount(
             id: id,
             description: description,
             percentage: percentage,
             products: products             
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
  Future<Either<Failure, Discount>> updateCustomDiscount({
    int id,
    String description,
    int percentage,
    List<int> products,
    DateTime endDate,
    DateTime startDate,
    String endTime,
    String startTime,
    })async {
         try{
           final data = await remote.updateCustomDiscount(
             id: id,
             description: description,
             percentage: percentage,
             products: products,
             endDate: endDate,
             startDate: startDate,
             endTime: endTime,
             startTime: startTime            
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
  
  Future<Either<Failure, bool>> deleteDiscount({
    int id
    })async {
         try{
           final data = await remote.deleteDiscount(
             id : id
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
}