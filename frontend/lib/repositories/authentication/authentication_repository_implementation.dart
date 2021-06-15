import 'package:either_option/either_option.dart';
import 'package:graphql/client.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../datasources/authentication/authentication_remote_datasource.dart';
import '../../models/user.dart';
import 'authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  AuthenticationRepository({this.remote});

  final AuthenticationRemoteDataSource remote;

  @override
  Future<Either<Failure, User>> login({String email, String password}) async {
    try {
      if (await NetworkInfo.getInstance().isConnected()) {
        final data = await remote.login(email: email, password: password);
        return Right(data);
      } else {
        throw NoConnectionException();
      }
    } on OperationException catch (e) {
      return Left(OperationFailure(
        e.graphqlErrors.isNotEmpty
            ? e.graphqlErrors.first?.message
            : "No connection.",
      ));
    } on NoResultsFoundException {
      return Left(NoResultsFoundFailure());
    } on NoConnectionException {
      return Left(NoConnectionFailure());
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final data = await remote.logout();
      return Right(data);
    } catch (e) {
      print(e);
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signup(
      {String name, String email, String password}) async {
    try {
      if (await NetworkInfo.getInstance().isConnected()) {
        final data = await remote.signup(
          name: name,
          email: email,
          password: password,
        );
        return Right(data);
      } else {
        throw NoConnectionException();
      }
    } on OperationException catch (e) {
      return Left(OperationFailure(e.graphqlErrors.first.message));
    } on NoResultsFoundException {
      return Left(NoResultsFoundFailure());
    } on NoConnectionException {
      return Left(NoConnectionFailure());
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> getUser() async {
    try {
      if (await NetworkInfo.getInstance().isConnected()) {
        final data = await remote.getUser();
        return Right(data);
      } else {
        throw NoConnectionException();
      }
    } on OperationException catch (e) {
      return Left(OperationFailure(e.graphqlErrors.first.message));
    } on NoResultsFoundException {
      return Left(NoResultsFoundFailure());
    } on NoConnectionException {
      return Left(NoConnectionFailure());
    } on Exception {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnhandledFailure());
    }
  }
}
