import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';

import '../core/error/exception.dart';
import '../core/error/failure.dart';
import '../datasources/authentication/authentication_datasource.dart';
import '../models/user.dart';
import 'authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({this.remote});

  final IAuthenticationDataSource remote;

  @override
  Future<Either<Failure, User>> login({String email, String password}) async {
    try {
      final data = await remote.login(email: email, password: password);
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
  Future<Either<Failure, void>> logout() async {
    try {
      final data = await remote.logout();
      return Right(data);
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signup(
      {String name, String email, String password}) async {
    try {
      final data = await remote.signup(
        name: name,
        email: email,
        password: password,
      );
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
}
